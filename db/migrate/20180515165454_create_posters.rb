class CreatePosters < ActiveRecord::Migration
  def self.up
    create_table :posters, :primary_key => :poster_id do |t|
      t.string :title
      t.string :filename
      t.binary :content, :limit => 50.megabyte
      t.string :content_type
      t.timestamps
    end
  end

  def self.down
    drop_table :posters
  end
end
