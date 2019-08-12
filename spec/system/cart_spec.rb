require "rails_helper"

RSpec.describe "Cart" do
  let!(:product) { create(:product) }

  example "Cartに商品を追加できること" do
    visit "/"

    expect {
      click_button "Add to Cart"
    }.to change(CartItem, :count).by(1)

    expect(page).to have_current_path cart_path(Cart.last)

    cart = Cart.last
    expect(cart.items.first.quantity).to eq 1

    # 二個目
    visit "/"

    expect {
      click_button "Add to Cart"
    }.to change { cart.items.first.quantity }.by(1)

    expect(page).to have_current_path cart_path(Cart.last)
  end

  example "Cartを空にできること" do
    visit "/"

    expect {
      click_button "Add to Cart"
    }.to change(Cart, :count).by(1)

    cart = Cart.last

    visit cart_path(cart)
    expect {
      click_button "カートを空にする"
    }.to change(Cart, :count).by(-1)

    expect { visit cart_path(cart) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
