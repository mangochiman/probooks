class CreateStudentPosters < ActiveRecord::Migration
  def self.up
    create_table :student_posters, :primary_key => :student_poster_id do |t|
      t.integer :user_id
      t.integer :poster_id
      t.timestamps
    end
  end

  def self.down
    drop_table :student_posters
  end
end
