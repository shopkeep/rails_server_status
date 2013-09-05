Rails.application.routes.draw do
  mount RailsServerStatus::Engine => "/server-status"
end
