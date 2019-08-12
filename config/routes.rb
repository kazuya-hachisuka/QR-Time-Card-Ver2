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
    resources :staffs
  end

  resources :managers, only:[:show]

  resources :locales, only:[:index, :new, :create, :show] do
    resources :staffs, only:[:edit, :update]
  end
  resources :staffs do
    resources :works
      get 'punch_new' => 'works#punch_new', as: 'punch_new'
      post 'punch_in' => 'works#punch_in', as: 'punch_in'
      patch 'punch_out/:work_id/' => 'works#punch_out', as: 'punch_out'
  end

  post 'works/:work_id/work_breaks' => 'works#break_in', as: 'break_in'
  patch 'works/:work_id/work_breaks' => 'works#break_out', as: 'break_out'

  #localeでのログイン/ログアウト
  get 'login', to: 'sessions#new' #mailとpasswordをnewで入力させる
  post 'login', to: 'sessions#create' #入力された情報を検証し、cookieにログイン情報を格納する
  delete 'logout', to: 'sessions#destroy' #ログアウトさせる
end
