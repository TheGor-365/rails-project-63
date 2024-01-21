# frozen_string_literal: true

require_relative "hexlet_code/version"
# require_relative 'hexlet_code/struct'

require "active_support/all"

# generates HTML forms
module HexletCode
  autoload(:Tag, "./lib/hexlet_code/tag.rb")

  def self.form_for(struct, url = {}, *form)
    form << (url.key?(:url) ? "<form action='#{url.fetch(:url)}' method='post'>\n" : "<form action='#' method='post'>\n")
    form << yield(struct)
    form << "</form>"
    form.join
  end

  def initialize(attributes)
    @attributes = attributes
    @fields = []
  end
end

# generates HTML fields for form
class Struct
  include HexletCode

  def initialize(params = User.new)
    super
  end

  def input(attr_name, **options)
    @field = @attributes.each_with_object({}) do |(name, value), pair|
      pair[name] = case options[:as]
                   when :text then "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
                   else "name='#{name}' type='text' value='#{value}'"
                   end
    end

    field_builder(attr_name, **options)
  end

  def field_builder(attr_name, **options)
    public_send(attr_name) unless @attributes[attr_name]

    case options[:as]
    when :text
      @fields << label(attr_name)
      @fields << "  <textarea "
      @fields << @field.fetch(attr_name)
      @fields << ">"
      @fields << @attributes.fetch(attr_name)
      @fields << "</textarea>\n"
    else
      @fields << label(attr_name)
      @fields << "  <input "
      @fields << @field.fetch(attr_name)
      @fields << (options.map { |name, value| " #{name}='#{value}'" })
      @fields << ">\n"
    end
  end

  def submit(*button_name)
    @fields << "  <input type='submit'"
    @fields << " value='#{button_name.present? ? button_name.join : "Save"}'"
    @fields << ">\n"
    @fields.join
  end

  def label(name, *label)
    label << "  <label for='#{name}'"
    label << ">"
    label << name.to_s.capitalize
    label << "</label>\n"
    label.join
  end
end
