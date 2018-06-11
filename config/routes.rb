Rails.application.routes.draw do
  get 'users/index'

  get 'users/create'

  get 'users/update'

  get 'users/show'

  get 'users/destroy'

  get 'users/new'

 root 'static_pages#index'
end
