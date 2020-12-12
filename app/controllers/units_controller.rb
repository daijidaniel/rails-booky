class UnitsController < ApplicationController
  before_action :set_unit, only: :show

  def index; end
  def show; end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit ||= Unit.friendly.find(params[:id])
    end
end