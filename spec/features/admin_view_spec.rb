require 'rails_helper'

RSpec.feature "Viewing details by admins", type: :feature do

  let(:login_user) { FactoryGirl.create(:user) }
  let(:gold_state) { FactoryGirl.create(:state)}
  before(:each) do
    login_as(login_user, :scope => :user)
    gold_state

    
  end

  scenario "Admin user checks out a states elections" do
    visit 'admin/states'
    expect(page).to have_text(gold_state.name)

  end
  
end