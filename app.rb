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
# riders_table = DB.from(:riders)


get "/" do 
    @weeks = weeks_table.all
    puts @weeks.inspect
    view "weeks"
end

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

get "/weeks/:id/class/:class_id" do
    @week = weeks_table.where(:id => params["id"]).to_a[0]
    @class = classes_table.where(:id => params["class_id"]).to_a[0]
    puts @week.inspect
    puts @class.inspect
    view "class"
end    

get "/weeks/:id/class/:class_id" do
    @week = weeks_table.where(:id => params["id"]).to_a[0]
    @class = classes_table.where(:id => params["class_id"]).to_a[0]
    puts @week.inspect
    puts @class.inspect
    view "class"
end   

get "/weeks/:id/class/:class_id/rsvps/create" do
    @week = weeks_table.where(:id => params["id"]).to_a[0]
    @class = classes_table.where(:id => params["class_id"]).to_a[0]
    puts params.inspect
    "Got it!"
end 

get "/weeks/:id/class/:class_id/stats/create" do
    @week = weeks_table.where(:id => params["id"]).to_a[0]
    @class = classes_table.where(:id => params["class_id"]).to_a[0]
    puts params.inspect
    "Got it!"
end 
