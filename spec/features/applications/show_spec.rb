require 'rails_helper'

RSpec.describe 'The Applicants Show Page' do
    before :each do
        @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
        @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
        @pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'labrador', name: 'Mocha', shelter_id: @shelter.id)
        @pet_4 = Pet.create!(adoptable: true, age: 7, breed: 'tabby cat', name: 'Pounce', shelter_id: @shelter.id)
        @applicant1 = Application.create!(name: "Sandy", street_address: "123 ABC St.", city: "Denver", state: "CO", zipcode: "80241", status: "In Progress")
        @applicant2 = Application.create!(name: "Kaelin", street_address: "567 CBA Ave.", city: "Thornton", state: "CO", zipcode: "80020", status: "In Progress")

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

    it 'can submit an application' do
        visit "/applications/#{@applicant1.id}"
        fill_in 'Search', with: "Lobster"
        click_button('Submit')
        click_button("Adopt #{@pet_2.name}")
        
        fill_in 'Description:', with: "I want pet because I need pet, ty"
        click_button('Submit Application')
        expect(current_path).to eq("/applications/#{@applicant1.id}")
        expect(page).to have_content("Application Status: Pending")
        expect(page).to have_content("#{@pet_2.name}")
        expect(page).to_not have_content("Submit this Application")
    end

    it 'shows a button to approve applications when visiting admin application show page, and shows approved pets' do
        visit "/applications/#{@applicant2.id}"
        fill_in 'Search', with: "Lucille Bald"
        click_button('Submit')
        click_button("Adopt #{@pet_1.name}")
        
        fill_in 'Description:', with: "I want pet because I need pet, ty"
        click_button('Submit Application')
        
        visit "/admin/applications/#{@applicant2.id}"
        click_button('Approve Application')
        expect(page).to have_content('Approved')
        expect(page).to_not have_content('Approve Application')
    end

    it 'shows a button to reject a pet in the admin application show page, once rejected the button is gone and shows status' do
        visit "/applications/#{@applicant2.id}"
        fill_in 'Search', with: "Lobster"
        click_button('Submit')
        click_button("Adopt #{@pet_2.name}")
        fill_in 'Description:', with: "I want pet because I need pet, ty"
        click_button('Submit Application')
        visit "/admin/applications/#{@applicant2.id}"
        click_button('Reject Application')
        visit "/admin/applications/#{@applicant2.id}"
        expect(page).to_not have_content('Reject Application')
        expect(page).to_not have_content('Approve Application')
        expect(page).to have_content('Rejected')
    end

    it 'displays that a given pet has been approved on the application' do
        visit "/applications/#{@applicant2.id}"
        fill_in 'Search', with: "Mocha"
        click_button('Submit')
        click_button("Adopt #{@pet_3.name}")
        fill_in 'Description:', with: "I want pet because I need pet, ty"
        click_button('Submit Application')
        visit "/admin/applications/#{@applicant2.id}"
        require 'pry'; binding.pry
        click_button('Approve Pet')
        expect(page).to have_content("#{@pet_3.name} Approved")
    end

    it 'displays that a given pet has been rejected on the application' do
        visit "/applications/#{@applicant2.id}"
        fill_in 'Search', with: "Pounce"
        click_button('Submit')
        click_button("Adopt #{@pet_4.name}")
        fill_in 'Description:', with: "I want pet because I need pet, ty"
        click_button('Submit Application')
        visit "/admin/applications/#{@applicant2.id}"
        click_button('Reject Pet')
        expect(page).to have_content("#{@pet_4.name} Rejected")
    end
end
