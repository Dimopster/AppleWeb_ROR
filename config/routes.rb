Rails.application.routes.draw do
    root to: redirect('/login')
    get "/login", to: "login#person"
    get "/registration", to: "registration#person"
    get "/presentation", to: "presentation#gadget"

    resources :users, only: [:create]
    post '/registration', to: 'sessions#create'
end