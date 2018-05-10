Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'welcome#index'
    resources "articles"
    get '/users/check_email', to: 'users#check_email'
    get 'signup', to: 'users#new'
    resources "users", expect: [:index]
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'myArticle', to: 'articles#my'
    resources :categories
    
    resources "pictures"
#    get 'manage/:id', to: 'categories#index'
#    post 'manage/:id', to: 'categories#create'
#    delete 'manage/:id', to: 'categories#destroy'
#

end

