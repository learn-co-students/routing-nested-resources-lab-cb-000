Rails.application.routes.draw do
  root 'artists#index'
  resources :artists do
    resources :songs, only: [:index, :show]
  end

  resources :songs
end
