class CreateReadingFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :reading_favorites do |t|
      t.string :href, null:false
      t.string :title, null:false, index:true
      t.belongs_to :user, foreign_key: true
      t.datetime :created_at, null:false
    end
    add_index :reading_favorites, [:href, :user_id], unique:true
  end
end
