require "rails_helper"

RSpec.describe "Cart" do
  let!(:product) { create(:product) }

  example "Cartに商品を追加できること" do
    visit "/"

    expect {
      click_button "Add to Cart"
    }.to change(CartItem, :count).by(1)

    expect(page).to have_current_path cart_path(Cart.last)
  end
end
