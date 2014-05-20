class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :about
      t.string :location
      t.string :type_of_lifter
      t.integer :user_id

      t.timestamps
    end
  end
end
