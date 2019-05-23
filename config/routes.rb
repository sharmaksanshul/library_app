Rails.application.routes.draw do
  devise_for :students
  devise_for :book_keepers
  # devise_scope :student do
  #   get '/students/sign_out' => 'devise/sessions#destroy'
  # end
  resources :book_keepers,  only: [:show]
  resources :students,      only: [:show]
  resources :issue_details, only: [:create, :destroy]
  resources :books do
    member do
      get :issue
    end
  end
  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
