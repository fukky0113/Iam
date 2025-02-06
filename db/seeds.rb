# 初期ユーザー(ログイン後、ユーザーIDとパスワードの変更が必須)
User.create!(user_id: "@onetime",
              name: "onetime",
              password: "onetime",
              password_confirmation: "onetime",
              admin: true)

# スキルの一覧の登録
u_json = ActiveSupport::JSON.decode(File.read(Rails.root.join("db", "skills.json")))

u_json.each do |d|
  Skill.create!(skill_name: d["skill"],
                skill_category: d["category"])
end