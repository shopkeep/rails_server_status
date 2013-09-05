module ServerStatus
  class HealthCheck

    def database_status
      @database_status ||= if ActiveRecord::Base.connection_pool.connected?
        'up'
      else
        'down'
      end
    end

    def process_id
      @process_id ||= Process.pid
    end

    def process_uptime
      @process_uptime ||= Process.times.utime
    end

    def ip_address
      @ip_address ||= IPSocket.getaddress(Socket.gethostname)
    end

    def as_json
      {
        database: database_status,
        pid: process_id,
        uptime: process_uptime,
        ip_address: ip_address
      }.to_json
    end

    def as_text
      [database_status, process_id, process_uptime, ip_address].join(" ")
    end

  end
end