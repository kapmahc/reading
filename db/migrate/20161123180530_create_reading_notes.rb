class CreateReadingNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :reading_notes do |t|
      t.string :flag, limit:8, null:false, index:true
      t.text :body, null:false
      t.integer :vote, null:false, default: 0
      t.belongs_to :reading_book, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
