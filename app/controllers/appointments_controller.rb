class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company

  def index
    @appointments = @company.appointments.order(appointment_date: :asc)
  end

  def show
    @appointment = @company.appointments.find(params[:id])
  end

  def update
    @appointment = @company.appointments.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "Appointment updated."
    else
      redirect_to appointments_path, alert: "Update failed."
    end
  end

  private

  def set_company
    @company = current_user.company
  end

  def appointment_params
    params.require(:appointment).permit(:status, :appointment_date)
  end
  def reschedule
    @appointment = @company.appointments.find(params[:id])
    if @appointment.update(appointment_params.merge(status: "rescheduled"))
      AppointmentMailer.status_update(@appointment).deliver_later
      redirect_to appointments_path, notice: "Appointment rescheduled."
    else
      redirect_to appointments_path, alert: "Failed to reschedule."
    end
  end
  
  private
  
  def appointment_params
    params.require(:appointment).permit(:appointment_date)
  end
  
end
