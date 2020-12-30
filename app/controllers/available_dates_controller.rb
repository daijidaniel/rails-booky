class AvailableDatesController < ApplicationController
  def index
    all_bookings = Booking.paid + Booking.pending
    all_dates = all_bookings.flatten.map{ |b| [b.start_date, b.end_date] }
    final_dates = all_dates.map do |dates|
      (dates[0].to_date..dates[1].to_datetime).to_a
    end.flatten

    final_dates = final_dates.map do |date|
      date = date.strftime("%m/%d/%Y")
    end.flatten
    
    render json: final_dates.uniq
  end

  def show
    unit = Unit.find(params[:id])
    all_bookings = unit.bookings.paid + unit.bookings.pending
    all_dates = all_bookings.map{ |b| [b.start_date, b.end_date] }
    final_dates = all_dates.map do |dates|
      date = (dates[0].to_datetime..(dates[1].to_datetime)).to_a

      date.map { |x| x.strftime("%m/%d/%Y") }
    end.flatten

    render json: final_dates.uniq
  end
end
