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

City.find_or_create_by(name: "Targu Mures", county: "Mures")

Partner.find_or_create_by(name: "Lidl Romania", contact_name: "Elekes István", contact_phone: "0740123456", contact_email: "elekes.istvan@gmail.com")
Partner.find_or_create_by(name: "Kaufland Romania", contact_name: "Kovács Lehel", contact_phone: "0746183116", contact_email: "kovacs.lehel@gmail.com")
Partner.find_or_create_by(name: "Carrefour Romania", contact_name: "Csata Béla", contact_phone: "0752133992", contact_email: "csata.bela@yahoo.com")

CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Lidl Tudor", address: "Strada Livezeni 6", longitude: 46.53503351439234, latitude: 24.59387421675232, contact_phone: "0751946282", partner_id: 1)
CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Lidl Doja",address: "Strada Gheorghe Doja 62A", longitude: 46.53272710183293, latitude: 24.549589532236077, contact_phone: "0773857211", partner_id: 1)
CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Lidl Harmadik",address: "Strada Libertăţii", longitude: 46.55552846571576, latitude: 24.557442340599575, contact_phone: "0745549068", partner_id: 1)
CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Kaufland Tudor",address: "Strada Livezeni 6A", longitude: 46.53576910940117, latitude: 24.59519871879472, contact_phone: "0749917392", partner_id: 2)
CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Kaufland másik",address: "Strada Gheorghe Doja 66", longitude: 46.5311045068108, latitude: 24.546704379371487, contact_phone: "0773653211", partner_id: 2)
CollectPoint.find_or_create_by(collection_type: "bottle", city_id: City.first.id, name:"Carrefour Shopping",address: "Strada Libertăţii 2", longitude: 46.52888531195909, latitude: 24.596180370433522, contact_phone: "0733989921", partner_id: 2)



