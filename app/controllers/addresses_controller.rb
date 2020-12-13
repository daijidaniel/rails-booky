class AddressesController < ApplicationController
  before_action :ensure_cart, only: :index
  
  def index; end
  
  def create
    if current_user.address.nil?
      address = Address.new(address_params) 
      if address.save
        redirect_to payments_path,  flash: { success: "address saved" }
      else
        redirect_to addresses_path,  flash: { error: address.errors }
      end
    else 
      if current_user.address.update(address_params)
        redirect_to payments_path,  flash: { success: "address saved" }
      else
        redirect_to addresses_path,  flash: { error: address.errors }
      end
    end
  end

  def address_params
    {
      line1: params[:address][:line1],
      line2: params[:address][:line1],
      city: params[:address][:city],
      postcode: params[:address][:postcode],
      phone: params[:address][:phone],
      country: "PL",
      user_id: current_user.id
    }
  end
end