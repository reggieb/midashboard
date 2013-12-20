
class WidgetPermission < Indulgence::Permission
  
  def abilities
    {
      admin: admin
    }
  end
  
  def default
    {
      create: none,
      read:   all,
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

end
