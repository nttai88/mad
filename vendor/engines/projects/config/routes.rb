Rails.application.routes.draw do
  scope(:as => 'refinery', :module => 'refinery') do
    resources :projects, :only => [:index, :show]
  end
end

Refinery::Core::Engine.routes.append do
  scope(:path => 'refinery', :as => 'refinery_admin', :module => 'refinery/admin') do
    resources :projects, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
