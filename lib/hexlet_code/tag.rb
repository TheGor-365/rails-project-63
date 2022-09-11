# frozen_string_literal: true

module HexletCode
  # generates HTML tags for forms
  class Tag
    UNPAIRED_TAGS_PATH = "lib/hexlet_code/tags.txt"

    def self.build(name, attributes = {}, &block)
      attr_pairs = attributes.any? ? [""] : []
      block = unpaired?(name) ? (" #{block.call}" if block) : (block.call.to_s if block)
      attributes.each { |attr, value| attr_pairs << " #{attr}='#{value}'" }
      unpaired?(name) ? "<#{name}#{attr_pairs.join}#{block}>" : "<#{name}#{attr_pairs.join}>#{block}</#{name}>"
    end

    def self.unpaired?(tag)
      unpaired_data = File.open(UNPAIRED_TAGS_PATH, "r")
      unpaired = unpaired_data.readlines(chomp: true)
      unpaired_data.close
      unpaired.include?(tag) ? true : false
    end
  end
end
