# 初期ユーザー(ログイン後、ユーザーIDとパスワードの変更が必須)
User.find_or_create_by(user_id: "@onetime") do |user|
  user.name = "onetime"
  user.password = "onetime"
  user.password_confirmation = "onetime"
  user.admin = true
end

# スキルの一覧の登録
u_json = ActiveSupport::JSON.decode(File.read(Rails.root.join("db", "skills.json")))

u_json.each do |d|
  Skill.find_or_create_by(skill_name: d["skill"]) do |skill|
    skill.skill_category = d["category"]
  end
end