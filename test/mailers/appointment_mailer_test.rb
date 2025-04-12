require "test_helper"

class AppointmentMailerTest < ActionMailer::TestCase
  test "confirmation" do
    mail = AppointmentMailer.confirmation
    assert_equal "Confirmation", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "status_update" do
    mail = AppointmentMailer.status_update
    assert_equal "Status update", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
