U8this::Application.routes.draw do
  # Top-level pages.
  get '/' => 'pages#home'
  get '/about' => 'pages#about', format: false
  
  # Daily food logs.
  get '/:year/:month/:day', to: 'days#show', constraints: { year: /\d.+/, month: /\d.+/, 
    day: /\d.+/ }, format: false
  post '/:year/:month/:day', to: 'days#add', constraints: { year: /\d.+/, month: /\d.+/, 
    day: /\d.+/ }, format: false
  
  resource :user_sessions, path: 'session', format: false
  
  resource :users, path: 'account', format: false
end
