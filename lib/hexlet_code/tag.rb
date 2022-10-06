# frozen_string_literal: true

module HexletCode
  # generates HTML tags for forms
  class Tag
    def self.build(name, **attributes)
      attr_pairs = []
      attributes.each { |attr, value| attr_pairs << " #{attr}='#{value}'" }

      result = []
      result << "<#{name}"
      result << "#{attr_pairs.join}" if attributes.any?
      result << ">" if !unpaired?(name)
      result << "#{yield}" if block_given?
      unpaired?(name) ? result << ">" : result << "</#{name}>"
      result.join
    end

    def self.unpaired?(tag)
      unpaired = %w[ br hr img input meta area base col embed link param source track command keygen menuitem wbr ]
      unpaired.include?(tag) ? true : false
    end
  end
end


pp HexletCode::Tag.build('br')

pp HexletCode::Tag.build('img', src: 'path/to/image')

pp HexletCode::Tag.build('input', type: 'submit', value: 'Save')

pp HexletCode::Tag.build('label') { 'Email' }

pp HexletCode::Tag.build('label', for: 'email') { 'Email' }

pp HexletCode::Tag.build('div')
