# Creates-an-Oauth-2.0-authentication-server
Creates an Oauth 2.0 authentication server with Ruby on Ralis

->rails new "App_Name"
Create Models Users has may Courses
-rails g scaffold User username:string password:string
-rails g scaffold Course name:string description:string
-rake db:migrate
Use gem 'bcrypt', '~> 3.1.7' to encrypt password 
Add 'requiere "bcrypt" in models/user.rb
-	class User < ApplicationRecord
-		require "bcrypt"
-	end
-bundle install
Add this mothods in models/user.rb
	class User < ApplicationRecord
-	require "bcrypt"
-	before_create :set_encrypt_password
-	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
- 	def set_encrypt_password
- 		self.password = BCrypt::Password.create self.password
- 	end
-	end
Create a new user in /users/new URL
Create a few new Courses in  /courses/new URL
===========================================
Create API generate the endpoints
ADD this in config/routes.rb
	#==================== MY API ==============================

-	namespace :api, defaults: {format: "json" } do
-		resources :courses, controller: :courses, only: [:index]
-		# URL  /apis/courses
-
-	end
IN controllers create  new folder-> called->'api' then new file-> api/courses_controller.rb then add this:
- class Api::CoursesController < ApplicationController
-
-	def index
-
-	end
- end
IN views create new folder 'api'/new folder 'courses' then/ new file 'index.json.jbuilder'
Inside index.json.jbuilder add this-> json.test verdadero
Go to api/courses URL it should give the error 'undefined local variable or method `verdadero' for #<#<Class:0x9ba7008>:0x9ba6690>'

Add this query to the var in the methos index at controllers/api/courses_controller.rb
- 	def index
-		@courses = Course.all 
-	end
Modify index.json.jbuilder to this:
- json.courses @courses do |course|
-	json.id course.id
-	json.name course.name
-	json.description course.description
- end	
Save it go to url api/courses you should get the json display like this:
   {"courses":[
	{"id":1,"name":"Java","description":"javavavava Des"},
   	{"id":2,"name":"Python","description":"python desp"}
   ]}
============================================
doorkeeper -> https://github.com/doorkeeper-gem/doorkeeper
----------
Add gem 'doorkeeper' then run-> bundle install
Run-> rails generate doorkeeper:install
There is a setup that you need to do before you can use doorkeeper.
Step 1.
Go to config/initializers/doorkeeper.rb and configure
resource_owner_authenticator block.

Step 2.
Choose the ORM:

If you want to use ActiveRecord run:

  rails generate doorkeeper:migration

And run

  rake db:migrate

Step 3.
That's it, that's all. Enjoy
====================================================================
Go to oauth/applications, should display this error from bookeeper> undefined local variable or method `root_path' for #<#<Class:0x6223bd8>:0x6221748>
So in routes.rb add this:   root :to => 'user#new' #login 
-  use_doorkeeper #this line allows access to those routes
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
=====================================
Create new application called whatever you want in 'Redirect URi' Use 'urn:ietf:wg:oauth:2.0:oob' for local tests
Click Submit, It should display something like this:
	Application created.
	Application: web
	Application Id:

	5cfd6dd05fe07ab79d943d141b5aee80a0987f75bd2f7a7bfd175cde91420d0e

	Secret:

	5c8f3cc2155266e5fec1ab723ac11a3ce9cbc2236be05d3e3809273b5f34d3e8

	Scopes:


	Callback urls:

	urn:ietf:wg:oauth:2.0:oob	Authorize
	Actions
	Edit

	Destroy
---------------------------------------------------------------------------------
To restrict access to the endpoints Add this line in controllers/api/courses_controller.rb> 
	-before_action :doorkeeper_authorize!

IF Go to http://localhost:3000/api/courses doesnot display the JSON anymore.
And if go the console will display the error 401 Unauthorized

you could add Escessions in the line-> before_action :doorkeeper_authorize! only: Admin!  etc.
