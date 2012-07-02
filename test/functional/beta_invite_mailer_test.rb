require 'test_helper'

class BetaInviteMailerTest < ActionMailer::TestCase
  test "send_beta_invite" do
    mail = BetaInviteMailer.send_beta_invite
    assert_equal "Send beta invite", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
