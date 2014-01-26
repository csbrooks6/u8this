U8this::Application.routes.draw do
  # Top-level pages.
  get '/' => 'pages#home'
  get '/about' => 'pages#about'
  
  # Daily food logs.
  get '/:year/:month/:day', to: 'days#show', constraints: { year: /\d.+/, month: /\d.+/, 
    day: /\d.+/ }
  get '/today', to: 'days#today'
  
  resource :user_sessions, path: 'session'
  
  resource :users, path: 'account'
end
