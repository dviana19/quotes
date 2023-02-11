# frozen_string_literal: true

module ApplicationResponder
  def render_with(resource, location, &block)
    message = render_with_message(resource)
    if resource.persisted? || resource.destroyed?
      respond_to do |format|
        format.html { redirect_to location, notice: message }
        format.turbo_stream { flash.now[:notice] = message }
      end
    elsif block
      yield
    end
  end

  def render_with_message(resource)
    scope = "flash.actions.#{action_name}.notice"

    resource_name = resource.class.name.underscore.humanize
    resource_name = resource.class.model_name.human if resource.class.respond_to?(:model_name)

    I18n.t(scope, resource_name:)
  end
end
