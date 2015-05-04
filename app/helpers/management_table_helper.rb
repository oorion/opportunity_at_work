module ManagementTableHelper
  def updated_at_time(object)
    object.updated_at.strftime("Updated on %m/%d/%Y %I:%M%p")
  end
end
