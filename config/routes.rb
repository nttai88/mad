Mad2::Application.routes.draw do
  resources :projects do
    resources :comments
    resources :members do
      member do
        delete :remove
      end
    end

    member do
      post 'rate'
      post 'save'
      put 'save'
      delete 'remove_attach'
    end

    collection do
      get :recent
    end
  end

  devise_scope :refinery_user do
    get '/users/register' => 'refinery/users#new', :as => :new_refinery_user_registration
    post '/users/register' => 'refinery/users#create', :as => :refinery_user_registration
    get '/users/sign_in' => 'refinery/sessions#new', :as => :new_refinery_user_session
    post '/users/sign_in' => 'refinery/sessions#create', :as => :refinery_user_session
    get '/users/password/new' => 'refinery/passwords#new', :as => :new_refinery_user_password
    get '/users/password' => 'refinery/passwords#create', :as => :refinery_user_password
    get '/users/confirmation' => 'refinery/confirmations#show', :as => :refinery_user_confirmation
    get '/users/:id/edit' => 'refinery/users#edit', :as => :edit_refinery_user
    post '/users/:id/update' => 'refinery/users#update', :as => :update_refinery_user
    post '/users/check_username_availability' => 'refinery/users#check_username_availability', :as => :check_username_availability
  end

  mount Messaging::Engine => "/messaging"

  mount Refinery::Core::Engine => "/"
end
