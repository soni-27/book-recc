Rails.application.routes.draw do
  devise_for :users
  root "shelves#index"
  resources :shelves do
    resources :books
  end
  resources :books
end
