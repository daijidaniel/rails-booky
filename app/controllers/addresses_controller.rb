class AddressesController < ApplicationController
  before_action :ensure_cart, only: :index
  
  def index; end
  
  def create
    user = current_user

    puts address_params
    user.build_address unless user.address
    if user.update(address_params) 
      redirect_to payments_path,  flash: { success: "address saved" }
    else
      redirect_to addresses_path,  flash: { error: user.errors }
    end
  end

  def address_params
    {
      fname: params[:user][:fname],
      lname: params[:user][:lname],
      address_attributes: {
        state: params[:address][:state],
        line1: params[:address][:line1],
        line2: params[:address][:line1],
        city: params[:address][:city],
        postcode: params[:address][:postcode],
        phone: params[:address][:phone],
        country: "PL"
      },
    }
  end
end
