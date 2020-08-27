  class SheltersController < ApplicationController
    def index
      @shelters = Shelter.all
    end

    def show
      @shelter = Shelter.find(params[:id])
    end

    def new 
      @shelter = Shelter.new
    end

    def create
      shelter = Shelter.create(shelters_params)
      if shelter.save
        redirect_to "/shelters"
      else
        flash[:notice] = "Please fill out all fields."
        redirect_to "/shelters/new"
      end
    end

    def edit 
      @shelter = Shelter.find(params[:id])
    end

    def update
      shelter = Shelter.find(params[:id])
      # shelter.update(shelters_params)
      if shelter.update(shelters_params)
        redirect_to "/shelters/#{shelter.id}"
      else
        flash[:notice] = "Please fill out all fields."
        redirect_to "/shelters/#{shelter.id}/edit"
      end
    end

    def destroy
      Shelter.destroy(params[:id])
      redirect_to "/shelters"
    end

    private

    def shelters_params
      params.permit(:name, :address, :city, :state, :zip)
    end
  end