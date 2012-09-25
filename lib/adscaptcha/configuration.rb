module Adscaptcha
  class Configuration
    attr_accessor :captcha_id,
                  :public_key,
                  :private_key,
                  :ads_captcha_api
    # attr_accessor :nonssl_api_server_url,
    #               :ssl_api_server_url,
    #               :verify_url,
    #               :skip_verify_env,
    #               :private_key,
    #               :public_key,
    #               :proxy,
    #               :handle_timeouts_gracefully

    def initialize #:nodoc:
      # @nonssl_api_server_url      = RECAPTCHA_API_SERVER_URL
      # @ssl_api_server_url         = RECAPTCHA_API_SECURE_SERVER_URL
      # @verify_url                 = RECAPTCHA_VERIFY_URL
      # @skip_verify_env            = SKIP_VERIFY_ENV
      # @handle_timeouts_gracefully = HANDLE_TIMEOUTS_GRACEFULLY
      @ads_captcha_api       = ADSCAPTCHA_API
      
      @private_key           = ENV['ADSCAPTCHA_PRIVATE_KEY']
      @public_key            = ENV['ADSCAPTCHA_PUBLIC_KEY']
      @captcha_id            = ENV['ADSCAPTCHA_ID']
    end

    # def api_server_url(ssl = false) #:nodoc:
    #   ssl ? ssl_api_server_url : nonssl_api_server_url
    # end
  end
end
