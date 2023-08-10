# frozen_string_literal: true

module HexletCode
  # generates HTML tags for forms
  class Tag
    class << self
      def build(name, **attributes)
        attributes = attributes.map { |attr, value| " #{attr}='#{value}'" }
        result = []

        result << "<#{name}"
        result << attributes.join
        result << ">" unless unpaired?(name)
        result << yield if block_given?
        result << (unpaired?(name) ? ">" : "</#{name}>")
        puts result.join
      end

      def unpaired?(tag)
        unpaired = %w[br hr img input meta area base col embed link param source track command keygen menuitem wbr]
        unpaired.include?(tag) ? true : false
      end
    end
  end
end
