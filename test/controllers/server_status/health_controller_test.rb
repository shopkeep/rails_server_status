require 'test_helper'

module ServerStatus
  class HealthControllerTest < ActionController::TestCase

    def setup
      @mocked_health_check = mock
    end

    def test_show_as_text
      ServerStatus::HealthCheck.expects(:new).returns(@mocked_health_check)
      @mocked_health_check.expects(:as_text)

      get :show, use_route: 'health'
      assert_response :success
    end

    def test_show_as_json
      ServerStatus::HealthCheck.expects(:new).returns(@mocked_health_check)
      @mocked_health_check.expects(:as_json)

      get :show, use_route: 'health', format: :json
      assert_response :success
    end
  end
end
