# frozen_string_literal: true

module HexletCode
  # generates HTML tags for forms
  class Tag
    def self.build(name, *tag, **attributes)
      attributes = attributes.map { |attr, value| " #{attr}='#{value}'" }

      tag << "<#{name}"
      tag << attributes.join
      tag << '>' unless unpaired?(name)
      tag << yield if block_given?
      tag << (unpaired?(name) ? '>' : "</#{name}>")
      tag.join
    end

    def self.unpaired?(tag)
      unpaired = %w[br hr img input meta area base col embed link param source track command keygen menuitem wbr]
      unpaired.include?(tag) ? true : false
    end
  end
end
