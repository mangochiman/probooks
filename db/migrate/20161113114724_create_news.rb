class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news, :primary_key => :news_id do |t|
      t.string :title
      t.text :data
      t.boolean :active, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
