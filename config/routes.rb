Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions, shallow: true do
    patch 'create_vote', on: :member

    resources :answers do
      patch 'award', on: :member
      patch 'create_vote', on: :member
      
      resources :comments
    end

  end

  resources :attachments

  root to: "questions#index"

  mount ActionCable.server => '/cable'
end
