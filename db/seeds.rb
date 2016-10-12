require 'csv'

#####################################################

User.destroy_all

#####################################################

csv_file_path = 'db/seeds/employees.csv'
CSV.foreach(csv_file_path, :headers => true, encoding: "windows-1251:utf-8") do |row|
  row["first_name"] = row["first_name"].titleize
  row["last_name"] = row["last_name"].titleize
  row["email"] = row["email"].downcase
  row["role"] = row["role"].to_i
  row["team_name"] = row["team_name"].titleize
  user = User.create!(row.to_hash)
  user.save!
end

######################################################