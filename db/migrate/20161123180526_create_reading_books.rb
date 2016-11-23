class CreateReadingBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :reading_books do |t|
      t.string :author, null:false, index:true
      t.string :publisher, null:false, index:true
      t.string :title, null:false, index:true
      t.string :flag, null:false, index:true
      t.string :lang, null:false, index:true
      t.string :subject, null:false, index:true
      t.text :description
      t.text :home, null:false
      t.integer :vote, null:false, default: 0
      t.date :published_at, null:false

      t.timestamps
    end
  end
end
