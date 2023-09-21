desc 'Insert values into first_name and last_name column of users table'
task update_users: [:environment] do
  User.all.each do |user|
    full_name = user.name.split(' ')
    user.update(first_name: full_name[0], last_name: full_name[1])
  end
end
