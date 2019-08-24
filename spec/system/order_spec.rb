require "rails_helper"

RSpec.describe "Order", type: :system, js_headless:true do
  let!(:product) { create(:product) }

  before do
    visit "/"

    click_button "Add to Cart"

    within("#aside-cart") do
      expect(page).to have_content product.title
      expect(page).to have_content "1 times;"
    end


  end

  context "現金の場合" do
    example "注文できること" do
      click_button "購入する"

      fill_in "Name", with: "name"
      fill_in "Address", with: "address"
      fill_in "Email", with: "mail@example.com"
      select "Cash", from: "order_pay_type"

      click_button "Create Order"

      expect(page).to have_content"ご注文ありがとうございます"
    end
  end

  context "注文書の場合" do
    example "注文できること" do
      click_button "購入する"

      fill_in "Name", with: "name"
      fill_in "Address", with: "address"
      fill_in "Email", with: "mail@example.com"
      select "Purchase order", from: "order_pay_type"

      click_button "Create Order"

      expect(page).to have_content"ご注文ありがとうございます"
    end
  end

  context "クレジットカードの場合", vcr: true do
    example "注文できること" do
      click_button "購入する"

      fill_in "Name", with: "name"
      fill_in "Address", with: "address"
      fill_in "Email", with: "mail@example.com"
      select "Credit card", from: "order_pay_type"

      click_button "Create Order"

      fill_in "number", with: "4242424242424242"
      fill_in "cvc", with: "123"
      fill_in "exp_month", with: "03"
      fill_in "exp_year", with: "2099"

      click_button "支払う"

      expect(page).to have_content"ご注文ありがとうございます"
    end
  end
end