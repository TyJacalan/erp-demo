# frozen_string_literal: true

module Shadcn
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper

    def checkbox(method, options = {})
      @method = method
      options[:class] = @template.tw((options[:class]).to_s)
      label = options[:label]
      @template.render_checkbox(
        name: set_name,
        id: set_id,
        label:,
        **options
      )
    end

    def date_field(method, options = {})
      @method = method
      options = add_error_class(options)
      options[:autocomplete] ||= 'date'
      @template.render_input(
        name: set_name,
        id: set_id,
        value: set_value,
        type: options[:type] || 'date',
        **options
      )
    end

    def dropzone(method, options = {})
      @method = method
      options = add_error_class(options)
      @template.render_dropzone(
        name: set_name,
        id: set_id,
        **options
      )
    end

    def email_field(method, options = {})
      @method = method
      options = add_error_class(options)
      options[:autocomplete] ||= 'email'
      @template.render_input(
        name: set_name,
        id: set_id,
        value: set_value,
        type: 'email',
        **options
      )
    end

    def error_message(method, options = {})
      return unless @object.errors[method].any?

      method_name = method.to_s.capitalize.gsub('_', ' ')
      error_message = @object.errors[method].to_sentence

      content_tag(:p, "#{method_name} #{error_message}",
                  options.merge(class: 'text-destructive'))
    end

    def label(method, options = {})
      @method = method
      options[:class] = @template.tw((options[:class]).to_s)
      @template.render_label(
        name: set_name,
        label: label_for(@object, method), **options
      )
    end

    def phone_field(method, options = {})
      @method = method
      options = add_error_class(options)
      options[:autocomplete] ||= 'tel'
      @template.render_input(
        name: set_name,
        id: set_id,
        value: set_value,
        type: 'tel',
        **options
      )
    end

    def number_field(method, options = {})
      @method = method
      options = add_error_class(options)
      @template.render_input(
        name: set_name,
        id: set_id,
        value: set_value,
        type: 'number',
        **options
      )
    end

    def text_field(method, options = {})
      @method = method
      options = add_error_class(options)
      @template.render_input(
        name: set_name,
        id: set_id,
        value: set_value,
        type: 'text',
        **options
      )
    end

    def textarea(method, options = {}, &block)
      @method = method
      options = add_error_class(options)
      @template.render_textarea(
        name: set_name,
        id: set_id,
        value: set_value,
        **options,
        &block
      )
    end

    def password_field(method, options = {})
      @method = method
      options = add_error_class(options)
      options[:autocomplete] ||= 'new-password'
      @template.render_input(
        name: set_name,
        id: set_id,
        value: set_value,
        type: 'password',
        **options
      )
    end

    def search_field(method, options = {})
      # requires ransack
      options[:autocomplete] ||= 'off'
      @template.render_input(
        name: "q[#{method}]",
        id: "q_#{method}",
        value: set_value,
        type: 'text',
        **options
      )
    end

    def select_field(method, options = {}, &block)
      @method = method

      select_html = @template.render_select(
        name: set_name,
        id: set_id,
        selected: options[:selected],
        **options,
        &block
      )

      if block_given?
        select_html
      else
        select_html + hidden_field(method)
      end
    end

    def submit(value = nil, options = {})
      @template.render_button(value, **options)
    end

    private

    def label_for(object, method)
      return method.capitalize if object.nil?

      object.class.human_attribute_name(method)
    end

    def add_error_class(options)
      error_class = @object.errors[@method].any? ? 'error' : '' unless @object.nil?
      options[:class] = @template.tw("#{options[:class]} #{error_class}")
      options
    end

    def set_name
      @object.present? ? "#{object_name}[#{@method}]" : @method.to_s
    end

    def set_id
      @object.present? ? "#{object_name}_#{@method}" : @method.to_s
    end

    def set_value
      @object.present? ? @object.send(@method) : ''
    end
  end
end
