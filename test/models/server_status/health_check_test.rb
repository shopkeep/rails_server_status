require 'test_helper'

module ServerStatus
  class HealthCheckTest < ActiveSupport::TestCase

    def test_database_status_when_connected
      ActiveRecord::Base.expects(:connection_pool).returns(mock(connected?: true))
      assert_equal 'up', ServerStatus::HealthCheck.new.database_status
    end

    def test_database_status_when_disconnected
      ActiveRecord::Base.expects(:connection_pool).returns(mock(connected?: false))
      assert_equal 'down', ServerStatus::HealthCheck.new.database_status
    end

    def test_process_id
      Process.expects(:pid).returns('fake.pid')
      assert_equal 'fake.pid', ServerStatus::HealthCheck.new.process_id
    end

    def test_process_uptime
      Process.expects(:times).returns(mock(utime: 'fake.uptime'))
      assert_equal 'fake.uptime', ServerStatus::HealthCheck.new.process_uptime
    end

    def test_ip_address
      IPSocket.expects(:getaddress).returns('fake.ip.address')
      assert_equal 'fake.ip.address', ServerStatus::HealthCheck.new.ip_address
    end

    def test_as_json
      ActiveRecord::Base.expects(:connection_pool).returns(mock(connected?: true))
      Process.expects(:pid).returns('fake.pid')
      Process.expects(:times).returns(mock(utime: 'fake.uptime'))
      IPSocket.expects(:getaddress).returns('fake.ip.address')

      health_check = ServerStatus::HealthCheck.new

      expected_json = {
        database: "up",
        pid: "fake.pid",
        uptime: "fake.uptime",
        ip_address: "fake.ip.address"
      }.to_json

      assert_equal expected_json, health_check.as_json
    end

    def test_as_text
      ActiveRecord::Base.expects(:connection_pool).returns(mock(connected?: true))
      Process.expects(:pid).returns('fake.pid')
      Process.expects(:times).returns(mock(utime: 'fake.uptime'))
      IPSocket.expects(:getaddress).returns('fake.ip.address')

      health_check = ServerStatus::HealthCheck.new

      assert_equal "up fake.pid fake.uptime fake.ip.address", health_check.as_text
    end
  end
end