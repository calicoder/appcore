class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.integer :user_id
      t.datetime :start_at
      t.datetime :end_at
      t.datetime :availability_confirmed_at
      t.datetime :reserved_at
      t.integer :spot_id
      t.timestamps
    end
  end

  def self.down
    drop_table :reservations
  end
end
