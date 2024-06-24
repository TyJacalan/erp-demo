module Components::CollapsibleHelper
  def render_collapsible(**options, &block)
    content = capture(&block) if block
    render "components/ui/collapsible", content:, **options, flush: true
  end

  def collapsible_trigger(&block)
    content_for :collapsible_trigger, capture(&block), flush: true
  end

  def collapsible_preview(&block)
    content_for :preview, capture(&block), flush: true
  end

  def collapsible_body(&block)
    content_for :body, capture(&block), flush: true
  end
end
