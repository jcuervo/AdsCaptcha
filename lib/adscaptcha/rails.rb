require 'net/http'
require 'adscaptcha'

ActionView::Base.send(:include, Adscaptcha::ClientHelper)
ActionController::Base.send(:include, Adscaptcha::Verify)