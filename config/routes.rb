Rails.application.routes.draw do
  resources :boards do
    resources :comments, except: [:index,:show,:new]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'boards#index'
end
