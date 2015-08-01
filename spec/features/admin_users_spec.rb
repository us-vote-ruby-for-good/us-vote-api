require 'rails_helper'

RSpec.feature "User management by admins", type: :feature do

  let(:login_user) { FactoryGirl.create(:user) }

  before(:each) do
    login_as(login_user, :scope => :user)
  end

  scenario "Creates a new admin user" do
    new_user_email = 'foo@bar.com'

    visit 'admin/users'
    expect(page).to have_text(login_user.email)
    fill_in 'user_email', with: new_user_email
    click_button 'Create User'
    expect(page).to have_text("We've sent an email") # flash message
    expect(page).to have_text(new_user_email)
  end
end
