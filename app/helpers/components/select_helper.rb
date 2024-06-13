module Components::SelectHelper
  def render_select(name:, id:, **options, &block)
    component = Shadcn::SelectComponent.new(name:, id:, view_context: self, **options, &block)
    component.call
  end
end
