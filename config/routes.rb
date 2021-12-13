Rails.application.routes.draw do
  resources :transactions
  resources :inventories
  resources :banner_items
  resources :likes
  resources :users
  resources :items
  resources :banners
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'main' ,to: 'users#main'
  post 'login' ,to: 'users#login'
  get 'banner/:id' ,to: 'users#banner'
  get 'search/:name' ,to: 'users#eachbanner'
  get 'inventory' ,to: 'users#inventory'
  get 'result/:name/:type/:id' ,to: 'users#result'
  get 'market' ,to: 'users#market'
  get 'buy/:inventory_id/:id' ,to: 'users#buy'
end
