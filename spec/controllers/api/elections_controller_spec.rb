require 'rails_helper'

RSpec.describe Api::ElectionsController, type: :controller do
  describe 'GET index' do
    let!(:state)    { FactoryGirl.create(:state,    code: 'MD') }
    let!(:election) { FactoryGirl.create(:election, jurisdiction: state) }

    before do
      get :index, state_id: 'MD', format: :json
    end

    it 'returns the data' do
      expect(response).to be_successful

      pending "write moar"
    end
  end
end