class AddOwnerToTextfile < ActiveRecord::Migration
  def self.up
    add_column :textfiles, :owner, :string
  end

  def self.down
    remove_column :textfiles, :owner
  end
end
