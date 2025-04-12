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

class Appointment < ApplicationRecord
  belongs_to :company
  belongs_to :user, optional: true # Assuming admin users can also be linked

  # Attributes for customer booking
  validates :full_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true # Consider adding format validation later
  validates :appointment_date, presence: true
  # `reason` is optional
  validates :status, presence: true # Should likely have default 'pending'
  validates :appointment_number, presence: true, uniqueness: true # Needs generation logic

  before_validation :generate_appointment_number, on: :create

  private

  def generate_appointment_number
    # Simple random number generation, ensure uniqueness loop if needed
    self.appointment_number ||= loop do
      random_number = SecureRandom.alphanumeric(8).upcase
      break random_number unless Appointment.exists?(appointment_number: random_number)
    end
  end
end
