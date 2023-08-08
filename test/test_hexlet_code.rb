# frozen_string_literal: true

require_relative "test_helper"

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)
  user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

  def test_tag_without_attributes_build
    paired_tag = "<form></form>"
    unpaired_tag = "<area>"

    assert { HexletCode::Tag.build("form") == paired_tag }
    assert { HexletCode::Tag.build("area") == unpaired_tag }
  end


  def test_tag_with_attributes_build
    paired_tag = "<form action='action_page/:id' method='get'></form>"
    unpaired_tag = "<area src='workplace.jpg' alt='Workplace'>"

    assert { HexletCode::Tag.build("form", action: "action_page/:id", method: "get") == paired_tag }
    assert { HexletCode::Tag.build("area", src: "workplace.jpg", alt: "Workplace") == unpaired_tag }
  end


  def test_tag_with_blocks_build
    paired_tag = "<label>Email</label>"

    assert { HexletCode::Tag.build("label") { "Email" } == paired_tag }
  end


  def test_tag_with_blocks_and_attributes_build
    paired_tag = "<label for='email'>Email</label>"

    assert { HexletCode::Tag.build("label", for: "email") { "Email" } == paired_tag }
  end


  def test_empty_form_build
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

    form = '<form action="#" method="post">\n</form>'
    html = HexletCode.form_for user do |f|; end

    assert { html == (puts form) }
  end
  #
  #
  # def test_form_with_url_build
  #   user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
  #   html = HexletCode.form_for user, url: "/users" do |f|; end
  #
  #   form = "<form action='/users' method='post'>\n</form>"
  #
  #   assert { html == form }
  # end
  #
  #
  # def test_input_name_and_job
  #   user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
  #   html = HexletCode.form_for user do |f|
  #     f.input :name
  #     f.input :job, as: :text
  #   end
  #
  #   form = '<form action="#" method="post">
  #             <input name="name" type="text" value="rob">
  #             <textarea name="job" cols="20" rows="40">hexlet</textarea>
  #           </form>'
  #
  #   assert { html == form }
  # end
  #
  #
  # def test_input_attributes
  #   user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
  #   html = HexletCode.form_for user, url: '#' do |f|
  #     f.input :name, class: 'user-input'
  #     f.input :job
  #   end
  #
  #   form = '<form action="#" method="post">
  #             <input name="name" type="text" value="rob" class="user-input">
  #             <input name="job" type="text" value="">
  #           </form>'
  #
  #   assert { html == form }
  # end
  #
  #
  # def test_default_values_for_tags
  #   user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
  #   html = HexletCode.form_for user, url: '#' do |f|
  #     f.input :job, as: :text, rows: 50, cols: 50
  #   end
  #
  #   form = '<form action="#" method="post">
  #             <textarea cols="50" rows="50" name="job">hexlet</textarea>
  #           </form>'
  #
  #   assert { html == form }
  # end
end
