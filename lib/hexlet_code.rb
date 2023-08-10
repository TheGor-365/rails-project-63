# frozen_string_literal: true

require_relative "hexlet_code/version"

require "active_support/all"

# generates HTML forms
module HexletCode
  autoload(:Tag, "./lib/hexlet_code/tag.rb")

  class << self
    def form_for(struct, url = {}, &block)
      @params = struct.to_h

      if url.key?(:url)
        puts "<form action='#{url.fetch(:url)}' method='post'>\n"
        print instance_eval(&block)
        puts "</form>"
      else
        puts "<form action='#' method='post'>\n"
        print instance_eval(&block)
        puts "</form>"
      end
    end

    def input(param_name, **field_options)
      @params.merge! field_options

      @input_attrs = @params.each_with_object({}) do |(name, value), hash|
        case field_options[:as]
        when :text
          hash[name] =
            "name='#{name}' cols='#{field_options.fetch(:cols, 20)}' rows='#{field_options.fetch(:rows, 40)}'"
        else
          hash[name] = "name='#{name}' type='text' value='#{value}'"
        end
      end
      field_constructor(param_name, **field_options)
      puts @field.join
    end

    def submit(*button_name)
      "  #{HexletCode::Tag.build("input", type: "submit", value: button_name.present? ? button_name.join : "Save")}\n"
    end

    def field_constructor(param_name, **field_options)
      public_send(param_name) unless @params[param_name]

      @field = []
      case field_options[:as]
      when :text
        @field << "  #{HexletCode::Tag.build("label", for: param_name) { param_name.to_s.capitalize }}\n"
        @field << "  <textarea "
        @field << @input_attrs.fetch(param_name)
        @field << ">"
        @field << @params.fetch(param_name)
        @field << "</textarea>"
      else
        @field << "  #{HexletCode::Tag.build("label", for: param_name) { param_name.to_s.capitalize }}\n"
        @field << "  <input "
        @field << @input_attrs.fetch(param_name)
        field_options.map { |option_name, value| @field << " #{option_name}='#{value}'" }
        @field << ">"
      end
    end
  end
end
