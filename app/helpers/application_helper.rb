module ApplicationHelper
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  rescue
    render_404
  end

  def render_404
    render file: "#{Rails.root}/app/views/layouts/404", status: :not_found
  end
end
