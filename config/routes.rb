Rails.application.routes.draw do
  # devise_for :users
  namespace :api do
    resources :users, only: [] do
      collection do
          post :sign_up
          post :sign_in
          delete :sign_out
        end
      end
    resources :rides, only: [:create, :index] do
      member do
        post :accept_ride
      end
    end

    resources :drivers, only: [:index] do
      member do
        post :rate
      end
    end
  end
end
