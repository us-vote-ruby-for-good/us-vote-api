require 'rails_helper'

RSpec.feature "User management by admins", type: :feature do

  let(:login_user) { FactoryGirl.create(:user) }

  before(:each) do
    login_as(login_user, :scope => :user)
    clear_emails
  end

  scenario "Creates a new admin user, who gets a reset password email" do
    new_user_email = 'foo@bar.com'

    visit 'admin/users'
    expect(page).to have_text(login_user.email)
    fill_in 'user_email', with: new_user_email
    click_button 'Create User'
    expect(page).to have_text("We've sent an email") # flash message
    expect(page).to have_text(new_user_email)

    open_email(new_user_email)
    expect(current_email).to have_content "password"
  end

  scenario "Deletes an admin user" do
    user_to_delete = FactoryGirl.create(:user)

    visit 'admin/users'
    expect(page).to have_text(user_to_delete.email)

    user_section_selector = ".user-#{user_to_delete.id}"

    within(user_section_selector) do
      click_button "Delete"
    end
    expect(page).to_not have_selector(user_section_selector)
  end
end
