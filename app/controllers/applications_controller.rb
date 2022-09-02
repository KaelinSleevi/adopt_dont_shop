class ApplicationsController < ApplicationController
    def new
    
    end

    def create
        @application = Application.create!({
            name: params[:application][:name],
            street_address: params[:application][:street_address],
            city: params[:application][:city],
            state: params[:application][:state],
            zipcode: params[:application][:zipcode],
            status: params[:application][:status]
            })
    end

    def show
        @application = Application.find(params[:id])
    end

end