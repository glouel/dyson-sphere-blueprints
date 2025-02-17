class BlueprintPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    if (record.collection.type == "Private")
      if user && user.admin?
        true
      else
        record.user == user
      end
    else
      true
    end
  end

  def create?
    return true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def like?
    true
  end

  def unlike?
    true
  end
end
