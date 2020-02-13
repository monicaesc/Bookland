Rails.application.routes.draw do
  devise_for :users
  get "/", to: "books#index"
  get "/books/overview", to: "books#overview"
  get "/books/favorite", to: "books#favorite"
  get "/books", to: "books#overview"
  get "/users/about_me", to: "users#about_me"
  get "/users/edit_me", to: "users#edit"
  patch "/users/:id", to: "users#update"
  #get "/books/mark/:book_id", to: "books#mark", as: "mark"
  resources :books do
    resources :favorites
  end

  # resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# Users
# id
# name
# e-mail
#
# Books
# id
# title
# author
# year
# Genre
# description
# image
#
# UsersBooks
# user_id
# book_id


# paths
# localhost/book/id/show
# /books/id/edit
# /books/new/new
# /books/index
