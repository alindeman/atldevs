Rails.application.routes.draw do
  root to: "invitations#new"

  resources :invitations, only: [:new, :create] do
    get :enqueued, on: :collection
  end

  require "sidekiq/web"
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
  end if Rails.env.production?
  mount Sidekiq::Web, at: "/sidekiq"
end
