class ApplicationsController < ApplicationController
    def new
        
    end

    def create
        @application = Application.new(apps_params)
        @application.status = "In Progress"
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
        @application.status = "Pending"   
        @application.description = params[:query]
        @application.update(apps_params)
        @application.save
        redirect_to "/applications/#{@application.id}" 
    end

    def update
        @application = Application.find(params[:id])
     
        @application.update(apps_params)
        @application.save
        redirect_to "/applications/#{@application.id}" 
        if params[:pet_id] != nil
            @pets = Pet.find(params[:pet_id])
            
            if @application.save
                @application.pets << @pets
            else
                redirect_to "/applications/#{@application.id}"
            end
        end
        
    end

    def admin_show
        @application = Application.find(params[:id])
    end

    def admin_update
        @application = Application.find(params[:id])
        if params[:pet_id] != nil
            @pets = Pet.find(params[:pet_id])
            @application_pets = ApplicationPet.find_by(pet_id: params[:pet_id], application_id: params[:id])
            if pet_params[:pet_status] == "Approved"
                @application_pets.pet_status = "Approved"
            elsif pet_params[:pet_status] == "Rejected"
                @application_pets.pet_status = "Rejected"
            end
            @application_pets.update(pet_params)
            @application_pets.save
        end
       
        if apps_params[:status] == "Approved"
            @application.status = "Approved" 
        elsif apps_params[:status] == "Rejected"
            @application.status = "Rejected"
        end
        @application.update(apps_params)
        @application.save
        
        redirect_to "/admin/applications/#{@application.id}"
    end

    private

    def apps_params
        params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
    end

    def pet_params
        params.permit(:pet_status)
    end

end