class ApplicationsPets < ApplicationController
    belongs_to :application
    belongs_to :pets
end