user = User.where(email: "email@example.com").first_or_initialize
user.role = :admin
user.name = "Admin"
user.password = "password"
user.salary = 1.0
user.save
