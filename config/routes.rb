Rails.application.routes.draw do
  devise_for :students
  # devise_for :students
  devise_for :book_keepers
  devise_scope :book_keeper do
  	get '/book_keepers/sign_out' => 'devise/sessions#destroy'
  end

  get '/allbooks', to: 'book_keepers#show_books'
  resources :book_keepers, only: [:show]
  resources :books, only: [:new,:create,:destroy,:index]
  root 'welcome#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
