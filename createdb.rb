# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :classes do
  primary_key :id
  String :title
  String :description, text: true
  String :type
  String :instructor
  String :weights
  String :length
  String :date
  String :link
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :class_id
  foreign_key :rider_id
  Boolean :going
  String :comments, text: true
end

DB.create_table! :riders do
  primary_key :id
  String :name
  String :email
  String :password
  String :username
end

DB.create_table! :stats do
  primary_key :id
  foreign_key :class_id
  foreign_key :rider_id  
  String :class_rating
  String :total_output
  String :avg_output
end

# Insert initial (seed) data
events_table = DB.from(:events)

events_table.insert(title: "Bacon Burger Taco Fest", 
                    description: "Here we go again bacon burger taco fans, another Bacon Burger Taco Fest is here!",
                    date: "June 21",
                    location: "Kellogg Global Hub")

events_table.insert(title: "Kaleapolooza", 
                    description: "If you're into nutrition and vitamins and stuff, this is the event for you.",
                    date: "July 4",
                    location: "Nowhere")
