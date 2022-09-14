# frozen_string_literal: true

require_relative "hexlet_code/version"
# generates HTML forms
module HexletCode
  autoload(:Tag, "./lib/hexlet_code/tag.rb")

  class << self
    def form_for(_action, job = {})
      return "<form action='#' method='post'></form>" if job.size.zero?

      job.each_pair do |_name, value|
        return "<form action='#{value}' method='post'></form>" if job.key?(:url)
      end
    end
  end
end
