# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# if there is no OAuth application created, create them
if Doorkeeper::Application.count.zero?
    Doorkeeper::Application.create(name: "client", redirect_uri: "", scopes: "")
end

Partner.create(name: "Lidl Romania", contact_name: "Elekes István", contact_phone: "0740123456", contact_email: "elekes.istvan@gmail.com")
Partner.create(name: "Kaufland Romania", contact_name: "Kovács Lehel", contact_phone: "0746183116", contact_email: "kovacs.lehel@gmail.com")
Partner.create(name: "Carrefour Romania", contact_name: "Csata Béla", contact_phone: "0752133992", contact_email: "csata.bela@yahoo.com")

CollectPoint.create(type: "")
