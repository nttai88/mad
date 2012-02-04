Rails.application.routes.draw do
  #re-state the necessary routes here, in addition to stating them higher in routes.rb , sandwiching the conflicting gem route definitions above and below.
  
  devise_for :refinery_user, :class_name => "::Refinery::User", :path => "users", :module => 'refinery' do
    get '/users/register' => 'refinery/users#new', :as => :new_refinery_user_registration
    post '/users/register' => 'refinery/users#create', :as => :refinery_user_registration
    post '/users/sign_in' => 'refinery/sessions#create', :as => :refinery_user_session
    get '/users/password/new' => 'refinery/passwords#new', :as => :new_refinery_user_password
    get '/users/password' => 'refinery/passwords#create', :as => :refinery_user_password
    get '/users/confirmation' => 'refinery/confirmations#show', :as => :refinery_user_confirmation
    get '/users/:id/edit' => 'refinery/users#edit', :as => :edit_refinery_user
    post '/users/:id/update' => 'refinery/users#update', :as => :update_refinery_user
    post '/users/check_username_availability' => 'refinery/users#check_username_availability', :as => :check_username_availability
  end if ::Refinery::User.respond_to?(:devise)

end