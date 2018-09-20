Rails.application.routes.draw do

  get 'sessions/new'

  get 'sessions/destroy'

=begin
 root 'static_pages#home'
  get 'users', to: "users#index"
  get 'users/new', to: "users#new", as: "new_user"
  post 'users', to: "users#create"
  get 'users/:id', to: "users#show", as: "user"
  get 'users/:id/edit', to: "users#edit", as: "edit_user"
  patch 'users/:id', to: "users#update"
  delete 'users/:id', to: 'users#destroy'

  get 'articles', to: "articles#index"
=end

	root 'static_pages#home'

	resources :users do 
		resources :articles
	end

  resources :articles

	get 'login', to: "sessions#new", as: "login"
  post 'login', to: "sessions#create"
	get 'logout', to: "sessions#destroy", as: "logout"

  resources :sessions
  resources :categories
end
  
 
