RolfMeier::Application.routes.draw do
  resources :menus do
    post :sort
  end

  resources :pages

  resources :pictures do
    post :sort
  end

  resources :galleries

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :path_names => {:sign_in => "login", :sign_out => "logout", :sign_up => "register"}
  resources :users, :only => [:show, :index]
end
