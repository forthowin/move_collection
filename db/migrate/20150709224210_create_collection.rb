class CreateCollection < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :movie_id
      t.timestamps
    end
  end
end
