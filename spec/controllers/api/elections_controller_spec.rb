require 'rails_helper'

RSpec.describe Api::ElectionsController, type: :controller do
  describe 'GET index' do
    let!(:state)    { FactoryGirl.create(:state, code: 'MD') }
    let!(:election) do
      FactoryGirl.create(:election,
        jurisdiction:  state,
        election_type: "primary",
        election_date: Date.tomorrow
      )
    end
    let!(:voting_option) do
      FactoryGirl.create(:voting_option,
        election_id:         election.id,
        voting_type:         "absentee",
        dates_and_deadlines: {
          registration: {
            "date_type" => "postmark",
            "date"      => Date.yesterday
          }
        }
      )
    end

    before do
      get :index, state_id: 'MD', format: :json
    end

    it 'returns the data' do
      expect(response).to be_successful

      data     = JSON.parse(response.body)
      expected = {
        "data" => [
          {
            "id"         => election.id.to_s,
            "type"       => "elections",
            "attributes" => {
              "election_type"  => "primary",
              "election_date"  => Date.tomorrow.to_s(:db),
              "voting_options" => [
                {
                  "voting_type"         => "absentee",
                  "dates_and_deadlines" => {
                    "registration" => {
                      "date_type" => "postmark",
                      "date"      => Date.yesterday.to_s(:db)
                    }
                  }
                }
              ]
            }
          }
        ]
      }

      expect(data).to eq(expected)
    end
  end
end