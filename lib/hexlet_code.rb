# frozen_string_literal: true

require_relative "hexlet_code/version"
# require_relative 'hexlet_code/struct'

require "active_support/all"

# generates HTML forms
module HexletCode
  autoload(:Tag, "./lib/hexlet_code/tag.rb")

  def self.form_for(struct, *form, **options)
    form << "<form"
    form << (options.key?(:url) ? " action='#{options.fetch(:url)}'" : " action='#'")
    form << (options.key?(:method) ? " method='#{options.fetch(:method)}'" : " method='post'")
    options.each { |key, value| form << " #{key}='#{value}'" if key != :url && key != :method }
    form << ">\n"
    form << yield(struct) if block_given?
    form << "</form>"
    form.join
  end

  @@input = []
end

# generates HTML fields for form
class Struct
  include HexletCode

  def input(key, **options)
    public_send(key) unless to_h[key]

    @field = to_h.each_with_object({}) do |(name, value), pair|
      pair[name] = case options[:as]
                   when :text then "name='#{name}' cols='#{options.fetch(:cols, 20)}' rows='#{options.fetch(:rows, 40)}'"
                   else "name='#{name}' type='text' value='#{value}'"
                   end
    end
    builder(key, **options)
  end

  def builder(key, **options)
    if options[:as] == :text
      @@input << label(key)
      @@input << "  <textarea "
      @@input << @field.fetch(key)
      @@input << ">"
      @@input << to_h.fetch(key)
      @@input << "</textarea>\n"
    else
      @@input << label(key)
      @@input << "  <input "
      @@input << @field.fetch(key)
      @@input << (options.map { |name, value| " #{name}='#{value}'" })
      @@input << ">\n"
    end
  end

  def submit(name = nil)
    @@input << "  <input type='submit'"
    @@input << (" name='#{name.nil? ? "Save" : name}'")
    @@input << ">\n"
  end

  def label(name, *label)
    label << "  <label for='#{name}'"
    label << ">"
    label << name.to_s.capitalize
    label << "</label>\n"
    label.join
  end
end
