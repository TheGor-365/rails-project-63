# frozen_string_literal: true

require_relative "hexlet_code/version"
require 'active_support/all'
# generates HTML forms
module HexletCode
  autoload(:Tag, "./lib/hexlet_code/tag.rb")

  class << self
    def form_for(struct, url = {})
      return "<form action='#' method='post'>\n\t#{input(struct)}\n</form>" if url.size.zero?

      url.each_pair do |_name, value|
        return "<form action='#{value}' method='post'>\n\t#{input(struct)}\n</form>" if url.key?(:url)
      end
    end

    def input(struct)
      struct.each_pair do |name, value|
        return "<input name='#{name if struct[name]}' type='text' value='#{value if value.present?}'>"
      end
    end
  end
end


User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

html = HexletCode.form_for user do |f|
  # Проверяет есть ли значение внутри name
  # f.input :name
  # # Проверяет есть ли значение внутри job
  # f.input :job
end
puts html
puts

pp user.to_h
pp user.members
pp user.values
puts

# <form action="#" method="post">
#   <input name="name" type="text" value="rob">
#   <textarea name="job" cols="20" rows="40">hexlet</textarea>
# </form>



html_2 = HexletCode.form_for user, url: '#' do |f|
  # f.input :name, class: 'user-input'
  # f.input :job
  # f.submit
end

# <form action="#" method="post">
#   <input name="name" type="text" value="rob" class="user-input">
#   <input name="job" type="text" value="">
# </form>
puts html_2
puts

html_3 = HexletCode.form_for user, url: '/users' do |f|
  # f.input :job, as: :text, rows: 50, cols: 50
end

# <form action="/users" method="post">
#   <textarea cols="50" rows="50" name="job">hexlet</textarea>
# </form>
puts html_3
puts

html_4 = HexletCode.form_for user, url: '/users' do |f|
  # f.input :name
  # f.input :job, as: :text
  # # Поля age у пользователя нет
  # f.input :age
end
# =>  `public_send': undefined method `age' for #<struct User id=nil, name=nil, job=nil> (NoMethodError)
puts html_4
puts
