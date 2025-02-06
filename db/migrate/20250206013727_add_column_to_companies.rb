class AddColumnToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :start_on, :date
    add_column :companies, :end_on, :date
    add_column :companies, :user_id, :integer
  end
end
