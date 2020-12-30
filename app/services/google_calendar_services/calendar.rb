module GoogleCalendarServices
  class Calendar
    CALENDARS = %w[AMATERASU BENZAITEN HOTEI TENJIN]
    attr_reader :calendar, :user, :booking

    def initialize(args = {})
      @calendar = GoogleCalendarServices::Authorize.execute!
      @user = args.has_key?(:booking) ? args[:booking].user : nil
      @booking = args.has_key?(:booking) ?  args[:booking] :  nil
      @time_zone = args.has_key?(:time_zone) ? args[:time_zone] : "Europe/Warsaw"
    end

    def list_all_events
      CALENDARS.map do |cal|
        @calendar.list_events(ENV[cal])
      end.map(&:items).flatten
    end

    def list_events cal
      return "calendar must be one of #{CALENDARS}\n" unless cal.upcase.in?(CALENDARS)

      @calendar.list_event(ENV[cal.upcase])
    end

    def get_calendar cal
      @calendar.get_calendar(ENV[cal.upcase])
    end

    def get_event
      return "no event found on calendar" unless @booking.event_id

      @calendar.get_event(
        ENV[@booking.units.first.name.upcase], 
        @booking.event_id
      )
    end

    def delete_event
      return "no event found on calendar" unless @booking.event_id

      @calendar.delete_event(
        ENV[@booking.units.first.name.upcase], 
        @booking.event_id
      )
    end

    def create_event
      event = Google::Apis::CalendarV3::Event.new(
        attendees: [create_attendee],
        description: "<b>Booking for #{@booking.user.name}</b>\n<b>phone:</b> #{@booking.user.address.phone}\n<b>adults:</b> #{@booking.adult_capacity}<b>,</b> <b>children:</b> #{@booking.child_capacity}",
        creator: event_creator,
        guests_can_invite_others: false,
        guests_can_modify: false,
        guests_can_see_other_guests: true,
        locked: true,
        summary: "#{@booking.units.first.name} booking!",
        start: Google::Apis::CalendarV3::EventDateTime.new(
          date_time: @booking.start_date.rfc3339,
          time_zone: "Europe/Warsaw"
        ),
        end: Google::Apis::CalendarV3::EventDateTime.new(
          date_time: @booking.end_date.rfc3339,
          time_zone: "Europe/Warsaw"
        ),
        location: ENV['LOCATION'],
        source: Google::Apis::CalendarV3::Event::Source.new(
          title: ENV['CREATOR_DISPLAY_NAME'],
          url: ENV['WEBLINK']
        )
      )

      added_event = @calendar.insert_event(
        ENV[@booking.units.first.name.upcase],
        event
      )

      @booking.update(
        event_id: added_event.id,
        calendar_link: added_event.html_link
      )
    end

    def event_creator
      Google::Apis::CalendarV3::Event::Creator.new(
        display_name: ENV['CREATOR_DISPLAY_NAME'],
        email: ENV['CREATOR_EMAIL'],
        self:  true
      )
    end

    def create_attendee
      Google::Apis::CalendarV3::EventAttendee.new(
        display_name: @user.name,
        email: @user.email
      )
    end
  end
end
