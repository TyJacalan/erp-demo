module Components::CheckboxHelper
  def render_checkbox(label: nil, name:, **options)
    render "components/ui/checkbox", name:, label:, options:
  end
end
