class AvailableDatesController < ApplicationController
  def show
    unit = Unit.find(params[:id])
    all_bookings = unit.bookings.paid + unit.bookings.pending
    all_dates = all_bookings.map{ |b| [b.start_date, b.end_date] }
    final_dates = all_dates.map do |dates|
      (dates[0].to_date..dates[1].to_date).to_a.map { |x| x.strftime("%m/%d/%Y") }
    end.flatten
    render json: final_dates
  end
end
