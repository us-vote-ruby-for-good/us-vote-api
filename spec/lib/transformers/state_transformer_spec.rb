require "rails_helper"

RSpec.describe StateTransformer do
  let(:state_codes) {
    [
      {
        "name" => "Abbr.",
        "code" => nil
      },
      {
        "name" => "Alabama",
        "code" => "AL"
      },
      {
        "name" => "Serranilla Bank",
        "code" => "1880"
      }
    ]
  }

  let(:state_drupal_ids) {
    [
      {
        "drupal_id" => "0",
        "name" => "- Select Your State -"
      },
      {
        "drupal_id" => "1",
        "name" => "Alabama"
      }
    ]
  }
  let(:transformer) { StateTransformer.new(state_drupal_ids, state_codes) }

  describe "#filter_state_codes" do
    it "codes filter out nils and non two letter codes" do
      transformer.filtered_state_codes.each do |state_code|
        expect(state_code["code"]).to be_truthy
        expect(state_code["code"].length).to eq(2)
      end
      expect(transformer.filtered_state_codes.length).to eq(1)
    end
  end

  describe "#filter_state_drupal_ids" do
    it "codes filter out nils and non two letter codes" do
      transformer.filtered_state_drupal_ids.each do |drupal_id|
        expect(drupal_id["drupal_id"].to_i).to be > 0
        expect(drupal_id["name"].start_with?("-")).to be_falsy
      end
      expect(transformer.filtered_state_drupal_ids.length).to eq(1)
    end
  end

  describe "#tranform" do
    it "returns hashes with name drupal ids and states" do
      transformed_data = transformer.transform
      expect(transformed_data.length).to eq(1)
      alabama = transformed_data.first
      expect(alabama["name"]).to eq("Alabama")
      expect(alabama["drupal_id"]).to eq("1")
      expect(alabama["code"]).to eq("AL")
    end
  end
end
