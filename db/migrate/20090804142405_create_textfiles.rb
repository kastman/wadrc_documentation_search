class CreateTextfiles < ActiveRecord::Migration
  def self.up
    create_table :textfiles do |t|
      t.string :filepath
      t.string :content
      t.string :owner
      t.datetime :modified_at
      t.datetime :accessed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :textfiles
  end
end
