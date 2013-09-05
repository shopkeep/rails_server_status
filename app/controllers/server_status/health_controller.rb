require_dependency "server_status/application_controller"

module ServerStatus
  class HealthController < ApplicationController

    def show
      @health_check = ServerStatus::HealthCheck.new

      respond_to do |format|
        format.html { render text: @health_check.as_text }
        format.json { render json: @health_check.as_json }
      end
    end

  end
end
