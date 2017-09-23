Rails.application.routes.draw do

  resources :pages do
  post 'revert', :on => :member
end

  get 'search', to: 'search_engine#search'

  root :to => 'search_engine#search'

  get 'palabra/:lexeme', to: 'api/api#palabra'

  resources :words do
  post 'revert', :on => :member
end

  resources :variants do
  post 'revert', :on => :member
end

  resources :inline_forms_translations do
  post 'revert', :on => :member
end

  resources :inline_forms_keys do
  post 'revert', :on => :member
end

  resources :inline_forms_locales do
  post 'revert', :on => :member
end

  mount Ckeditor::Engine => '/ckeditor'
  resources :roles do
  post 'revert', :on => :member
end

  resources :locales do
  post 'revert', :on => :member
end

  devise_for :users, :path_prefix => 'auth'
  resources :users do
    post 'revert', :on => :member
end

get ':slug', to: 'pages#slug'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
