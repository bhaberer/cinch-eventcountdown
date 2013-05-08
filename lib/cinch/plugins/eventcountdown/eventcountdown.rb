require 'time-lord'

module Cinch::Plugins
  class EventCountdown
    include Cinch::Plugin

    # enforce_cooldown

    self.help = 'foo'

    def initialize(*args)
      super
      @filename = config[:events_file] || 'config/events.yml'

      EventCountdown.help = "The following events have countdowns: #{get_events.map {|a| a[:triggers]}.flatten.join(', ')}"
    end

    # TODO Figure out how to not have this be hard coded. I'm not able to access config
    #        at this scope, and I can't define methods in init.
    if File::exist?('config/events.yml')
      YAML::load(File.open('config/events.yml')).each do |event|
        event[:triggers].each do |trigger|
          # TODO make this only create a match for the first instance to prevent dupes
          match /\A\.#{trigger}\z/, { :method => "next_#{event[:type]}".to_sym,
                                      :use_prefix => false }
        end

        define_method "next_#{event[:type]}" do |m|
          debug "next_#{event[:type]}"
          m.reply time_till(event[:type])
        end
      end
    end

    def time_till(type = nil)
      @event_list = get_events

      # Purge old stuff
      @event_list.delete_if { |e| e[:date] - Time.now < 0 }

      # Purge events that aren't current (this allows for you to add multiple
      #   instances of events that auto expire.
      @event_list.delete_if { |e| e[:type] != type }

      @event_list.sort! { |a,b| b[:date] <=> a[:date] }

      @event = @event_list.pop
      message = "#{@event[:name]} is "
      message << 'approximately ' if @event[:estimated]
      days = (@event[:date] - Time.now) / 86400 # 86400 seconds in a day, etc.
      hours = (days - days.floor) * 24
      message << "#{days.floor} days, #{hours.floor} hours away."
      message << " (No official date, yet)" if @event[:estimated]
      return message
    end

    def get_events
      if File::exist?(@filename)
        return YAML::load(File.open(@filename))
      else
        debug "Cannot open Events config file: #{@filename}"
        exit
      end
    end
  end
end
