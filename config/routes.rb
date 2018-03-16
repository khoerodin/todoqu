Rails.application.routes.draw do
  root 'tasks#index'

  post '/filter', to: 'tasks#filter'
  
  get '/new', to: 'tasks#new'

  post '/create', to: 'tasks#create'

  get '/edit/:id', to: 'tasks#edit', as: "edit"

  put '/update/:id', to: 'tasks#update', as: "update"

  get '/due', to: 'tasks#due'

  get '/all', to: 'tasks#all'

  delete '/destroy/:id', to: 'tasks#destroy', as: 'destroy'

  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
