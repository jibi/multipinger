multipinger
==========

Ping hosts and do things.

## Simple Usage

Add `multipinger` to your Gemfile:

```rb
gem 'multipinger', github: 'jibi/multipinger'
```

and use it:
```rb
require 'multipinger'

PingerRunner.single_runner('name') do
  host 'my_host'
  probe_interval 10
  cooldown 600

  on_up do
    puts 'Host went up'
  end

  is_up do
    puts 'Host is up'
  end

  on_down do
    puts 'Host went down'
  end

  is_down do
    puts 'Host is down'
  end
end
```


## Multiple pingers
If you want to run multiple pingers:

```rb
require 'multipinger'

p1 = Pinger.new('..') do
  # ..
end

p2 = Pinger.new('..') do
  # ..
end

r = PingerRunner.new
r.add(p1, p2).run
```
