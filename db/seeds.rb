#destroy_all actions
#order matters

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Pet.destroy_all
Application.destroy_all
Shleter.destroy_all

@shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 5)
@shelter3 = Shelter.create!(name: 'Thornton shelter', city: 'Thornton, CO', foster_program: false, rank: 3)

@pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter1.id)
@pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter1.id)

# @applicant1 = Application.create!(name: "Sandy", street_address: "123 ABC St.", city: "Denver", state: "CO", zipcode: "80241", status: "Pending")


