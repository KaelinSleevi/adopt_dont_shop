class ApplicationsController < ApplicationController
    def new
    
    end

    def create
        @application = Application.new(apps_params)
        if @application.save
            redirect_to "/applications/#{@application.id}"
        else
            flash[:alert] = "All fields must be filled to submit your application."
            redirect_to "/applications/new"
        end
    end

    def show
        @application = Application.find(params[:id])
    end

    private

    def apps_params
        params.permit(:name, :street_address, :city, :state, :zipcode)
    end

end