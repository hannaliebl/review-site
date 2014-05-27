class AddLifterType1ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lifter_type1, :boolean
    add_column :users, :lifter_type2, :boolean
    add_column :users, :lifter_type3, :boolean
    add_column :users, :lifter_type4, :boolean
    add_column :users, :lifter_type5, :boolean
    add_column :users, :lifter_type6, :boolean
  end
end
