module Admin
  class BookingsController < ApplicationController
    before_action :set_booking, only: %i[show update]

    def index
      @bookings = Booking.all.order(:created_at)
    end

    def show; end

    def create
      booking = Booking.new(new_booking_params)
      
      ActiveRecord::Base.transaction do
        if booking.save
          additional_variants = params[:additional_variants].map do |av|
            next if av["quantity"] == "0"
            AdditionalVariant.create(
              variant_id: av["variant_id"],
              quantity: av["quantity"],
              booking_id: booking.id
            )
          end

          booking.reload
          booking.update_price!

          redirect_to admin_root_path, flash: { success: "Booking created!" } 
        else
          redirect_to admin_root_path, flash: { error: booking.errors } 
        end
      end
    end

    def update
      if @booking.payment.update status: params[:booking][:payment_status].to_sym
        redirect_to admin_booking_path(@booking), flash: { success: "updated!" }
      else
        redirect_to admin_booking_path(@booking), flash: { error: @booking.errors }
      end
    end

    private

    def set_booking
      @booking = Booking.find(params[:id])
    end

    def new_booking_params
      {
        unit_ids: [params[:unit]],
        start_date: DateTime.parse("#{params[:booking][:date].split(" - ")[0]} 15:00"),
        end_date: DateTime.parse("#{params[:booking][:date].split(" - ")[1]} 13:00"),
        user_id: params[:user],
        adult_capacity: params[:adult_capacity],
        child_capacity: params[:child_capacity],
        payment: Payment.new(user_id: params[:user])
      }
    end
  end
end
