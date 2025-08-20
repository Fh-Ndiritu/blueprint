Rails.application.routes.draw do

  resources :groups, shallow: true do
    # https://guides.rubyonrails.org/routing.html
    # this defines non-shallow routes that rely on group id such as new, create, create
    # the rest like show, edit, update, destroy are defined without group id since they are persisted in DB already
    resources :messages

    # we can do a third level nesting here so that a message belongs to message and then group
    # it is frowned upon due to level of nesting
    resources :group_users, except: %i[index show update edit]
  end

  # this expects a reply action in messages as reply_message_path
  resources :messages, only: [] do
    get 'reply', on: :member
  end

  devise_for :users

  # this would be useful if only current user can view their own profile
  # this will not need a user id
  resource :profile, only: %i[edit update show]
  resolve('Profile'){[:profile]}

  # make profiles publicly accessibly
  # this will need a user_id field
  resources :users do
     resource :profile, only: [ :show ]
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  get "/welcome", to: 'home#welcome'
  root "home#dashboard"
end
