Rails.application.routes.draw do
  resources :boards do
    resources :comments, except: [:index,:new,:edit,:update] do
      resources :replies, except: [:index, :show,:new,:edit,:update]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'boards#index'
end
