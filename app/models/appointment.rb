class Public::AppointmentsController < ApplicationController
  before_action :set_company

  def new
    @appointment = @company.appointments.new
  end

  def create
    @appointment = @company.appointments.new(appointment_params.merge(status: "pending"))
    if @appointment.save
      AppointmentMailer.confirmation(@appointment).deliver_later
      redirect_to public_appointment_status_path(@appointment.appointment_number),
                  notice: "Appointment submitted! Check your email for the status link."
    else
      render :new
    end
  end

  def status
    @appointment = Appointment.find_by!(appointment_number: params[:appointment_number])
  end

  private

  def set_company
    @company = Company.find_by!(slug: params[:slug])
  end

  def appointment_params
    params.require(:appointment).permit(:full_name, :email, :phone, :appointment_date, :reason)
  end
end
