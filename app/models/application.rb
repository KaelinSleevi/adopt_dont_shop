class Application < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :street_address
    validates_presence_of :city
    validates_presence_of :state
    validates_presence_of :zipcode


    has_many :application_pets
    has_many :pets, through: :application_pets

    def pet_count
        pets.count
    end
end
