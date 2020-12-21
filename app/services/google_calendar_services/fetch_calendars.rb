require "google/apis/calendar_v3"
require "googleauth"

module GoogleCalendarServices
  class FetchCalendars
    class << self
      APPLICATION_NAME = "kimuraglamping".freeze

      def execute!
        # Calendar =  # Alias the module
        service = Google::Apis::CalendarV3::CalendarService.new
        service.client_options.application_name = APPLICATION_NAME
        service.authorization = GoogleCalendarServices::Authorize.execute!

        service
      end
    end
  end
end
