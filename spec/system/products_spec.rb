require "rails_helper"

RSpec.describe 'Products', type: :system do
  let(:product) { create(:product) }

  example "商品を表示できること" do
    visit product_path(product)

    expect(page).to have_content(product.title)
  end

  example "商品一覧を表示できること" do
    product
    visit products_path

    expect(page).to have_content(product.title)
  end

  example "商品を登録できること" do
    visit new_product_path
    fill_in "product[title]", with: "title"
    fill_in "product[description]", with: "description"
    attach_file "product[image]", "spec/support/bg-tomato.png"
    fill_in "product[price]", with: "100"

    expect {
      click_button "commit"
    }.to change(Product, :count).by(1)

    expect(page).to have_current_path product_path(Product.last), ignore_query: true
  end

  example "商品を編集できること" do
    visit edit_product_path product
    fill_in "product[title]", with: "new_title"

    click_button "commit"

    expect(page).to have_current_path product_path(product), ignore_query: true
    expect(page).to have_content "new_title"
  end

  example "商品を削除できること" do
    product
    visit products_path

    expect {
      click_link "Destroy"
    }.to change(Product, :count).by(-1)
  end
end