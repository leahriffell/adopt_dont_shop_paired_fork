class ApplicationsController < ApplicationController
  def new
    @fav_pets = cart.favorite_pets.map {|id| Pet.find(id.to_i)}
    @application = Application.new
  end

  def create
    application = Application.create(app_params)
    if application.save && params[:pet_names] != nil
      pet_ids = params[:pet_names].map {|id| id.to_i}
      pets = pet_ids.map {|id| Pet.find(id)}
      pets.each {|pet| pet.applications << application}
      pets.each {|pet| cart.remove_pet(pet.id)}
      redirect_to "/favorites"
      flash[:success] = "Your application has been submitted for selected pets"
    else
      flash[:notice] = "Please fill out all fields."
      redirect_to "/applications/new"
    end
  end

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
