module ApplicationHelper
  include Pagy::Frontend

  def flash_class(level)
    case level
    when 'notice' then 'notification is-primary'
    when 'success' then 'notification is-success'
    when 'error' then 'notification is-danger'
    when 'alert' then 'notification is-warning'
    end
  end
end
