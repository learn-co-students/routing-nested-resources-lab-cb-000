Rails.application.routes.draw do
  resources :artists, only: [:index, :create, :new, :edit, :update, :destroy]
  resources :artists, only: [:show] do
    resources :songs, only: [:index, :show]
  end
  resources :songs
end
