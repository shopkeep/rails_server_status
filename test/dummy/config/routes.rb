Rails.application.routes.draw do
  mount ServerStatus::Engine => "/server-status"
end
