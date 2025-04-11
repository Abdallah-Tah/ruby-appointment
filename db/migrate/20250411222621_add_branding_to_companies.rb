class AddBrandingToCompanies < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :logo_url, :string
    add_column :companies, :theme_color, :string
  end
end
