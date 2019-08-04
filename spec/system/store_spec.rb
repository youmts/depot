require "rails_helper"

RSpec.describe "Store", type: :system do
  let(:product) { create(:product) }

  example "rootでカタログが表示できること" do
    product
    visit "/"

    expect(page).to have_content product.title
  end

  example "store/indexでカタログが表示できること" do
    product
    visit store_index_path

    expect(page).to have_content product.title
  end

end