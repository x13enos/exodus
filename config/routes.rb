Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root 'home#index'

  resources :game, :only => :index do
    get :starting_gems_position, :on => :collection
  end

  resources :gems, :only => [] do
    get :move, :on => :collection
  end
end
