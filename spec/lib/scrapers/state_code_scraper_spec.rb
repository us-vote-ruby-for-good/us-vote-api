require "rails_helper"

RSpec.describe StateCodeScraper do
  describe "#crawl" do
    let(:state_codes) { File.read(Rails.root.join('spec/fixtures/state_codes.html')) }
    let(:crawled_data)  {  @crawled_data ||= StateCodeScraper.new.crawl }
    let(:states)  {  crawled_data["states"] }
    let(:alabama) { states[1] }
    let(:dc) { states[52] }
    let(:america_somoa) { states[54] }
    let(:headers) { states[0] }
    let(:seranilla_bank) { states[-1] }

    before do
      stub_request(:get, "https://en.wikipedia.org/wiki/List_of_states_and_territories_of_the_United_States")
        .to_return(body: state_codes)
    end

    describe "headers" do
      it "has a wrong name" do
        expect(headers["name"]).to eq("Abbr.")
      end

      it "has no code" do
        expect(headers["code"]).to be_nil
      end

    end

    describe "Alabama" do
      it "has a name" do
        expect(alabama["name"]).to eq("Alabama")
      end

      it "has code" do
        expect(alabama["code"]).to eq("AL")
      end
    end

    describe "District of Columbia" do
      it "has a name" do
        expect(dc["name"]).to eq("District of Columbia")
      end

      it "has code" do
        expect(dc["code"]).to eq("DC")
      end
    end

    describe "American Samoa" do
      it "has a name" do
        expect(america_somoa["name"]).to eq("American Samoa")
      end

      it "has code" do
        expect(america_somoa["code"]).to eq("AS")
      end
    end

    describe "Serranilla Bank" do
      it "has a name" do
        expect(seranilla_bank["name"]).to eq("Serranilla Bank")
      end

      it "has a wrong code" do
        expect(seranilla_bank["code"]).to eq("1880")
      end
    end
  end
end
