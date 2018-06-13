Rails.application.routes.draw do
 root 'static_pages#home'
  get 'users', to: "users#index"
  get 'users/new', to: "users#new", as: "new_user"
  post 'users', to: "users#create"
  get 'users/:id', to: "users#show", as: "user"
  get 'users/:id/edit', to: "users#edit", as: "edit_user"
  patch 'users/:id', to: "users#update"
  delete 'users/:id', to: 'users#destroy'
end
  
 
