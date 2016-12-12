Rails.application.routes.draw do
  root :to => 'user#new' #login

  use_doorkeeper #this line allows access to those routes
  					# GET       /oauth/authorize/:code
					# GET       /oauth/authorize
					# POST      /oauth/authorize
					# DELETE    /oauth/authorize
					# POST      /oauth/token
					# POST      /oauth/revoke
					# resources /oauth/applications
					# GET       /oauth/authorized_applications
					# DELETE    /oauth/authorized_applications/:id
					# GET       /oauth/token/info

  resources :courses
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



#==================== MY API ==============================
namespace :api, defaults: {format: "json" } do
	resources :courses, controller: :courses, only: [:index]
	# URL  /apis/courses

end







end
