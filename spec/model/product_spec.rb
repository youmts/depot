require 'rails_helper'

RSpec.describe Product do
  example "有効なFactoryであること" do
    expect(build(:product).valid?).to be_truthy
  end
end