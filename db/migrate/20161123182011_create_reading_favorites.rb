class CreateReadingFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :reading_favorites do |t|
      t.string :resource_type, null:false, index:true
      t.integer :resource_id, null:false
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
    add_index :reading_favorites, [:resource_type, :resource_id, :user_id], unique:true, name: 'idx_reading_favorites_ids'
  end
end
