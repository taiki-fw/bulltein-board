Rails.application.routes.draw do
  resources :boards do
    resources :comments, except: [:index,:show,:new] do
      resources :replies
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'boards#index'
end
