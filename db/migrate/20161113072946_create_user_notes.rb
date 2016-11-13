class CreateUserNotes < ActiveRecord::Migration
  def self.up
    create_table :user_notes, :primary_key => :user_note_id do |t|
      t.integer :user_id
      t.text :data
      t.timestamps
    end
  end

  def self.down
    drop_table :user_notes
  end
end
