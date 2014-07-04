class ServersController < ApplicationController
  before_action :load_server
  before_action :authenticate_user!

  def index
    @servers = current_user.servers
  end

  def show
    @manager = SNMP::Manager.new( host: @server.ip_address, community: @server.community )

    cpu_usage = get_cpu_usage * 100
    @cpu_usage = make_usage_graph( 'CPU',  "#{sprintf( '%.2f', cpu_usage )}%", cpu_usage, '#da4f49' )

    memory_usage = get_memory_usage * 100
    @memory_usage = make_usage_graph( 'MEMORY',  "#{sprintf( '%.2f', memory_usage )}%", memory_usage, '#5bb75b' )

    power_usage = @server.cpu_tdp / @server.max_cpu_core * @server.assign_cpu_core * cpu_usage / 100
    @power_usage = make_usage_graph( 'Power', "#{sprintf( '%.2f', power_usage )}W", power_usage / @server.cpu_tdp * 100, '#faa732' )
  end

  def new
    render :show_modal_form
  end

  def create
    @server = current_user.servers.create( server_params )
    @result = @server.save
    @server = nil unless @result
    flash[:notice] = '登録しました。' if @result
  end

  def edit
    render :show_modal_form
  end

  def update
    @result = @server.update( server_params )
    @server = nil unless @result
    flash[:notice] = '更新しました。' if @result
  end

  def delete
    render :show_modal_delete
  end

  def destroy
    @result = @server.destroy
    @server = nil unless @result
    flash[:notice] = '削除しました。' if @result
    flash[:alert] = '削除できませんでした。' unless @result
    render :reload
  end

  private

  def load_server
    @server = Server.id_is( params[:id] ) if params[:id]
  end

  def server_params
    params.require( :server ).permit( :ip_address, :community, :max_cpu_core, :assign_cpu_core, :cpu_tdp )
  end

  def make_usage_graph( factor, title, usage, color )
    LazyHighCharts::HighChart.new('graph') do |f|
      f.chart type: 'pie'
      f.plotOptions pie: { innerSize: '70%', colors: [color, '#393939'], dataLabels: { enabled: false } }
      f.title text: title, verticalAlign: 'middle', floating: true
      f.series name: "#{factor} Usage", data: [['Busy', usage], ['Idle', 100 - usage]]
      f.legend enabled: false
      f.tooltip enabled: false
    end
  end

  def get_cpu_usage
    # la_load_1 = 0
    # response = @manager.get( ['1.3.6.1.4.1.2021.10.1.3.1'] )
    # response.each_varbind { |vb| la_load_1 = vb.value.to_f }
    # la_load_1 > @server.assign_cpu_core ? 1.0 : la_load_1
    0.35
  end

  def get_memory_usage
    mem_total_real = 0, mem_avail_real = 0, mem_buffer = 0, mem_cached = 0
    response = @manager.get( ['1.3.6.1.4.1.2021.4.5.0'] )
    response.each_varbind { |vb| mem_total_real = vb.value.to_f }
    response = @manager.get( ['1.3.6.1.4.1.2021.4.6.0'] )
    response.each_varbind { |vb| mem_avail_real = vb.value.to_f }
    response = @manager.get( ['1.3.6.1.4.1.2021.4.14.0'] )
    response.each_varbind { |vb| mem_buffer = vb.value.to_f }
    response = @manager.get( ['1.3.6.1.4.1.2021.4.15.0'] )
    response.each_varbind { |vb| mem_cached = vb.value.to_f }
    ( mem_total_real - mem_avail_real - mem_buffer - mem_cached ) / mem_total_real
  end
end
