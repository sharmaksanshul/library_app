Rails.application.routes.draw do
  devise_for :students
  # devise_for :students
  devise_for :book_keepers
  # devise_scope :book_keeper do
  # 	get '/book_keepers/sign_out' => 'devise/sessions#destroy'
  # end
  # devise_scope :student do
  #   get '/students/sign_out' => 'devise/sessions#destroy'
  # end

  get '/availbooks', to: 'students#show_avail_books'
  get '/allbooks', to: 'book_keepers#show_books'
  resources :book_keepers, only: [:show]
  resources :students, only: [:show]
  resources :books, only: [:new,:create,:destroy,:index]
  root 'welcome#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
