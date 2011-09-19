Fabricator(:user) do
  first_name { sequence(:first_name) { |n| "First Name #{n}" }}
  last_name  { sequence(:last_name) { |n| "Last Name #{n}" }}
  email      { sequence(:email) { |n| "user#{n}@example.com" }}
  password   'secret'
end
