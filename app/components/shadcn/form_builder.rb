# frozen_string_literal: true

module Shadcn
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper

    def checkbox(method, options = {})
      options[:class] = @template.tw((options[:class]).to_s)
      label = options[:label]
      @template.render_checkbox(
        name: "#{object_name}[#{method}]",
        label:,
        id: "#{object_name}_#{method}",
        **options
      )
    end

    def email_field(method, options = {})
      error_class = @object.errors[method].any? ? 'error' : ''
      options[:class] = @template.tw("#{options[:class]} #{error_class}")
      @template.render_input(
        name: "#{object_name}[#{method}]",
        id: "#{object_name}_#{method}",
        value: @object.send(method),
        type: 'email', **options
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
      options[:class] = @template.tw((options[:class]).to_s)
      @template.render_label(
        name: "#{object_name}[#{method}]",
        label: label_for(@object, method), **options
      )
    end

    def number_field(method, options = {})
      error_class = @object.errors[method].any? ? 'error' : ''
      options[:class] = @template.tw("#{options[:class]} #{error_class}")

      @template.render_input(
        name: "#{object_name}[#{method}]",
        id: "#{object_name}_#{method}",
        value: @object.send(method),
        type: 'number', **options
      )
    end

    def text_field(method, options = {})
      error_class = @object.errors[method].any? ? 'error' : ''
      options[:class] = @template.tw("#{options[:class]} #{error_class}")
      @template.render_input(
        name: "#{object_name}[#{method}]",
        id: "#{object_name}_#{method}",
        value: @object.send(method),
        type: 'text', **options
      )
    end

    def password_field(method, options = {})
      error_class = @object.errors[method].any? ? 'error' : ''
      options[:class] = @template.tw("#{options[:class]} #{error_class}")
      @template.render_input(
        name: "#{object_name}[#{method}]",
        id: "#{object_name}_#{method}",
        value: @object.send(method),
        type: 'password', **options
      )
    end

    def select_field(method, options = {}, &)
      error_class = @object.errors[method].any? ? 'error' : ''
      options[:class] = @template.tw("#{options[:class]} #{error_class}")

      select_html = @template.render_select(
        name: "#{object_name}[#{method}]",
        id: "#{object_name}_#{method}",
        selected: options[:selected],
        **options,
        &
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
  end
end
