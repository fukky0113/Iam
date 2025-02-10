class AddTimeFromProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :start_on, :date
    add_column :projects, :end_on, :date
  end
end
