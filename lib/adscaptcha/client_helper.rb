module Adscaptcha
  module ClientHelper
    def adscaptcha_tags(options = {})
      captcha_id = options[:captcha_id] ||= Adscaptcha.configuration.captcha_id
      key = options[:public_key] ||= Adscaptcha.configuration.public_key

      raise AdscaptchaError, "No public key specified." unless key
      error = options[:error] ||= ((defined? flash) ? flash[:adscaptcha_error] : "")

      dummy = Random.new.rand(1..9999999999)
      urlGet = "http://#{Adscaptcha.configuration.ads_captcha_api}/Get.aspx"
      urlNoScript = "http://#{Adscaptcha.configuration.ads_captcha_api}/NoScript.aspx"
      params = "?CaptchaId=#{captcha_id}&PublicKey=#{key}&Dummy=#{dummy}"
      
      html = "<script src='#{urlGet}#{params}' type='text/javascript'></script>"
      html << "<noscript>"
      html <<   "<iframe src='#{urlNoScript}#{params}' width='300' height='100' frameborder='0'></iframe>"
      html <<   "<table>"
      html <<     "<tr><td>Type challenge here:</td><td><input type='text' name='adscaptcha_response_field' value='' /></td></tr>"
      html <<     "<tr><td>Paste code here:</td><td><input type='text' name='adscaptcha_challenge_field' value='' /></td></tr>"
      html <<   "</table>"
      html << "</noscript>"
      return (html.respond_to?(:html_safe) && html.html_safe) || html
    end
  end
end