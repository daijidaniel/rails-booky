class AdditionalItemsController < ApplicationController
  def index; end

  def create; end

  def update
    booking = Booking.find(params[:id])

    booking_params[:additional_items_attributes].each do |id, item|
      found_item = booking.additional_items.find_by(item_id: item[:item_id])

      found_item.nil? ? 
      booking.additional_items.create(item) : 
      found_item.update(item)
    end

    booking_params[:additional_items_attributes].each do |id, item|
      found_item = booking.additional_items.find_by(item_id: item[:item_id])

      found_item.nil? ? 
      booking.additional_items.create(item) : 
      found_item.update(item)
    end

    if booking.save!
      redirect_to checkout_index_path, success: "Updated cart"
    else
      redirect_to checkout_index_path, error: booking.errors
    end
  end

  def booking_params
    params.require(:booking).permit(
      :id,
      additional_items_attributes: [
        :item_id,
        :quantity
      ],
      additional_variants: {}
    )
  end
end