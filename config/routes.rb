Rails.application.routes.draw do

  root to: 'schools#index'

  resources :schools do
    resources :vendors
  end

  resources :schools
  resources :vendors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
