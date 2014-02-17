U8this::Application.routes.draw do
  # Ajax calls to create and modify Servings.
  post '/servings/create', to: 'servings#create'
  post '/servings/update/', to: 'servings#update'
  post '/servings/destroy/', to: 'servings#destroy'
  post '/servings/move_up/', to: 'servings#move_up'
  post '/servings/move_down/', to: 'servings#move_down'

  # Top-level pages.
  get '/' => 'pages#home'
  get '/testdrive' => 'pages#testdrive'
  # get '/about' => 'pages#about', format: false
  
  # Daily food logs.
  get '/today' => 'days#today', format: false
  get '/:year/:month/:day', to: 'days#show', constraints: { year: /\d.+/, month: /\d.+/, 
    day: /\d.+/ }, format: false
  
  resource :user_sessions, path: 'session', except: ['edit'], format: false
  
  resource :users, path: 'account', format: false
  get '/user/list_foods/', to: 'users#list_foods'
end
