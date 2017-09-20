Gem::Specification.new do |s|
  s.name     = 'multipinger'
  s.version  = '0.0.1'
  s.date     = '2017-09-20'
  s.summary  = 'Ping hosts and do things'
  s.authors  = ['Gilberto Bertin']
  s.email    = 'me@jibi.io'
  s.files    = ['lib/multipinger.rb']
  s.homepage = 'https://github.com/jibi/multipinger'
  s.license  = 'WTFPL'

  s.add_runtime_dependency 'net-ping', '~> 2.0'
end
