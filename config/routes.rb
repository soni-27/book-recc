Rails.application.routes.draw do
  devise_for :users
  root "shelves#index"
  resources :shelves do
    resources :books, only: [ :index, :show, :edit, :update, :destroy ]
  end
  resources :books, only: [ :index, :show, :edit, :update, :destroy ]
end
