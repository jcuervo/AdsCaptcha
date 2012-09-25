module Adscaptcha
  class Configuration
    attr_accessor :captcha_id,
                  :public_key,
                  :private_key,
                  :ads_captcha_api

    def initialize
      @ads_captcha_api       = ADSCAPTCHA_API
      
      @private_key           = ENV['ADSCAPTCHA_PRIVATE_KEY']
      @public_key            = ENV['ADSCAPTCHA_PUBLIC_KEY']
      @captcha_id            = ENV['ADSCAPTCHA_ID']
    end
  end
end
