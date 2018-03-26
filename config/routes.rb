Rails.application.routes.draw do
  resources :artists do #create a nested resource route to show all songs for an artists
    resources :songs, only: [:index, :show] #Restrict the nested songs routes to index and show actions only.
  end
  resources :songs
end
