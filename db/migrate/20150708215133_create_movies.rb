class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title, limit: 50, null: false
      t.string :format, null: false
      t.integer :length, null: false
      t.integer :release_year, null: false
      t.integer :rating
    end
  end
end
