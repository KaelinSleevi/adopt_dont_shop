require 'rails_helper'

# Starting an Application

# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"

RSpec.describe 'The Applicants Show Page' do
    it 'links to the new page from the Pet index' do
        visit '/pets'

        click_link("Start an Application: Lucille Bald")
        expect(current_path).to eq('/applications/new')
    end

    it 'can create a new Application' do
        visit '/applications/new'

        expect(page.has_field?).to eq(true)

        fill_in "application[name]", with: "Kaelin"
        fill_in "application[street_address]", with: "1289 South St"
        fill_in "application[city]", with: "Denver"
        fill_in "application[state]", with: "CO"
        fill_in "application[zipcode]", with: "80207"

        click_button('Submit Application')

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Kaelin")
    end
end