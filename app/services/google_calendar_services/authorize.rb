require "google/apis/calendar_v3"
require "googleauth"

module GoogleCalendarServices
  class Authorize
    class << self
      def execute!

        scopes =  [
          'https://www.googleapis.com/auth/calendar'    
        ]

        
        authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
          json_key_io: File.open('./app/services/google_calendar_services/creds.json'),
          scope: scopes
        )

        authorizer.fetch_access_token!
      end
    end
  end
end

