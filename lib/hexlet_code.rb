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
end

# generates HTML fields for form
class Struct
  include HexletCode

  def input(key, **options)
    @input = []
    
    field = self.to_h.each_with_object({}) do |(name, value), pair|
      pair[name] = case options[:as]
                   when :text then "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
                   else "name='#{name}' type='text' value='#{value}'"
                   end
    end

    case options[:as]
    when :text
      @input << label(key)
      @input << "  <textarea "
      @input << field.fetch(key)
      @input << '>'
      @input << self.to_h.fetch(key)
      @input << "</textarea>\n"
    else
      @input << label(key)
      @input << "  <input "
      @input << field.fetch(key)
      @input << (options.map { |name, value| " #{name}='#{value}'" })
      @input << ">\n"
    end
  end

  def submit(*name)
    @input << "  <input type='submit'"
    @input << " name='#{name.any? ? name.join : 'Save'}'"
    @input << ">\n"
    @input.join
  end

  def label(name, *label)
    label << "  <label for='#{name}'"
    label << ">"
    label << name.to_s.capitalize
    label << "</label>\n"
    label.join
  end
end
