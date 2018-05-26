Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions do
    patch 'create_vote', on: :member
    resources :answers do
      patch 'award', on: :member
    end
  end

  resources :answers do
    patch 'create_vote', on: :member
  end

  resources :attachments

  root to: "questions#index"

end
