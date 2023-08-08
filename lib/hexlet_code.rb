# frozen_string_literal: true

require_relative "hexlet_code/version"

require 'active_support/all'

# generates HTML forms
module HexletCode
  autoload(:Tag, "./lib/hexlet_code/tag.rb")

  class << self
    def form_for struct, url={}, &block
      @params = struct.to_h
      form = []

      if url.key?(:url)
        puts "<form action='#{url.fetch(:url)}' method='post'>\n"
        print instance_eval(&block)
        print '</form>'
      else
        puts "<form action='#' method='post'>\n"
        print instance_eval(&block)
        print '</form>'
      end
      puts form.join
    end

    def input param_name, **field_options
      @params.merge! field_options

      @field_attributes = @params.each_with_object({}) do |(name, value), hash|
        case field_options[:as]
        when :text then hash[name] = "name='#{name}' cols='#{field_options.fetch(:cols, 20)}' rows='#{field_options.fetch(:rows, 40)}'"
        else
          hash[name] = "name='#{name}' type='text' value='#{value}'"
        end
      end
      field_constructor param_name, **field_options

      puts @field.join
    end

    def field_constructor param_name, **field_options
      public_send(param_name, self.struct) if !@params[param_name]

      @field = []

      case field_options[:as]
      when :text
        @field << '  <textarea '
        @field << @field_attributes.fetch(param_name)
        @field << '>'
        @field << @params.fetch(param_name)
        @field << '</textarea>'
      else
        @field << '  <input '
        @field << @field_attributes.fetch(param_name)
        field_options.map { |option_name, value| @field << " #{option_name}='#{value}'" }
        @field << '>'
      end
    end
  end
end


# User = Struct.new(:name, :job, :gender, keyword_init: true)
# user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
#
#
#
# HexletCode.form_for user do |f|
#   f.input :name
#   f.input :job, as: :text
# end
#
# # <form action="#" method="post">
# #   <input name="name" type="text" value="rob">
# #   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# # </form>
#
# puts
# puts
#
#
#
# HexletCode.form_for user, url: '#' do |f|
#   f.input :name, class: 'user-input'
#   f.input :job
# end
#
# # <form action="#" method="post">
# #   <input name="name" type="text" value="rob" class="user-input">
# #   <input name="job" type="text" value="hexlet">
# # </form>
#
# puts
# puts
#
#
#
# HexletCode.form_for user, url: '/users' do |f|
#   f.input :job, as: :text, rows: 50, cols: 50
# end
#
# # <form action="#" method="post">
# #   <textarea cols="50" rows="50" name="job">hexlet</textarea>
# # </form>
#
# puts
# puts
#
#
#
# HexletCode.form_for user, url: '/users/path' do |f|
#   f.input :name
#   f.input :job, as: :text
#
#   # f.input :age
# end
#
# # =>  `public_send': undefined method `age' for #<struct User id=nil, name=nil, job=nil> (NoMethodError)
#
# puts
# puts
#
#
#
# HexletCode.form_for user do |f|
# end
#
# # <form action='#' method='post'>
# # </form>
#
# puts
# puts
#
#
#
# HexletCode.form_for user, url: "/users" do |f|
# end
#
# # <form action='/users' method='post'>
# # </form>
#
# puts
# puts
