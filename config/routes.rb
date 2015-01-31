Rails.application.routes.draw do
  root to: "invitations#new"

  resources :invitations, only: [:new, :create] do
    get :enqueued, on: :collection
  end
end
