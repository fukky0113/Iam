class CreateProjectSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :project_skills do |t|
      t.integer :project_id
      t.integer :skill_id
      t.string :detail

      t.timestamps
    end
    add_index :project_skills, [:project_id, :skill_id], unique: true
  end
end
