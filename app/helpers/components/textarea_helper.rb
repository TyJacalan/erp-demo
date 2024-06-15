# frozen_string_literal: true

module Components
  module TextareaHelper
    def render_textarea(name:, label: false, id:, value: nil, **options)
      options.reverse_merge!(rows: 3, required: false, disabled: false,
                             readonly: false, class: '', label: false, placeholder: 'Type here...')
      render partial: 'components/ui/textarea', locals: {
        label:,
        name:,
        id:,
        value:,
        options:
      }
    end
  end
end
