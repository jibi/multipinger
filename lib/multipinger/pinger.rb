#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                   Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

require 'net/ping'

class Pinger
  include Dsl

  DEFAULT_PROBE_INTERVAL = 60
  DEFAULT_COOLDOWN       = 60

  dsl_attr :host, :probe_interval, :cooldown
  dsl_cb :on_up, :is_up, :on_down, :is_down

  def initialize(name, &block)
    @name           = name
    @cooldown       = DEFAULT_COOLDOWN
    @probe_interval = DEFAULT_PROBE_INTERVAL

    @last_up = Time.at(0)
    @was_up  = false

    instance_eval(&block)
  end

  def up?
    @last_up = Time.now if Net::Ping::External.new(@host).ping?
    Time.now - @last_up < @cooldown
  end

  def do_things_up
    @is_up_cb.call if @is_up_cb
    @on_up_cb.call if !@was_up && @on_up_cb
  end

  def do_things_down
    @is_down_cb.call if @is_down_cb
    @on_down_cb.call if @was_up && @on_down_cb
  end

  def do_things
    loop do
      (up = up?) ? do_things_up : do_things_down

      @was_up = up
      Kernel.sleep @probe_interval
    end
  end
end
