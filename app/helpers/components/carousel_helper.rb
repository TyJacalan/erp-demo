module Components
    module CarouselHelper
      def render_carousel(&block)
        @_slides = []
        capture(&block)
        render 'components/ui/carousel'
      end
  
      def carousel_slides(&block)
        content_for :carousel_slides, capture(&block), flush: true
      end
  
      def carousel_slide(**options, &block)
        content_for :slide, capture(&block), flush: true
        render('components/ui/carousel/slide', options:)
      end
    end
  end  