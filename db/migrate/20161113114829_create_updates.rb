class CreateUpdates < ActiveRecord::Migration
  def self.up
    create_table :updates, :primary_key => :update_id do |t|
      t.string :title
      t.text :details
      t.boolean :active, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :updates
  end
end
