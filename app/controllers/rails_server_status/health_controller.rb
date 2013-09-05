require_dependency "rails_server_status/application_controller"

module RailsServerStatus
  class HealthController < ApplicationController

    def show
      @health_check = RailsServerStatus::HealthCheck.new

      respond_to do |format|
        format.html { render text: @health_check.as_text }
        format.json { render json: @health_check.as_json }
      end
    end

  end
end
