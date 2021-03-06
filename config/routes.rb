Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "user/registrations" }
  root 'home#index'

  resources :game, :only => [:index, :new] do
  end

  resources :gems, :only => [] do
    get :move, :on => :collection
  end

  resources :users, :only => [:show, :edit, :update] do
    put :remove_friend, :on => :member
    put :add_friend, :on => :member
    post :send_invite_to_game, :on => :member
  end
end
