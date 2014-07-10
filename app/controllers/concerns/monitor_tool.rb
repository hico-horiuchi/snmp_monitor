module MonitorTool
  def snmp_init( ip_address, community )
    @manager = SNMP::Manager.new( host: ip_address, community: community )
  end

  def get_load_average
    la_load_1 = 0
    begin
      # response = @manager.get( ['1.3.6.1.4.1.2021.10.1.3.1'] )
      # response.each_varbind { |vb| la_load_1 = vb.value.to_f }
      # la_load_1 > @server.assign_cpu_core ? 1.0 : la_load_1
      rand 0.0...0.3
    rescue SNMP::RequestTimeout, NoMethodError
      nil
    end
  end

  def get_memory_usage
    mem_total_real = 0, mem_avail_real = 0, mem_buffer = 0, mem_cached = 0
    begin
      response = @manager.get( ['1.3.6.1.4.1.2021.4.5.0'] )
      response.each_varbind { |vb| mem_total_real = vb.value.to_f }
      response = @manager.get( ['1.3.6.1.4.1.2021.4.6.0'] )
      response.each_varbind { |vb| mem_avail_real = vb.value.to_f }
      response = @manager.get( ['1.3.6.1.4.1.2021.4.14.0'] )
      response.each_varbind { |vb| mem_buffer = vb.value.to_f }
      response = @manager.get( ['1.3.6.1.4.1.2021.4.15.0'] )
      response.each_varbind { |vb| mem_cached = vb.value.to_f }
      ( mem_total_real - mem_avail_real - mem_buffer - mem_cached ) / mem_total_real
    rescue SNMP::RequestTimeout, NoMethodError
      nil
    end
  end
end
