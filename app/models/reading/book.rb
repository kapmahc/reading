module Reading
  class Book < ApplicationRecord
    validates :author, :publisher, :title, :version, :lang, :subject, :published_at, presence: true

    has_many :notes, class_name: 'Reading::Note', foreign_key: 'reading_book_id'
  end
end
