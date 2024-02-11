# frozen_string_literal: true

require_relative 'hexlet_code/version'
# require_relative 'hexlet_code/struct'

require 'active_support/all'

# generates HTML forms
module HexletCode
  autoload(:Tag, './lib/hexlet_code/tag.rb')

  def self.form_for(struct, *form, **options)
    form << '<form'
    form << " action='#{options.fetch(:url, '#')}'" || " action='#'"
    form << " method='#{options.fetch(:method, 'post')}'" || " method='post'"
    options.each { |key, value| form << " #{key}='#{value}'" if key != :url && key != :method }
    form << ">\n"
    form << yield(FormBuilder.new(struct)) if block_given?
    form << '</form>'
    form.join
  end

  # generates fields for form
  class FormBuilder
    def initialize(struct)
      @struct = struct
      @input = []
    end

    def input(key, **options)
      @struct.public_send(key) unless @struct.to_h[key]

      @field = @struct.to_h.each_with_object({}) do |(name, value), pair|
        pair[name] = case options[:as]
                     when :text
                       "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
                     when nil
                       "name='#{name}' type='text' value='#{value}'"
                     end
      end
      builder(key, **options)
    end

    def builder(key, **options)
      @input << label(key)

      if options[:as] == :text
        @input << "  <textarea #{@field.fetch(key)}>"
        @input << "#{@struct.to_h.fetch(key)}</textarea>\n"
      else
        @input << "  <input #{@field.fetch(key)}"
        @input << (options.map { |name, value| " #{name}='#{value}'" })
        @input << ">\n"
      end
    end

    def label(name, *label)
      label << "  <label for='#{name}'"
      label << '>'
      label << name.to_s.capitalize
      label << "</label>\n"
    end

    def submit(name = nil, *_submit)
      @input << "  <input type='submit'"
      @input << (" value='#{name.nil? ? 'Save' : name}'")
      @input << ">\n"
    end
  end
end
