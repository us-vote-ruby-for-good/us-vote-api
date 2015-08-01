class CreateVotingOptions < ActiveRecord::Migration
  def change
    create_table :voting_options do |t|
      t.string :voting_type
      t.json :dates_and_deadlines, default: {}
      t.references :election, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
