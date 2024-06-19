module Components
  module AvatarHelper
    def render_avatar(src: nil, alt: nil, size: '100x100', variant: :default, **options)
      avatar_classes = src ? 'object-cover rounded-full' : 'flex items-center justify-center bg-accent rounded-full'
      variant_classes = case variant.to_sym
                        when :default
                          'h-8 w-8'
                        when :small
                          'h-4 w-4 sm:h-8 sm:w-8 text-xs'
                        when :large
                          'h-12 w-12 sm:h-24 sm:w-24 text-3xl'
                        end
      avatar_classes << " #{variant_classes} #{options[:class]}"
      avatar_classes = tw(avatar_classes)
      render 'components/ui/avatar', avatar_classes:, src:, alt:, size:, **options
    end
  end
end
