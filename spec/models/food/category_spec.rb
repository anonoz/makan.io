require 'spec_helper'

RSpec.describe Food::Category do
  it "is invalid without a title" do
    titleless_cat = build(:food_category, title: nil)
    titleless_cat.valid?
    expect(titleless_cat.errors[:title]).to include "can't be blank"
  end

  it "is valid with a vendor and a name" do
    expect(build(:food_category)).to be_valid
  end

  it "doesn't throw exception when being deleted without food menu under it" do
  	category = create(:food_category)
  	category.destroy
    expect(category.deleted_at).to_not be_nil
  end

  it "cannot be deleted with food menus under it" do
    category = create(:food_category)
    food_menu = create(:food_menu, food_category: category)
    expect(category.destroy).to be false
  end
end
