class DashboardPermission < Indulgence::Permission

  def abilities
    {
      admin: admin
    }
  end
  
  def default
    {
      create: none,
      read:   theirs_and_their_groups,
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
  
  def theirs_and_their_groups
    define_ability(
      name: :theirs_and_their_groups,
      compare_single: lambda {|dashboard, user| user.all_dashboards.include? dashboard},
      filter_many: lambda {|dashboards, user| dashboards.where(id: user.all_dashboard_ids)}
    )
  end
   
end
