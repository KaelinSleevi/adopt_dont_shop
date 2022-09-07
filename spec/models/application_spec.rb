require 'rails_helper'

RSpec.describe Application, type: :model do
    describe 'validations' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:street_address) }
      it { should validate_presence_of(:city) }
      it { should validate_presence_of(:state) }
      it { should validate_presence_of(:zipcode) }
    end

    describe 'has many' do
        it {should have_many(:application_pets)}
        it {should have_many(:pets)}
    end

    describe 'can return counted pets' do
        it 'has a pet count' do
            @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
            @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
            @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
            @applicant1 = Application.create!(name: "Sandy", street_address: "123 ABC St.", city: "Denver", state: "CO", zipcode: "80241", status: "In Progress")

            expect(@applicant1.pet_count).to eq(0)
        end
    end
end