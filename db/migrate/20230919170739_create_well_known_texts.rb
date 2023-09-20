class CreateWellKnownTexts < ActiveRecord::Migration[7.0]
  def change
    create_table :well_known_texts do |t|
      t.references :digsite_info, null: false, foreign_key: true
      t.string :wkt

      t.timestamps
    end
  end
end
