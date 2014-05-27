class RemoveLifterType1FromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :lifter_type1, :boolean
    remove_column :users, :lifter_type2, :boolean
    remove_column :users, :lifter_type3, :boolean
    remove_column :users, :lifter_type4, :boolean
    remove_column :users, :lifter_type5, :boolean
    remove_column :users, :lifter_type6, :boolean
  end
end
