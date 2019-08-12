FactoryBot.define do
  factory :product do
    sequence :title do |n|
      "product #{n}"
    end
    description { "description" }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/bg-tomato.png'), 'image/png') }
    price { BigDecimal("100") }
  end

  factory :cart_item do
  end

  factory :cart do
    factory :cart_with_items do
      transient do
        items_count { 5 }
      end
      after(:create) do |cart, evaluator|
        create_list(:cart_item, evaluator.items_count, cart: cart)
      end
    end
  end
end
