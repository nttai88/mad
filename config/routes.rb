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

  mount Messaging::Engine => "/messaging"

  mount Refinery::Core::Engine => "/"
end
