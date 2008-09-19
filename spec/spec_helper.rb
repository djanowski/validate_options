require 'rubygems'
require 'spec'

require File.dirname(__FILE__) + '/../lib/validate_options'

def enabled(&block)
  ValidateOptions.enable!
  yield
ensure
  ValidateOptions.disable!
end
