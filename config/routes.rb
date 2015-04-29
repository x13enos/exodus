Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "user/registrations" }
  root 'home#index'

  resources :game, :only => :index do
    get :starting_gems_position, :on => :collection
  end

  resources :gems, :only => [] do
    get :move, :on => :collection
  end

  resources :users, :only => [:show] do
    put :remove_friend, :on => :member
    put :add_friend, :on => :member
  end
end
