require 'rails_helper'

RSpec.describe 'admin shelters index' do
    before :each do
        @shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @shelter2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 5)
        @shelter3 = Shelter.create!(name: 'Thornton shelter', city: 'Thornton, CO', foster_program: false, rank: 3)
    end

    it 'can see all shelters in the system listed in reverse alphabetical order by name' do
        visit '/admin/shelters'
        expect(current_path).to eq('/admin/shelters')
        expect(@shelter3.name).to appear_before(@shelter2.name)
        expect(@shelter2.name).to appear_before(@shelter1.name)
        expect(@shelter1.name).to_not appear_before(@shelter3.name)
    end
end