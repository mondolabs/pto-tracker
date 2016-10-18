Rails.application.routes.draw do
	devise_for :users, :controllers => {:registrations => "users/registrations"}
	resources :departments 
	resources :teams 
	resources :users do
  		resources :requests
  		get "managed_requests" => 'requests#managed_requests', as: :managed_requests
	end		  	
	root "home#dashboard"
  	get 'hello_world', to: 'hello_world#index'
end
