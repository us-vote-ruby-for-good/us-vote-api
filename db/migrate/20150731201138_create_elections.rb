class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.references :jurisdiction, index: true, polymorphic: true
      t.date :election_date
      t.string :election_type

      t.timestamps null: false
    end
  end
end
