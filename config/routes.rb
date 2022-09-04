Rails.application.routes.draw do
  root to: 'questions#index'
  
  resources :questions do
    member do
      put 'hide'
    end
  end
  resources :hashtags, only: %i[show], param: :tag
  
  resource :session, only: %i[new create destroy]
  
  resources :users, except: %i[index], param: :nickname
end
