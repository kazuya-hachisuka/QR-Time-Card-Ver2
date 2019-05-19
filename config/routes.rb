Rails.application.routes.draw do
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }
  devise_for :managers, controllers: {
    registrations:'managers/registrations',
    sessions: 'managers/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#top'

  resources :admins, only:[:show] do
    get '/managers/sing_up' => 'managers#new'
    post '/managers/create' => 'managers#create'
  end

  resources :managers, only:[:show]
  resources :locales, only:[:index, :new, :create, :show]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
