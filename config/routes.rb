Rails.application.routes.draw do
  root 'tasks#index'

  get '/export', to: 'tasks#excel_export'

  post '/filter', to: 'tasks#filter'
  
  get '/new', to: 'tasks#new'

  post '/create', to: 'tasks#create'

  put '/update/:id', to: 'tasks#update'

  get '/due', to: 'tasks#due'

  get '/all', to: 'tasks#all'

  delete '/destroy/:id', to: 'tasks#destroy', as: 'destroy'

  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
