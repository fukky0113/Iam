class RemoveTimeFromCompanies < ActiveRecord::Migration[7.0]
  def change
    remove_column :companies, :start_on, :date
    remove_column :companies, :end_on, :date
  end
end
