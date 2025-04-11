class Company < ApplicationRecord
    has_many :users
    has_many :appointments
    
    def logo_url_or_default
      logo_url.presence || "/placeholder-logo.svg"
    end
    
    def theme_color_or_default
      theme_color.presence || "#2563eb" # Tailwind blue-600
    end
    
  end
  