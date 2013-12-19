
class UserPermission < Indulgence::Permission
  
  def abilities
    {
      admin: admin
    }
  end
  
  def default
    {
      create: none,
      read:   their_own_instance,
      update: none,
      delete: none
    }
  end
  
  def admin
    {
      create: all,
      read:   all,
      update: all,
      delete: all
    }
  end
  
  def their_own_instance
    define_ability(:id)
  end
end
