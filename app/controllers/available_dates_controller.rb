class AvailableDatesController < ApplicationController
  def index
    all_bookings = Booking.paid + Booking.pending
    all_dates = all_bookings.flatten.map{ |b| [b.start_date, b.end_date] }
    final_dates = all_dates.map do |dates|
      (dates[0].to_date..dates[1].to_date).to_a.map { |x| x.strftime("%m/%d/%Y") }
    end.flatten
    final_dates = final_dates.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)
    
    render json: final_dates
  end

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
