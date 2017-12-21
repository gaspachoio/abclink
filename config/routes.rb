Rails.application.routes.draw do

  resources :pages do
  post 'revert', :on => :member
end

  get 'search', to: 'search_engine#search'
  get 'translate', to: 'orthographic_translator#translate'

  root :to => 'search_engine#search'

  get 'palabra/:lexeme', to: 'api/api#palabra'

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
end
