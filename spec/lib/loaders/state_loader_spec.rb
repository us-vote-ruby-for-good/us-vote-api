require "rails_helper"

RSpec.describe StateLoader do
  let(:states) {
    [
      {
        "name" => "Alabama",
        "drupal_id" => "1",
        "code" => "AL",
      }
    ]
  }

  let(:loader) { StateLoader.new(states) }

  describe "#save" do
    it "increases states, but doesn't duplicate" do
      expect { loader.save }.to change(State, :count).by(1)
      expect { loader.save }.to change(State, :count).by(0)
    end
  end
end
