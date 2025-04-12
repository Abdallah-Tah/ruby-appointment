class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_appointment, only: [:show, :update, :reschedule]

  def index
    @appointments = @company.appointments.order(appointment_date: :asc)
  end

  def show
    # @appointment is set by before_action
  end

  def new
    @appointment = @company.appointments.new
  end

  def create
    @appointment = @company.appointments.new(appointment_params)
    @appointment.status ||= 'approved'
    @appointment.user = current_user

    if @appointment.save
      AppointmentMailer.confirmation(@appointment).deliver_later if @appointment.email.present?
      redirect_to appointments_path, notice: 'Appointment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @appointment.update(appointment_update_params)
      redirect_to appointments_path, notice: "Appointment updated."
    else
      redirect_to appointments_path, alert: "Update failed: #{@appointment.errors.full_messages.to_sentence}"
    end
  end

  def reschedule
    if @appointment.update(appointment_reschedule_params.merge(status: "rescheduled"))
      AppointmentMailer.status_update(@appointment).deliver_later
      redirect_to appointments_path, notice: "Appointment rescheduled."
    else
      redirect_to appointments_path, alert: "Failed to reschedule: #{@appointment.errors.full_messages.to_sentence}"
    end
  end

  private

  def set_company
    @company = current_user.company
    redirect_to root_path, alert: "Company not found." unless @company
  end

  def set_appointment
    @appointment = @company.appointments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to appointments_path, alert: "Appointment not found."
  end

  def appointment_params
    params.require(:appointment).permit(
      :full_name, :email, :phone, :appointment_date, :reason, :status
    )
  end

  def appointment_update_params
    params.require(:appointment).permit(:status)
  end

  def appointment_reschedule_params
    params.require(:appointment).permit(:appointment_date)
  end
end
