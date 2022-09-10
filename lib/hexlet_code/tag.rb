class HexletCode::Tag
  UNPAIRED_TAGS_PATH = "lib/hexlet_code/tags.txt"

  def self.build tag_name, attributes = {}, &block
    tag = is_unpaired?(tag_name) ? "<#{tag_name}>" : "<#{tag_name}></#{tag_name}>"
    attr_pairs = attributes.any? ? [''] : []
    block = is_unpaired?(tag_name) ? (" #{block.call}" if block) : ("#{block.call}" if block)

    if is_unpaired?(tag_name)
      attributes.each { |name, value| attr_pairs << " #{name}='#{value}'" }
      "<#{tag_name}#{attr_pairs.join()}#{block}>"
    elsif !is_unpaired?(tag_name)
      attributes.each { |name, value| attr_pairs << " #{name}='#{value}'" }
      "<#{tag_name}#{attr_pairs.join()}>#{block}</#{tag_name}>"
    else
      tag
    end
  end

  def self.is_unpaired? tag
    unpaired_tags_data = File.open(UNPAIRED_TAGS_PATH, 'r')
    unpaired_tags = unpaired_tags_data.readlines(chomp: true)
    unpaired_tags_data.close
    unpaired_tags.include?(tag) ? true : false
  end
end
