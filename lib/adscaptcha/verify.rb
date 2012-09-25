require "uri"
module Adscaptcha
  module Verify
    def verify_adscaptcha(options = {})
      validate_url = "http://#{Adscaptcha.configuration.ads_captcha_api}/Validate.aspx"
      private_key = options[:private_key] || Adscaptcha.configuration.private_key
      captcha_id = options[:captcha_id] || Adscaptcha.configuration.captcha_id

      model = options[:model]
      attribute = options[:attribute] || :base
      
      begin
        response = nil
  
        Timeout::timeout(options[:timeout] || 3) do
          uri = URI(validate_url)
          req = Net::HTTP::Post.new(uri.path)

          req.set_form_data({
            "CaptchaId"     => captcha_id,
            "PrivateKey"    => private_key,
            "ChallengeCode" => params[:adscaptcha_challenge_field],
            "UserResponse"  => params[:adscaptcha_response_field],
            "RemoteAddress" => request.remote_ip 
          })

          response = Net::HTTP.start(uri.hostname, uri.port) do |http|
            http.request(req)
          end
        end
      
        unless response.body == 'true'
          flash[:adscaptcha_error] = "Captcha error. Please try again."
          if model
            message = "Captcha error. Please try again."
            model.errors.add attribute, options[:message] || message
          end
          return false
        else
          flash.delete(:adscaptcha_error)
          return true
        end
      rescue Timeout::Error
        flash[:adscaptcha_error] = "Could not validate captcha now. Please try again."
        if model
          message = "Could not validate captcha now. Please try again."
          model.errors.add attribute, options[:message] || message
          return false
        end
      rescue Exception => e
        raise AdscaptchaError, e.message, e.backtrace
      end
    end
  end
end