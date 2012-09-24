require "adscaptcha/version"
require 'adscaptcha/configuration'

module Adscaptcha
  ADSCAPTCHA_API = 'api.adscaptcha.com'

  def self.configuration
    @configuration ||= Configuration.new
  end

  # Allows easy setting of multiple configuration options. See Configuration
  # for all available options.
  #--
  # The temp assignment is only used to get a nicer rdoc. Feel free to remove
  # this hack.
  #++
  def self.configure
    config = configuration
    yield(config)
  end

  def self.with_configuration(config)
    original_config = {}

    config.each do |key, value|
      original_config[key] = configuration.send(key)
      configuration.send("#{key}=", value)
    end

    result = yield if block_given?

    original_config.each { |key, value| configuration.send("#{key}=", value) }
    result
  end

  class AdscaptchaError < StandardError
  end
end

if defined?(Rails)
  require 'adscaptcha/rails'
end
