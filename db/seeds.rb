# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or find_or_create_byd alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_find_or_create_by_by!(name: genre_name)
#   end

# if there is no OAuth application find_or_create_byd, find_or_create_by them
if Doorkeeper::Application.count.zero?
    Doorkeeper::Application.create(name: "client", redirect_uri: "", scopes: "")
end

app = Doorkeeper::Application.first
app.uid = "h4ckathon"
app.secret = "h4ckathon"
app.save

City.find_or_create_by(name: "Targu Mures", county: "Mures")

User.find_or_create_by(email: "attila.zsigmond2002@gmail.com", encrypted_password: "aaaaaa", firstname: "Attila", lastname: "Zsigmond", phone_number: "0740123456", city_id: City.first.id, balance: 0, leaderboard_position: 0)

Partner.find_or_create_by(name: "Lidl Romania", contact_name: "Elekes István", contact_phone: "0740123456", contact_email: "elekes.istvan@gmail.com")
Partner.find_or_create_by(name: "Kaufland Romania", contact_name: "Kovács Lehel", contact_phone: "0746183116", contact_email: "kovacs.lehel@gmail.com")
Partner.find_or_create_by(name: "Carrefour Romania", contact_name: "Csata Béla", contact_phone: "0752133992", contact_email: "csata.bela@yahoo.com")

CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Lidl Tudor", address: "Strada Livezeni 6", longitude: 46.53503351439234, latitude: 24.59387421675232, contact_phone: "0751946282", partner_id: 1)
CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Lidl Doja",address: "Strada Gheorghe Doja 62A", longitude: 46.53272710183293, latitude: 24.549589532236077, contact_phone: "0773857211", partner_id: 1)
CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Lidl Harmadik",address: "Strada Libertăţii", longitude: 46.55552846571576, latitude: 24.557442340599575, contact_phone: "0745549068", partner_id: 1)
CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Kaufland Tudor",address: "Strada Livezeni 6A", longitude: 46.53576910940117, latitude: 24.59519871879472, contact_phone: "0749917392", partner_id: 2)
CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Kaufland másik",address: "Strada Gheorghe Doja 66", longitude: 46.5311045068108, latitude: 24.546704379371487, contact_phone: "0773653211", partner_id: 2)
CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Carrefour Shopping",address: "Strada Libertăţii 2", longitude: 46.52888531195909, latitude: 24.596180370433522, contact_phone: "0733989921", partner_id: 2)

Achievement.find_or_create_by(name: "Eco Newbie", description: "Congratulations! You've started your eco-journey by recycling once.", point_value: 10)
Achievement.find_or_create_by(name: "Eco Warrior", description: "You're making a difference! Keep up the good work and recycle 5 times to earn this achievement.", point_value: 50)
Achievement.find_or_create_by(name: "Coupon Collector", description: "Congratulations! You've earned your first coupon.", point_value: 10)
Achievement.find_or_create_by(name: "Coupon King/Queen", description: "You reign supreme in the world of coupons! Earn 50 coupons to achieve this noble title.", point_value: 500)
Achievement.find_or_create_by(name: "Coupon Legend", description: "You're a legend among coupon collectors! Earn 100 coupons to achieve this legendary status.", point_value: 1000)
Achievement.find_or_create_by(name: "Eco Champion", description: "You're a true champion for the planet! Recycle 10 times to earn this prestigious title.", point_value: 100)
Achievement.find_or_create_by(name: "Coupon Enthusiast", description: "You're getting the hang of this! Earn 5 coupons to achieve this milestone.", point_value: 50)
Achievement.find_or_create_by(name: "Eco Master", description: "You're a master of recycling! Recycle 20 times to earn this ultimate achievement.", point_value: 200)
Achievement.find_or_create_by(name: "Eco Guardian", description: "You're a guardian of the environment! Recycle 50 times to earn this noble achievement.", point_value: 500)
Achievement.find_or_create_by(name: "Coupon Connoisseur", description: "You're a true expert at collecting coupons! Earn 10 coupons to achieve this prestigious title.", point_value: 100)
Achievement.find_or_create_by(name: "Planet Saver", description: "You're a legend in the recycling world! Recycle 100 times to earn this legendary achievement.", point_value: 1000)
Achievement.find_or_create_by(name: "Coupon Master", description: "You're the ultimate coupon collector! Earn 20 coupons to achieve this legendary status.", point_value: 200)
Achievement.find_or_create_by(name: "Master Recycler", description: "You're the master of recycling! Recycle 200 times to earn this legendary achievement.", point_value: 2000)
Achievement.find_or_create_by(name: "Coupon Tycoon", description: "You're the tycoon of coupons! Earn 200 coupons to achieve this unparalleled status.", point_value: 2000)
Achievement.find_or_create_by(name: "Weekly Point Champion", description: "Congratulations! You've earned the most points in a single week.", point_value: 100)
Achievement.find_or_create_by(name: "Weekly Point Leader", description: "You're consistently at the top! Earn the most points in a week for 3 consecutive weeks to achieve this title.", point_value: 200)
Achievement.find_or_create_by(name: "Weekly Point Master", description: "You're a master of weekly point accumulation! Earn the most points in a week for 5 consecutive weeks to achieve this prestigious status.", point_value: 500)
Achievement.find_or_create_by(name: "Weekly Point Legend", description: "You're a legend in weekly point earning! Earn the most points in a week for 10 consecutive weeks to achieve this legendary status.", point_value: 1000)




