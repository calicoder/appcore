class CreateReservationAttempts < ActiveRecord::Migration
  def self.up
    create_table :reservation_attempts do |t|
      t.integer :reservation_id
      t.integer :spot_id
      t.datetime :availability_confirmed_at
      t.datetime :reserved_at
      t.timestamps
    end
  end

  def self.down
    drop_table :reservation_attempts
  end
end
