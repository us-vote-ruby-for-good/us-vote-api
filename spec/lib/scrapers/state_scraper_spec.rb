require "rails_helper"

RSpec.describe StateScraper do
  describe "#crawl" do
    let(:stater_voter_information) { File.read(Rails.root.join('spec/fixtures/state_voter_information_directionary.html')) }
    let(:crawled_data) { @crawled_data ||= StateScraper.new.crawl["states"] }
    let(:select_your_state) { crawled_data[0] }
    let(:alabama) { crawled_data[1] }

    before do
      stub_request(:get, "https://www.usvotefoundation.org/vote/sviddomestic.htm")
        .to_return(body: stater_voter_information)
    end

    it "has states" do
      expect(select_your_state["drupal_id"]).to eq("0")
      expect(select_your_state["name"]).to eq("- Select Your State -")
      expect(alabama["drupal_id"]).to eq("1")
      expect(alabama["name"]).to eq("Alabama")
    end
  end
end
