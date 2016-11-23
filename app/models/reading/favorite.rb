module Reading
  class Favorite < ApplicationRecord
    validates :title, :href, presence: true
    validates :href, uniqueness: { scope: :user_id}

    belongs_to :user
  end
end
