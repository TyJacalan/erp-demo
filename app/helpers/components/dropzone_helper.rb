module Components::DropzoneHelper
  def render_dropzone(name:, id: nil)
    render partial: "components/ui/dropzone", locals: { name:, id:}
  end
end
