Fabricator(:movie) do
  title { Faker::Lorem.word }
  format { 'DVD' }
  length { 300 }
  release_year { 2015 }
  rating { 1 }
end