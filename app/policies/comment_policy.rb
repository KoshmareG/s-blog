class CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def edit?
    create? && (record.try(:user) == user)
  end

  def destroy?
    edit?
  end
end
