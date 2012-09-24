require_relative '../../test_helper'
describe Adscaptcha do
  it "must be defined" do
    Adscaptcha::VERSION.wont_be_nil
  end
end