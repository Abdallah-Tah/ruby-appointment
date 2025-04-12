class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @company = current_user.company
    if @company
      @appointments = @company.appointments.where('appointment_date >= ?', Time.current)
                                           .where.not(status: ['cancelled', 'rejected']) # Filter out cancelled/rejected
                                           .order(appointment_date: :asc)
                                           #.page(params[:page]).per(10) # Optional: Add pagination later

      # Stats Calculations
      now = Time.current
      @upcoming_this_month_count = @company.appointments
                                            .where(appointment_date: now.beginning_of_month..now.end_of_month)
                                            .where.not(status: ['cancelled', 'rejected'])
                                            .count

      @cancelled_count = @company.appointments.where(status: 'cancelled').count # Total cancelled

      @this_week_count = @company.appointments
                                 .where(appointment_date: now.beginning_of_week..now.end_of_week)
                                 .where.not(status: ['cancelled', 'rejected'])
                                 .count
    else
      # Handle case where user might not be associated with a company yet
      # This shouldn't happen with our current sign-up flow, but good practice
      @appointments = []
      @upcoming_this_month_count = 0
      @cancelled_count = 0
      @this_week_count = 0
      # Optionally, redirect or show a message asking them to setup company info
    end
  end
end
