Rails.application.routes.draw do
  devise_for :users
  root 'static#home'

  resources :game, :only => [] do
    get :starting_gems_position, :on => :collection
  end

  resources :gems, :only => [] do
    get :move, :on => :collection
  end
end
