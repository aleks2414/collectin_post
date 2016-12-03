class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.string :category
      t.string :paper
      t.references :user, index: true, foreign_key: true
      t.boolean :favorite
      t.string :url
      t.string :photo

      t.timestamps null: false
    end
  end
end
