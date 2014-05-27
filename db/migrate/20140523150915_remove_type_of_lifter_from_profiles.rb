class RemoveTypeOfLifterFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :type_of_lifter, :string
  end
end
