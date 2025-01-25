FactoryBot.define do
    factory :video do
      title { "Sample Video Title" }               # Example string
      description { "This is a sample description for a video." } # Example text
      duration { rand(60..180) }                   # Random duration in minutes
      genre { %w[Drama Comedy Action Thriller].sample } # Random genre from a list
      release_date { Faker::Date.between(from: 10.years.ago, to: Date.today) } # Random release date
      rating { Faker::Number.decimal(l_digits: 1, r_digits: 1) } # Random rating (e.g., 3.5)
      free { true }             # Random true/false
    end
  end