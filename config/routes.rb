Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      match "/users" => "users#update", via: :put
      match "/users" => "users#destroy", via: :delete
      resources :users, except: %i[edit update destroy show] do
        collection do
          get "/edit", action: :edit
        end
      end
    end
  end
end
