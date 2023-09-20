class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :contact_center
      t.string :request_number
      t.string :reference_request_number
      t.string :version_number
      t.string :sequence_number
      t.string :request_type
      t.string :request_action
      t.datetime :request_taken_datetime
      t.datetime :transmission_datetime
      t.datetime :legal_datetime
      t.datetime :response_due_datetime
      t.datetime :restake_date
      t.datetime :expiration_date
      t.datetime :lp_meeting_accept_due_date
      t.datetime :overhead_begin_date
      t.datetime :overhead_end_date

      t.timestamps
    end
  end
end
