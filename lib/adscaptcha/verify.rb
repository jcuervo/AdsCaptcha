require "uri"
module Adscaptcha
  module Verify
    def verify_adscaptcha(options = {})
      validate_url = "http://#{Recaptcha.configuration.ads_captcha_api}/Validate.aspx"
      private_key = options[:private_key] || Adscaptcha.configuration.private_key
      captcha_id = options[:private_key] || Adscaptcha.configuration.captcha_id
      
      adscaptcha = nil
      http = Net::HTTP
      
      Timeout::timeout(options[:timeout] || 3) do
        adscaptcha = http.post_form(URI.parse(validate_url), {
          "CaptchaId"     => private_key,
          "PrivateKey"    => request.remote_ip,
          "ChallengeCode" => params[:adscaptcha_challenge_field],
          "UserResponse"  => params[:adscaptcha_response_field],
          "RemoteAddress" => request.env['REMOTE_ADDR']
        })
      end
      
      answer, error = adscaptcha.body.split.map { |s| s.chomp }
      unless answer == 'true'
        flash[:adscaptcha_error] = error
        if model
          message = "Image verification response is incorrect, please try again."
          model.errors.add attribute, options[:message] || message
        end
        return false
      else
        flash.delete(:adscaptcha_error)
        return true
      end
    end
  end
end