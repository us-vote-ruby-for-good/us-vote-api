require 'rails_helper'

RSpec.feature "User management by admins", type: :feature do

  before(:each) do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  scenario "Creates a new admin user" do
    visit 'admin/users'
    expect(page).to have_text("Foo")
  end
end
