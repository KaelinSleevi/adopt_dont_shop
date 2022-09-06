require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Thornton shelter', city: 'Thornton, CO', foster_program: false, rank: 3)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_1.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'lists all the shelter names' do
    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it 'lists the shelters by most recently created first' do
    visit "/shelters"

    oldest = find("#shelter-#{@shelter_1.id}")
    mid = find("#shelter-#{@shelter_2.id}")
    newest = find("#shelter-#{@shelter_3.id}")

    expect(newest).to appear_before(mid)
    expect(mid).to appear_before(oldest)

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_content("Created at: #{@shelter_1.created_at}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_content("Created at: #{@shelter_2.created_at}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_content("Created at: #{@shelter_3.created_at}")
    end
  end

  it 'has a link to sort shelters by the number of pets they have' do
    visit '/shelters'

    expect(page).to have_link("Sort by number of pets")
    click_link("Sort by number of pets")

    expect(page).to have_current_path('/shelters?sort=pet_count')
    expect(@shelter_1.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_2.name)
  end

  it 'has a link to update each shelter' do
    visit "/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Update #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Update #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Update #{@shelter_3.name}")
    end

    click_on("Update #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/edit")
  end

  it 'has a link to delete each shelter' do
    visit "/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Delete #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Delete #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Delete #{@shelter_3.name}")
    end

    click_on("Delete #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
  end

  it 'has a text box to filter results by keyword' do
    visit "/shelters"
    expect(page).to have_button("Search")
  end

  it 'lists partial matches as search results' do
    visit "/shelters"

    fill_in 'Search', with: "Denver"
    click_on("Search")

    expect(page).to have_content(@shelter_2.name)
    expect(page).to_not have_content(@shelter_1.name)
  end

  it 'can see all shelters in the system listed in reverse alphabetical order by name' do
      visit '/admin/shelters'

      expect(current_path).to eq('/admin/shelters')
      expect(@shelter_3.name).to appear_before(@shelter_2.name)
      expect(@shelter_2.name).to appear_before(@shelter_1.name)
      expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
  end

  it 'can display a section of shelters with pending applications' do
    visit '/admin/shelters'

    expect(current_path).to eq('/admin/shelters')
    expect(page).to have_content("Shelter's with Pending Applications")
    expect(page).to have_content(@shelter_1.name)
  end
end
