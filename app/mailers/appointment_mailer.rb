class AppointmentMailer < ApplicationMailer
  default from: 'support@djib-payroll.com' # Default FROM address

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.appointment_mailer.confirmation.subject
  #
  def confirmation(appointment)
    @appointment = appointment
    @company = @appointment.company
    @customer_name = @appointment.full_name
    @status_url = public_appointment_status_url(@appointment.appointment_number) # Generate URL

    mail(to: @appointment.email, subject: "Your Appointment Request with #{@company.name} Received (#{@appointment.appointment_number})")
    # Rails will automatically look for views in app/views/appointment_mailer/confirmation.html.erb and .text.erb
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.appointment_mailer.status_update.subject
  #
  def status_update(appointment)
    @appointment = appointment
    @company = @appointment.company
    @customer_name = @appointment.full_name
    @status = @appointment.status
    @status_url = public_appointment_status_url(@appointment.appointment_number)

    mail(to: @appointment.email, subject: "Update on Your Appointment with #{@company.name} (#{@appointment.appointment_number}) - Status: #{@status.capitalize}")
    # Rails will automatically look for views in app/views/appointment_mailer/status_update.html.erb and .text.erb
  end
end
