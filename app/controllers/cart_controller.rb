class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    pet = Pet.find(params[:id])
    cart.add_pet(pet.id)
    session[:cart] = cart.contents
    flash[:notice] = "Pet has been added to my favorites list."
    redirect_to "/pets/#{pet.id}"
  end

  def delete
    pet = Pet.find(params[:id])
    cart.remove_pet(pet.id)
    flash[:notice] = "Pet has been removed from my favorites list."
    redirect_back(fallback_location:'/favorites')
  end

  def delete_all
    pet_ids = cart.contents.keys
    pet_ids.each do |pet|
      cart.remove_pet(pet)
    end
    redirect_to "/favorites"
  end

end

#{pluralize(quantity, "copy")} of #{song.title} in your cart.
