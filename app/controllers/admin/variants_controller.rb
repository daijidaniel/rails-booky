module Admin
  class VariantsController < ApplicationController
    def create
      variant = Variant.new(variant_params)

      if variant.save
        redirect_to admin_additional_item_path(
          id: params[:additional_item_id]
        ), flash: { success: "Saved!"}
      else
        redirect_to admin_additional_item_path(
          id: params[:additional_item_id]
        ), flash: { error: variant.errors }
      end
    end
    def destroy; end

    def variant_params
      {
        item_id: params[:additional_item_id],
        description: params[:variant][:description],
        name: params[:variant][:name],
        price: params[:variant][:price]
      }
    end
  end
end