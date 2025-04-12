# Preview all emails at http://localhost:3000/rails/mailers/appointment_mailer
class AppointmentMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/appointment_mailer/confirmation
  def confirmation
    AppointmentMailer.confirmation
  end

  # Preview this email at http://localhost:3000/rails/mailers/appointment_mailer/status_update
  def status_update
    AppointmentMailer.status_update
  end
end
