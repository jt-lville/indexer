# Load the rails application
require File.expand_path('../application', __FILE__)

#config.gem 'paperclip'

# Initialize the rails application
OrchiveApp::Application.initialize!

#Paperclip.options[:command_path] = "/usr/bin/" #comment this out for heroku
Paperclip.options[:swallow_stderr] = false 
