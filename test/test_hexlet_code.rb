# frozen_string_literal: true

require_relative "test_helper"

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, keyword_init: true)

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
    form = "<form action='#' method='post'></form>"
    user = User.new

    assert { HexletCode.form_for user == form }
  end

  def test_form_with_url_build
    form = "<form action='/users' method='post'></form>"
    user = User.new

    assert { HexletCode.form_for user, url: form == "/users" }
  end
end
