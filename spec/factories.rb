FactoryBot.define do
  factory :product do
    sequence :title do |n|
      "product #{n}"
    end
    description { "description" }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/bg-tomato.png'), 'image/png') }
    price { BigDecimal("100") }
  end
end
