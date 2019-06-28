Rails.application.routes.draw do

  resources :artists do
      # nested resource for posts
      resources :songs, only: [:index, :show]
    end

    resources :songs

    root 'songs#index'
end
