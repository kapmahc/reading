module Reading
  class Note < ApplicationRecord
    validates :body, presence: true
    belongs_to :book, class_name: 'Reading::Book', foreign_key: 'reading_book_id'

    belongs_to :user
  end
end
