#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                   Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

require 'thread'

class PingerRunner
  class << self
    def single_runner(name, &block)
      r = PingerRunner.new
      p = Pinger.new(name, &block)

      r.add(p).run
    end
  end

  def initialize
    @ps = []
  end

  def add(*ps)
    @ps += ps
    self
  end

  def run
    @ps.map do |p|
      Thread.new do
        p.do_things
      end
    end.each(&:join)
  end
end
