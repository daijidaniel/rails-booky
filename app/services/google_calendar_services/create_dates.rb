module GoogleCalendarServices
  class CreateDates
    class << self
      def execute!
        service = Google::Apis::CalendarV3::CalendarService.new
        service.client_options.application_name = APPLICATION_NAME
        service.authorization = authorize
      end
    end
  end
end