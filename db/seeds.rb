User.create!(user_id: "@onetime",
              name: "onetime",
              password: "onetime",
              password_confirmation: "onetime",
              admin: true)

u_json = ActiveSupport::JSON.decode(File.read(Rails.root.join("db", "skills.json")))

u_json.each do |d|
  Skill.create!(skill_name: d["skill"],
                skill_category: d["category"])
end
