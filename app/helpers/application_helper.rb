module ApplicationHelper
  def notification_class name
    case name 
    when "error"
      "is-danger"
    when "success"
      "is-primary"
    when "warning"
      "is-info"
    else
      "is-info"
    end
  end

  def current_bookings
    current_bookings ||= current_user.bookings.unpaid
  end
end
