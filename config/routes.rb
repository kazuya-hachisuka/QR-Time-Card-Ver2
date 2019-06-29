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
  resources :locales, only:[:index, :new, :create, :show] do
    resources :staffs
  end

  #localeでのログイン/ログアウト
  get 'login', to: 'sessions#new' #mailとpasswordをnewで入力させる
  post 'login', to: 'sessions#create' #入力された情報を検証し、cookieにログイン情報を格納する
  delete 'logout', to: 'sessions#destroy' #ログアウトさせる
end
