class CreateIntersections < ActiveRecord::Migration[7.0]
  def change
    create_table :intersections do |t|
      t.references :digsite_info, null: false, foreign_key: true
      t.string :intersection_state
      t.string :intersection_county
      t.string :intersection_place
      t.string :intersection_prefix
      t.string :intersection_name
      t.string :intersection_type
      t.string :intersection_suffix

      t.timestamps
    end
  end
end
