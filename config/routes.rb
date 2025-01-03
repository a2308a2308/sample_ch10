Rails.application.routes.draw do
  root   "static_pages#home"
  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users
  
  # 質問関連のルート
  get 'questions/start', to: 'questions#start', as: :start_questions # 先に記述
  resources :questions, only: [:show] do
    post "answer", on: :member # POST /questions/:id/answer
  end
  get 'summary', to: 'questions#summary'
end
