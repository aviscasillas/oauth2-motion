unless defined?(Motion::Project::Config)
  fail 'The oauth2-motion gem must be required within a RubyMotion project Rakefile.'
end

require 'bubble-wrap-http'

Motion::Project::App.setup do |app|
  Dir.glob(File.join(File.dirname(__FILE__), 'oauth2_motion/**/*.rb')).each do |file|
    app.files.unshift(file)
  end
end
