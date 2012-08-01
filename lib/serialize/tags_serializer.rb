class Serialize::TagSerializer
  def self.as_json(tag)
    return {} if tag.nil?

    if tag.errors.present?
      { :errors => tag.errors.full_messages }.as_json
    else
      {
        :code => tag.code,
        :name => tag.name.titleize,
        :url => "/tags/#{tag.id}"
      }.as_json
    end
  end
end

class Serialize::TagsSerializer
  def self.as_json(tags)
    if tags.nil? || tags.empty?
      {}
    else
      tags.map { |tag|
        Serialize::TagSerializer.as_json(tag)
      }
    end
  end
end
