# Cinch::Eventcountdown

Cinch Plugin that allows for event timers/countdowns.

## Installation

Add this line to your application's Gemfile:

    gem 'cinch-eventcountdown'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cinch-eventcountdown

## Usage

Just add the plugin to your list:

    @bot = Cinch::Bot.new do
      configure do |c|
        c.plugins.plugins = [Cinch::Plugins::EventCountdown]
      end
    end

You need to create an events listing at 'config/events.yml' relative to the bot's
base files. In the future this will be configurable, but for now you will have to
fork the gem to be able to change it.

The format of the file should resemble this:

    ---
    - :type: east
      :triggers:
        - :east
        - :paxeast
      :name: PAX East
      :date: 2013-03-21 08:00:00 -08:00
      :estimated: false
    - :type: prime
      :triggers:
        - :pax
        - :paxprime
        - :prime
      :name: PAX Prime
      :date: 2013-08-30 08:00:00 -08:00
      :estimated: false

Type: the type of event, will be used in the future to allow you to add multiple instances of an event and allow the plugin to pick the next one.
Triggers: the triggers in channel
Name: Full name of the event.
Date: Properly formated date time string.
Estimated: Boolean used for events that do not have a hard confirmed date yet.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
