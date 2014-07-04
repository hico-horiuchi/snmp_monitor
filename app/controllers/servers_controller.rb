class ServersController < ApplicationController
  before_action :load_server
  before_action :authenticate_user!


  def index
    @servers = current_user.servers
  end

  def show
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
end
