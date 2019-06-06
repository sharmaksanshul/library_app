Rails.application.routes.draw do
  devise_for :students
  devise_for :book_keepers
  # devise_scope :student do
  #   get '/students/sign_out' => 'devise/sessions#destroy'
  # end
  resources :book_keepers,  only: [:show]
  resources :students,      only: [:show] do
    member do
      get :issue_history
    end
  end
  resources :issue_details, only: [:create, :edit, :update]
  resources :books do
    member do
      get :issue, :issue_record
    end
  end
  root 'welcome#home'
  resources :checkouts,  only: [:new, :create, :show]
  get  '/find_student',   to: 'book_keepers#find_student'
  get  '/student_issue',   to: 'students#current_active_issue'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
