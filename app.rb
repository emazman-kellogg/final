# Set up for the application and database. DO NOT CHANGE. #############################
require "sinatra"                                                                     #
require "sinatra/reloader" if development?                                            #
require "sequel"                                                                      #
require "logger"                                                                      #
require "twilio-ruby"                                                                 #
require "geocoder"                                                                    #
require "bcrypt"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################

weeks_table = DB.from(:weeks)
classes_table = DB.from(:classes)
rsvps_table = DB.from(:rsvps)
stats_table = DB.from(:stats)
users_table = DB.from(:users)

before do
    # SELECT * FROM users WHERE id = session[:user_id]
    @current_user = users_table.where(:id => session[:user_id]).to_a[0]
    puts @current_user.inspect
end

# Home page (all weeks)
get "/" do 
    @weeks = weeks_table.all
    puts @weeks.inspect
    view "weeks"
end

# Show a single week and events scheduled by day of week
get "/weeks/:id" do
    @week = weeks_table.where(:id => params["id"]).to_a[0]
    @classesmonday= classes_table.where(:week_id => params["id"], :weekday=>"Monday").to_a
    @classestuesday= classes_table.where(:week_id => params["id"], :weekday=>"Tuesday").to_a
    @classeswednesday= classes_table.where(:week_id => params["id"], :weekday=>"Wednesday").to_a
    @classesthursday= classes_table.where(:week_id => params["id"], :weekday=>"Thursday").to_a
    @classesfriday= classes_table.where(:week_id => params["id"], :weekday=>"Friday").to_a
    @classessaturday= classes_table.where(:week_id => params["id"], :weekday=>"Saturday").to_a
    puts @classesmonday.inspect
    view "week"
end

# Show a single class
get "/weeks/:id/class/:class_id" do
    @week = weeks_table.where(:id => params["id"]).to_a[0]
    @class = classes_table.where(:id => params["class_id"]).to_a[0]
    puts @week.inspect
    puts @class.inspect
    view "class"
end    

# Form to create a new RSVP
post "/weeks/:id/class/:class_id/rsvps/create" do
    @week = weeks_table.where(:id => params["id"]).to_a[0]
    @class = classes_table.where(:id => params["class_id"]).to_a[0]
    puts params.inspect
    "Got it!"
end 

# Form to create a new performance stat input
post "/weeks/:id/class/:class_id/stats/create" do
    @week = weeks_table.where(:id => params["id"]).to_a[0]
    @class = classes_table.where(:id => params["class_id"]).to_a[0]
    puts params.inspect
    "Got it!"
end 

# Receiving end of new RSVP form
# Receiving end of new performance stats form

# Form to create a new user
get "/users/new" do
    view "new_user"
end

# Receiving end of new user form
post "/users/create" do
    params.inspect
    users_table.insert(:name => params["name"],
                       :email => params["email"],
                       :password => BCrypt::Password.create(params["password"]))
    view "create_user"
end

# Form to login
get "/logins/new" do
    view "new_login"
end

# Receiving end of login form
post "/logins/create" do
    puts params
    email_entered = params["email"]
    password_entered = params["password"]
    # SELECT * FROM users WHERE email = email_entered
    user = users_table.where(:email => email_entered).to_a[0]
    if user
        puts user.inspect
        # test the password against the one in the users table
        if BCrypt::Password.new(user[:password]) == password_entered
            session[:user_id] = user[:id]
            view "create_login"
        else
            view "create_login_failed"
        end
    else 
        view "create_login_failed"
    end
end

# Logout
get "/logout" do
    session[:user_id] = nil
    view "logout"
end