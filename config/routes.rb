Rails.application.routes.draw do
  devise_for :managers
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }
  resources :admins, only:[:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#top'
  resources :locales, only:[:index, :new, :create, :show]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
