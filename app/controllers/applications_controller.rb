class ApplicationsController < ApplicationController
    def new
    
    end

    def create
        @application = Application.create!({
            name: params[:name],
            street_address: params[:street_address],
            city: params[:city],
            state: params[:state],
            zipcode: params[:zipcode],
            status: params[:status]
            })

        redirect_to "/applications/#{@application.id}"
    end

    def show
        @application = Application.find(params[:id])
    end

end