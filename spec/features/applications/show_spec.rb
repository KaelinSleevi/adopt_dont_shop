require 'rails_helper'

RSpec.describe 'The Applicants Show Page' do
    before :each do
        @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
        @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
        @applicant1 = Application.create!(name: "Sandy", street_address: "123 ABC St.", city: "Denver", state: "CO", zipcode: "80241", status: "Pending")
    end

    it 'displays the Applicants name' do
        visit "/applications/#{@applicant1.id}"
        expect(page).to have_content(@applicant1.name)
    end

    it 'displays the Applicants street address' do
        visit "/applications/#{@applicant1.id}"
        expect(page).to have_content(@applicant1.street_address)
    end

    it 'displays the Applicants city' do
        visit "/applications/#{@applicant1.id}"
        expect(page).to have_content(@applicant1.city)
    end

    it 'displays the Applicants state' do
        visit "/applications/#{@applicant1.id}"
        expect(page).to have_content(@applicant1.state)
    end

    it 'displays the Applicants zipcode' do
        visit "/applications/#{@applicant1.id}"
        expect(page).to have_content(@applicant1.zipcode)
    end

    it 'displays the Applicants Status' do
        visit "/applications/#{@applicant1.id}"
        expect(page).to have_content(@applicant1.status)
    end

    it 'will be able to search for desired animal' do
        visit "/applications/#{@applicant1.id}"
        expect(page.has_field?).to eq(true)
  
        fill_in 'Search', with: "Lobster"
        click_button('Submit')
        expect(page).to have_content(@pet_2.name)
    end
    
    it 'can add a pet to an application' do
        visit "/applications/#{@applicant1.id}"
        fill_in 'Search', with: "Lobster"
        click_button('Submit')
        click_button("Adopt #{@pet_2.name}")

        expect(page).to have_content("#{@pet_2.name}")
    end

end
