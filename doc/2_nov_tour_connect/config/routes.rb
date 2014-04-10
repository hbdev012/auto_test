Tourconnect::Application.routes.draw do

  match '/media/:dragonfly/:file_name', :to => Dragonfly[:images]

  root :to => "home#index"

  devise_for :users, :controllers => { :registrations => 'registrations', :confirmations => 'confirmations' }

  namespace :admin do
    resources :users do
      member do
        put    :accept
        delete :reject
      end
    end

    resources :supplier, :only => [] do
      resources :supplier_amenities, :only => [:create]
    end

    resources :product, :only => [] do
      resources :product_rate_groups, :only => [:show]
    end

    resources :accommodations

    resources :accommodation_products do
      resources :accommodation_product_amenities, :only => [:create]
    end

    resources :non_accommodations
    resources :non_accommodation_products

    resource  :billing_information, :only => [:edit, :update], :controller => 'billing_information'
    resource  :payment,             :only => [:edit, :update], :controller => 'payment'
    resource  :signup,              :only => [:edit, :update], :controller => 'signup'
    resource  :terms,               :only => [:edit, :update], :controller => 'terms'
  end

  resources :companies, :only => :index
  resources :invitations

end
