User.create!(user_id: "@example",
              name: "example",
              password: "password",
              password_confirmation: "password",
              admin: true)

99.times do |n|
  name = Faker::Name.initials(number: 10)
  user_id = "@a#{n+1}"
  password = "password"
  User.create!(user_id: user_id,
                name: name,
                password: password,
                password_confirmation: password
                )
end