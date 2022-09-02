Rails.application.routes.draw do
  resources :hashtags, only: %i[show], param: :tag
  root to: 'questions#index'
  
  resources :questions do
    member do
      put 'hide'
    end
  end

  resource :session, only: %i[new create destroy]

  resources :users, except: %i[index], param: :nickname
end
