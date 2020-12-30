# frozen_string_literal: true

require "google/apis/calendar_v3"
require "googleauth"

module GoogleCalendarServices
  class Authorize
    class << self
      def execute!
        scopes = ['https://www.googleapis.com/auth/calendar', 'https://www.googleapis.com/auth/calendar.events']
        authorization = Google::Auth.get_application_default(scopes)

        cal = Google::Apis::CalendarV3::CalendarService.new
        cal.authorization = authorization.dup
        cal.authorization.sub = ENV['AUTH_EMAIL']
        cal.authorization.fetch_access_token!
        cal
      end
    end
  end
end
