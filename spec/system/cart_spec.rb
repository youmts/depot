require "rails_helper"

RSpec.describe "Cart", type: :system, js: true do
  let!(:product) { create(:product) }

  example "Cartに商品を追加できること" do
    visit "/"

    within("#aside-cart") { expect(page).not_to have_content product.title }

    expect {
      click_button "Add to Cart"

      within("#aside-cart") do
        expect(page).to have_content product.title
        expect(page).to have_content "1 times;"
      end
    }.to change(CartItem, :count).by(1)

    expect(page).to have_current_path "/"

    cart = Cart.last
    expect(cart.items.first.quantity).to eq 1

    # 二個目
    visit "/"

    expect {
      click_button "Add to Cart"

      within("#aside-cart") do
        expect(page).to have_content product.title
        expect(page).to have_content "2 times;"
      end
    }.to change { cart.items.first.quantity }.by(1)

    expect(page).to have_current_path "/"
  end

  example "商品一覧でCartを空にできること" do
    visit "/"

    within("#aside-cart") { expect(page).not_to have_content product.title }

    # カートに商品を追加
    expect {
      click_button "Add to Cart"

      within("#aside-cart") do
        expect(page).to have_content product.title
      end
    }.to change(CartItem, :count).by(1)

    # カートを空にする
    expect {
      click_button "Empty Cart"

      within("#aside-cart", visible: false) do
        expect(page).not_to have_content product.title
      end
    }.to change(CartItem, :count).by(-1)
  end
end
