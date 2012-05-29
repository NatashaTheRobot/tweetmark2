Tweetmark::Application.routes.draw do
    resources :users
    root to: 'static_pages#home'
    match '/about',   to: 'static_pages#about'
    match "/auth/:provider/callback" => "sessions#create"
    match "/signout" => "sessions#destroy", :as => :signout
end
