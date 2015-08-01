class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :code
      t.string :name
      t.integer :drupal_id

      t.timestamps null: false
    end
  end
end
