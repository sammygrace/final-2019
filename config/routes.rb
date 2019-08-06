Rails.application.routes.draw do

  devise_for :users

  root to: 'schools#index'

  resources :schools do
    resources :vendors
  end

  resources :vendors do
    get :claim, on: :member
  end

  mount LetterOpenerWeb::Engine, at: "/mailbox"

  resources :comments
  resources :schools
  resources :vendors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
