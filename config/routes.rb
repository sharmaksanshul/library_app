Rails.application.routes.draw do
  # devise_for :students
  devise_for :book_keepers
  devise_scope :book_keeper do
  	get '/book_keepers/sign_out' => 'devise/sessions#destroy'
  end

  get '/allbooks', to: 'book_keepers#showbooks'
 resources :book_keepers
  resources :books
  root 'welcome#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
