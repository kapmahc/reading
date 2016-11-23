module Reading
  class FavoritePolicy < ApplicationPolicy
    def create?
      !user.nil?
    end

    def index?
      !user.nil?
    end

    def destroy?
      !user.nil? && (record.user_id == user.id)
    end
  end
end