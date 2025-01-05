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
  get 'questions/start', to: 'questions#start', as: :start_questions
  resources :questions, only: [:show] do
    post "answer", on: :member
  end
  get 'summary', to: 'questions#summary'

  # ランキング関連のルートを追加
  resources :rankings, only: [:index]
end
