Fabricator(:user) do
  provider { 'facebook' }
  uid { 1234 + rand(100000) }
  name { Faker::Name.name }
end