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
  String :date
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
classes_table = DB.from(:classes)

classes_table.insert(title: "30 min 90s Ride", 
                    description: "For a little nostalgia, hop on the Bike to dance and work your way through this 90s themed ride.",
                    type: "Cycling",
                    instructor: "Kendall Toole",
                    weights: "No",
                    date: "June 8 2020")

classes_table.insert(title: "10 min Arms Toning", 
                    description: "Grab your free weights from the back of the Bike to tone your arms during your workout.",
                    type: "Strength",
                    instructor: "Oliva Amato",
                    weights: "Yes",
                    date: "June 8 2020")                    

classes_table.insert(title: "30 min HIIT & Hills Ride", 
                    description: "Push through heart pumping intervals mixed with strength-building hills.",
                    type: "Cycling",
                    instructor: "Hannah Frankson",
                    weights: "No",
                    date: "June 9 2020")

classes_table.insert(title: "5 min Core Strength", 
                    description: "Join us on the floor for a core workout to align, strengthen and tone your lower back and abdominal muscles.",
                    type: "Strength",
                    instructor: "Cody Rigsby",
                    weights: "No",
                    date: "June 9 2020")                    

classes_table.insert(title: "20 min Peloton All-Star Ride", 
                    description: "We challenged an all-star lineup of professional athletes to compete for the top spot on ESPN, and now it's your turn.",
                    type: "Cycling",
                    instructor: "Robin Arzon",
                    weights: "No",
                    date: "June 10 2020")

classes_table.insert(title: "20 min Listening Party", 
                    description: "Go on a music discovery journey with Emma as you power through a curated setlist.",
                    type: "Cycling",
                    instructor: "Emma Lovewell",
                    weights: "No",
                    date: "June 10 2020")

classes_table.insert(title: "5 min Post-Ride Stretch", 
                    description: "Join Matt for this 5-minute stretch complementing your hard work on the bike.",
                    type: "Stretching",
                    instructor: "Matt Wilpers",
                    weights: "No",
                    date: "June 10 2020")                    

classes_table.insert(title: "30 min 2000s Rock Ride", 
                    description: "Hop on the Bike to rock and work your way through this 2000s-themed ride.",
                    type: "Cycling",
                    instructor: "Emma Lovewell",
                    weights: "No",
                    date: "June 11 2020")
                    
classes_table.insert(title: "30 min Yoga Flow", 
                    description: "In this active, vinyasa-style yoga class, we'll flow from one pose to the next, linking movements with the breath.",
                    type: "Yoga",
                    instructor: "Denis Morton",
                    weights: "No",
                    date: "June 11 2020")                    

classes_table.insert(title: "45 min Intervals & Arms Ride", 
                    description: "Bursts of effort integrated with free weight segments and followed by recovery.",
                    type: "Cycling",
                    instructor: "Cody Rigsby",
                    weights: "Yes",
                    date: "June 12 2020")
                    
classes_table.insert(title: "10 min Peace Meditation", 
                    description: "A guided meditation that focuses on cultivating peace.",
                    type: "Meditation",
                    instructor: "Chelsea Jackson",
                    weights: "No",
                    date: "June 12 2020")                       
                    
classes_table.insert(title: "60 min Classic Rock Ride", 
                    description: "Sweat to the mainstays of the most timeless rock and roll in the game.",
                    type: "Cycling",
                    instructor: "Jennifer Jacobs",
                    weights: "No",
                    date: "June 13 2020")    
                    
                    
                    
