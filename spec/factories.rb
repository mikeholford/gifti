FactoryBot.define do

  # User
  factory :user do
    email { Faker::Internet.email }
  end

  # Api Access
  factory :api_access do
    before(:create) do |api_access|
      user = FactoryBot.create(:user)
      api_access.user = user
    end

    name { Faker::Company.name }
    website_url { Faker::String.random }
    description { Faker::String.random }
    key { SecureRandom.hex }
  end

  # Design
  factory :design do
    name { Faker::Book.title }
    template { (Faker::Company.name).downcase.parameterize }
  end

  # Voucher
  factory :voucher do
    before(:create) do |voucher|
      voucher.design = FactoryBot.create(:design)
      voucher.user = FactoryBot.create(:user)
    end
    value { Faker::Number.number(2) }
    discount_type { ['%', '$', '£'].sample }
    service { Faker::Company.name }
  end

end
