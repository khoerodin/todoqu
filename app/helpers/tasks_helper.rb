module TasksHelper
  def task_priority(type, number)
    case number
    when 1
      badge = 'danger'
      text = 'Critical'
    when 2
      badge = 'warning'
      text = 'High'
    when 3
      badge = 'info'
      text = 'Medium'
    when 4
      badge = 'success'
      text = 'Low'
    end

    if type == 'badge'
      return badge
    elsif type == 'text'
      return text
    end
  end
end
