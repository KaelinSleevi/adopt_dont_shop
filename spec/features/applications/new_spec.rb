require 'rails_helper'

RSpec.describe 'The Applicants Show Page' do
    before(:each) do
        @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

        @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
        @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)

        @application = Application.create!(name: "Kaelin S", street_address: "1289 South St", city: "Denver", state: "CO", zipcode: "80207", status: "Pending")
    end
    it 'links to the new page from the Pet index' do
        visit '/pets'

        click_link("Start an Application: #{@pet_1.name}")
        expect(current_path).to eq('/applications/new')
    end

    it 'can create a new Application' do
        visit '/applications/new'

        expect(page.has_field?).to eq(true)
        fill_in "Name:", with: "Kaelin S"
        fill_in "Address:", with: "1289 South St"
        fill_in "City:", with: "Denver"
        fill_in "State:", with: "CO"
        fill_in "Zipcode:", with: "80207"

        click_button('Submit Application')

        expect(current_path).to eq("/applications/#{@application.id + 1}")
        expect(page).to have_content("Kaelin")
    end

    it 'will redirect if an application is not filled out' do
        visit '/applications/new'

        expect(page.has_field?).to eq(true)

        fill_in "Name:", with: "Kaelin S"
        fill_in "Address:", with: "1289 South St"
        fill_in "City:", with: "Denver"
        fill_in "State:", with: ""
        fill_in "Zipcode:", with: "80207"

        click_button('Submit Application')
        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("All fields must be filled to submit your application.")
    end
end