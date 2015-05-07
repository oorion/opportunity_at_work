Rails.application.routes.draw do

  devise_for :users
  root "static_pages#home"
  get "/home", to: "static_pages#home", as: "home"
  get "/learn-more", to: "static_pages#learn_more", as: "learn_more"
  get "/tools-resources", to: "static_pages#tools_resources", as: "tools_resources"
  get "/techhire-locations", to: "static_pages#techhire_locations", as: "techhire_locations"
  get "/download", to: "static_pages#download", as: "download"
  get "/companies/welcome", to: "companies#welcome"
  get 'signup', to: "companies#new", as: :signup

  namespace :admin do
    resources :dashboard, only: [:index]
    get "/dashboard/new-admin", to: "dashboard#new_admin"
    post "/dashboard/create-admin", to: "dashboard#create_admin"
    get "/dashboard/cms-instructions", to: "dashboard#cms_instructions", as: "cms_instructions"
    resources :contents
    resources :videos
    resources :pdfs
    resources :techhire_locations
    resources :companies, except: [:create] do
      resources :notes, only: [:index, :create, :destroy]
    end
    namespace :static_pages do
      get "/home", to: "static_pages#home", as: "home"
      get "/learn_more", to: "static_pages#learn_more", as: "learn_more"
      get "/tools_resources", to: "static_pages#tools_resources", as: "tools_resources"
      get "/techhire_locations", to: "static_pages#techhire_locations", as: "techhire_locations"
    end
  end

  resources :companies, only: [:create, :show]
  resources :pdfs, only: [:show]
end
