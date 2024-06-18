module Components
  module ButtonHelper
    def render_button(label = '', text: nil, variant: :default, as: :button, href: nil, data: {}, **options, &block)
      button_classes = ' inline-flex items-center justify-center rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 h-10 px-4 py-2 '
      link_classes = as == :link ? ' h-fit w-full p-0 justify-start' : ''
      varianet_classes = case variant.to_sym
                         when :default
                           ' bg-primary text-primary-foreground hover:bg-primary/90 '
                         when :secondary
                           ' bg-secondary text-secondary-foreground hover:bg-secondary/80 '
                         when :error, :danger, :alert, :destructive
                           ' bg-destructive text-destructive-foreground hover:bg-destructive/90 '
                         when :destructive_outline
                           '  text-destructive border border-destructive bg-background hover:bg-destructive hover:text-destructive-foreground'
                         when :outline
                           '  border border-input bg-background hover:bg-accent hover:text-accent-foreground'
                         when :ghost
                           ' hover:bg-accent hover:text-accent-foreground  '
                         end
      button_classes << " #{varianet_classes} #{link_classes} #{options[:class]}"
      button_classes = tw(button_classes)
      text = label if label.present?
      text = capture(&block) if block
      render 'components/ui/button', text:, button_classes:, as:, href:, data:, **options
    end
  end
end
