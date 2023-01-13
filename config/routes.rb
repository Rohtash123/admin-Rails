Rails.application.routes.draw do
  devise_for :accounts
  # root "application#home"
  root "articles#index"
  resources :accounts
  resources :articles do
    resources :comments
    post "/comments/:id/update", as:"update_Comment", to: "comments#update"
  end
  resources :likes, only: [:create, :destroy]
  post "/", as:"create", to: "articles#create"

  get  "home" , as: "home" ,to: "application#home"
end

