Gem::Specification.new do |gem|
  gem.authors       = ['Albert Viscasillas']
  gem.email         = ['aviscasillas@gmail.com']
  gem.description   = 'OAuth2 client library for RubyMotion apps'
  gem.summary       = 'OAuth2 client library for RubyMotion apps'
  gem.homepage      = ''
  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'oauth2-motion'
  gem.require_paths = ['lib']
  gem.version       = File.read('VERSION').delete('\n\r')
  gem.add_runtime_dependency 'bubble-wrap-http'
end
