class AddLifterType1ToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :lifter_type1, :boolean
    add_column :profiles, :lifter_type2, :boolean
    add_column :profiles, :lifter_type3, :boolean
    add_column :profiles, :lifter_type4, :boolean
    add_column :profiles, :lifter_type5, :boolean
    add_column :profiles, :lifter_type6, :boolean
  end
end