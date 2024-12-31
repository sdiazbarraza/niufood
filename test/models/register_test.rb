require "test_helper"

class RegisterTest < ActiveSupport::TestCase
  def setup
    @device = devices(:one)
    @register = Register.new(device: @device, status: "active")
  end

  test "should be valid" do
    assert @register.valid?
  end

  test "status should be present" do
    @register.status = nil
    assert_not @register.valid?
  end

  test "device should be present" do
    @register.device = nil
    assert_not @register.valid?
  end
end
