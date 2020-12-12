module Admin
  class AdditionalItemsController < Admin::ApplicationController
    before_action :ensure_admin!
    before_action :set_item, only: %i[show update]
    
    def index; end
  
    def create
      @item = Item.new(item_params)
      
      respond_to do |format|
        if @item.save
          format.html { redirect_to admin_additional_item_path(id: @item), success: 'Item successfully created.' }
        else
          format.html { redirect_to admin_additional_items_path, flash: { error: @item.errors } }
        end
      end
    end

    def show; end

    def update
      if @item.update(item_params)
        redirect_to admin_additional_item_path(id: @item), flash: { success: 'Item updated successfully.' }
      else
        redirect_to admin_additional_item_path(id: @item), flash: { error: @item.errors }
      end
    end

    private

    def set_item
      @item ||= Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(
        :name,
        :description,
        :price,
        images: [],
        variants_attributes: {}
      )
    end
  end
end
