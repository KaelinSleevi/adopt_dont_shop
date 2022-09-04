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
        if params[:search].present?
            @pets = Pet.search(params[:search])
        end

    end

    def edit
        @application = Application.find(params[:id])
    end

    def update
        @application = Application.find(params[:id])
        @pets = Pet.find(params[:pet_id]) #maybe assign @pets after pet is chosen to get right id?
        @application.update(apps_params)
        @application.save
        redirect_to "/applications/#{@application.id}" #are we missing petid after this?
        if @application.save
            @application.pets << @pets
            require 'pry'; binding.pry
        else
            redirect_to "/applications/#{@application.id}"
        end
    end

    private

    def apps_params
        params.permit(:name, :street_address, :city, :state, :zipcode)
    end

end