class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :summary
      t.string :incharge
      t.string :achivement
      t.integer :user_id
      t.integer :company_id

      t.timestamps
    end
  end
end
