Mad2::Application.routes.draw do
  scope "/:locale" do
    mount Messaging::Engine => '/messaging'
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
  end


  devise_scope :refinery_user do
    scope :path => 'users' do
      get 'register' => 'refinery/users#new', :as => :new_refinery_user_registration
      post 'register' => 'refinery/users#create', :as => :refinery_user_registration
      get 'sign_in' => 'refinery/sessions#new', :as => :new_refinery_user_session
      post 'sign_in' => 'refinery/sessions#create', :as => :refinery_user_session
      get 'sign_out', :to => "refinery/sessions#destroy", :as => :destroy_refinery_user_session
      get 'password/new' => 'refinery/passwords#new', :as => :new_refinery_user_password
      get 'password' => 'refinery/passwords#create', :as => :refinery_user_password
      get 'confirmation' => 'refinery/confirmations#show', :as => :refinery_user_confirmation
      get ':id/edit' => 'refinery/users#edit', :as => :edit_refinery_user
      post ':id/update' => 'refinery/users#update', :as => :update_refinery_user
      post 'check_username_availability' => 'refinery/users#check_username_availability', :as => :check_username_availability
    end
  end

  mount Refinery::Core::Engine => '/'
end
