module Admin
  class UnitsController < Admin::ApplicationController
    before_action :ensure_admin!
    before_action :set_unit, only: %i[ show update ]

    def index; end
    
    def create
    end

    def update
      if @unit.update(unit_params)
        redirect_to admin_unit_path(id: @unit.id), flash: { success: 'Unit updated successfully.' }
      else
        redirect_to admin_additional_item_path(id: @unit.id), flash: { error: @unit.errors }
      end
    end

    def show
    end

    private

    def set_unit
      @unit ||= Unit.find(params[:id])
    end

    def unit_params
      params.require(:unit).permit(
        :name,
        :price,
        :description,
        images: [],
        variants: []
      )
    end
  end
end
