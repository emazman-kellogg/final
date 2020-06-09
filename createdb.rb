# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :weeks do
  primary_key :id
  String :name
end

DB.create_table! :classes do
  primary_key :id
  foreign_key :week_id
  String :title
  String :description, text: true
  String :type
  String :instructor
  String :weights
  String :date
  String :weekday
  String :link, text: true
end

DB.create_table! :rsvps do
  primary_key :id
  foreign_key :class_id
  foreign_key :user_id
  Boolean :going
  String :comments, text: true
end

DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
  String :username
end

DB.create_table! :stats do
  primary_key :id
  foreign_key :class_id
  foreign_key :user_id  
  String :class_rating, integer: true
  String :total_output, integer: true
  String :avg_output, integer: true
end

# Insert initial (seed) data

weeks_table = DB.from(:weeks)

weeks_table.insert(name: "Week Beginning Jun 8 2020")
weeks_table.insert(name: "Week Beginning Jun 15 2020")
weeks_table.insert(name: "Week Beginning Jun 22 2020")
weeks_table.insert(name: "Week Beginning Jun 29 2020")


classes_table = DB.from(:classes)

classes_table.insert(week_id: "1",
                    title: "30 min 90s Ride", 
                    description: "For a little nostalgia, hop on the Bike to dance and work your way through this 90s themed ride.",
                    type: "Cycling",
                    instructor: "Kendall Toole",
                    weights: "No",
                    date: "June 8 2020",
                    weekday: "Monday",
                    link: "https://members.onepeloton.com/classes/cycling?modal=classDetailsModal&classId=05410c15d3604bc4b2d9837b9b6ce662")

classes_table.insert(week_id: "1",
                    title: "10 min Arms Toning", 
                    description: "Grab your free weights from the back of the Bike to tone your arms during your workout.",
                    type: "Strength",
                    instructor: "Oliva Amato",
                    weights: "Yes",
                    date: "June 8 2020",
                    weekday: "Monday",
                    link: "https://members.onepeloton.com/classes/strength?modal=classDetailsModal&classId=9334fc8af4fe4fcbabbeebb9a26e4728")                    

classes_table.insert(week_id: "1",
                    title: "30 min HIIT & Hills Ride", 
                    description: "Push through heart pumping intervals mixed with strength-building hills.",
                    type: "Cycling",
                    instructor: "Hannah Frankson",
                    weights: "No",
                    date: "June 9 2020",
                    weekday: "Tuesday",
                    link: "https://members.onepeloton.com/classes/cycling?duration=1800&class_type_id=7579b9edbdf9464fa19eb58193897a73&sort=original_air_time&desc=true&modal=classDetailsModal&classId=163b743350364cdfbeb43f0b554c9cc9")

classes_table.insert(week_id: "1",
                    title: "5 min Core Strength", 
                    description: "Join us on the floor for a core workout to align, strengthen and tone your lower back and abdominal muscles.",
                    type: "Strength",
                    instructor: "Cody Rigsby",
                    weights: "No",
                    date: "June 9 2020",
                    weekday: "Tuesday",
                    link: "https://members.onepeloton.com/classes/strength?duration=300&instructor_id=baf5dfb4c6ac4968b2cb7f8f8cc0ef10&sort=original_air_time&desc=true&modal=classDetailsModal&classId=2393533387b147fa868daf06a83d4891")                    

classes_table.insert(week_id: "1",
                    title: "20 min Peloton All-Star Ride", 
                    description: "We challenged an all-star lineup of professional athletes to compete for the top spot on ESPN, and now it's your turn.",
                    type: "Cycling",
                    instructor: "Robin Arzon",
                    weights: "No",
                    date: "June 10 2020",
                    weekday: "Wednesday",
                    link:"https://members.onepeloton.com/classes/cycling?instructor_id=c406f36aa2a44a5baf8831f8b92f6920&sort=original_air_time&desc=true&modal=classDetailsModal&classId=bb87ae4e531342bdbc915e30a63972c3")

classes_table.insert(week_id: "1",
                    title: "20 min Listening Party", 
                    description: "Go on a music discovery journey with Emma as you power through a curated setlist.",
                    type: "Cycling",
                    instructor: "Emma Lovewell",
                    weights: "No",
                    date: "June 10 2020",
                    weekday: "Wednesday",
                    link: "https://members.onepeloton.com/classes/cycling?duration=1200&instructor_id=f6f2d613dc344e4bbf6428cd34697820&sort=original_air_time&desc=true&modal=classDetailsModal&classId=62eb733128054a828bb50011cdbeda68")

classes_table.insert(week_id: "1",
                    title: "5 min Post-Ride Stretch", 
                    description: "Join Matt for this 5-minute stretch complementing your hard work on the bike.",
                    type: "Stretching",
                    instructor: "Matt Wilpers",
                    weights: "No",
                    date: "June 10 2020",
                    weekday: "Wednesday",
                    link: "https://members.onepeloton.com/classes/stretching?duration=300&sort=original_air_time&desc=true&modal=classDetailsModal&classId=959d2701ff9945be92fa895ce0d3fbb5")                    

classes_table.insert(week_id: "1",
                    title: "30 min 2000s Rock Ride", 
                    description: "Hop on the Bike to rock and work your way through this 2000s-themed ride.",
                    type: "Cycling",
                    instructor: "Emma Lovewell",
                    weights: "No",
                    date: "June 11 2020",
                    weekday: "Thursday",
                    link: "https://members.onepeloton.com/classes/cycling?duration=1800&instructor_id=f6f2d613dc344e4bbf6428cd34697820&sort=original_air_time&desc=true&modal=classDetailsModal&classId=ee584452cd91483cb1c96a0647d2780a")
                    
classes_table.insert(week_id: "1",
                    title: "30 min Yoga Flow", 
                    description: "In this active, vinyasa-style yoga class, we'll flow from one pose to the next, linking movements with the breath.",
                    type: "Yoga",
                    instructor: "Denis Morton",
                    weights: "No",
                    date: "June 11 2020",
                    weekday: "Thursday",
                    link: "https://members.onepeloton.com/classes/yoga?duration=1800&class_type_id=56c834e143d4423799fc1d3f3fd70ec8&sort=original_air_time&desc=true&modal=classDetailsModal&classId=e2c3683fac6447b293701aed9a12d239")                    

classes_table.insert(week_id: "1",
                    title: "45 min Intervals & Arms Ride", 
                    description: "Bursts of effort integrated with free weight segments and followed by recovery.",
                    type: "Cycling",
                    instructor: "Cody Rigsby",
                    weights: "Yes",
                    date: "June 12 2020",
                    weekday: "Friday",
                    link: "https://members.onepeloton.com/classes/cycling?duration=2700&instructor_id=baf5dfb4c6ac4968b2cb7f8f8cc0ef10&sort=original_air_time&desc=true")
                    
classes_table.insert(week_id: "1",
                    title: "10 min Peace Meditation", 
                    description: "A guided meditation that focuses on cultivating peace.",
                    type: "Meditation",
                    instructor: "Chelsea Jackson",
                    weights: "No",
                    date: "June 12 2020",
                    weekday: "Friday",
                    link: "https://members.onepeloton.com/classes/meditation?modal=classDetailsModal&classId=3925648d355c4565b97604cb7b52027d")                       
                    
classes_table.insert(week_id: "1",
                    title: "60 min Classic Rock Ride", 
                    description: "Sweat to the mainstays of the most timeless rock and roll in the game.",
                    type: "Cycling",
                    instructor: "Jennifer Jacobs",
                    weights: "No",
                    date: "June 13 2020",
                    weekday: "Saturday",
                    link: "https://members.onepeloton.com/classes/cycling?duration=3600&instructor_id=3622eff359454fb7bada6d1f3fc0976c&sort=original_air_time&desc=true&modal=classDetailsModal&classId=d36c486d704746ae9345dc03d9b12d41")    
                    
                    
                    
