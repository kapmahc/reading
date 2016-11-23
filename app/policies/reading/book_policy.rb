module Reading
  class BookPolicy < ApplicationPolicy

    def admin?
      !user.nil? && user.is_admin?
    end

    def destroy?
      !user.nil? && user.is_admin?
    end
  end
end