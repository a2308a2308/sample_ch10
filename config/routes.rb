Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users

  # 質問関連のルート
  get 'questions/start', to: 'questions#start', as: :start_questions # 先に記述
  get 'questions/start_level_1', to: 'questions#start_level_1', as: :start_level_1_questions # TODO: refactoring (copy-pasta).
  get 'questions/start_level_2', to: 'questions#start_level_2', as: :start_level_2_questions # TODO: refactoring (copy-pasta).
  get 'questions/start_level_3', to: 'questions#start_level_3', as: :start_level_3_questions # TODO: refactoring (copy-pasta).
  resources :questions, only: [:show] do
    post 'answer', on: :member # POST /questions/:id/answer
    # items を questions にネスト
    resources :items, only: %i[index create show]
  end
  get 'summary', to: 'questions#summary'
  # ランキング関連のルートを追加
  resources :rankings, only: [:index]
end
