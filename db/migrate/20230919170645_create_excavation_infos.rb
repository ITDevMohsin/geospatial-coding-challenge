class CreateExcavationInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :excavation_infos do |t|
      t.references :ticket, null: false, foreign_key: true
      t.string :type_of_work
      t.string :work_done_for
      t.string :project_duration
      t.datetime :project_start_date
      t.string :explosives
      t.string :underground_overhead
      t.string :horizontal_boring
      t.string :whitelined
      t.text :locate_instructions
      t.text :remarks

      t.timestamps
    end
  end
end
