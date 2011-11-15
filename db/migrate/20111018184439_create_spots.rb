class CreateSpots < ActiveRecord::Migration
  def self.up
    create_table :spots do |t|
      t.integer :user_id
      t.string :address_1
      t.string :address_2
      t.string :city
      t.integer :state
      t.integer :country
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end

  def self.down
    drop_table :spots
  end
end
