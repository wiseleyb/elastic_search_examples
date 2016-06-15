module AnimalSearch
  INDEX_NAME = 'animals_owners'

  def create_index!(options={})
    client = Animal.__elasticsearch__.client
    client.indices.delete index: INDEX_NAME rescue nil if options[:force]

    settings = Animal.settings.to_hash.merge Owner.settings.to_hash
    mappings = Animal.mappings.to_hash.merge Owner.mappings.to_hash

    client.indices.create index: INDEX_NAME,
                          body: {
                            settings: settings.to_hash,
                            mappings: mappings.to_hash }

    Animal.__elasticsearch__.refresh_index!
    Animal.import

    transform = lambda do |a|
      {
        index: {
          _id: a.id,
          _parent: a.animal_id,
          data: a.__elasticsearch__.as_indexed_json
        }
      }
    end
    Owner.import do |response|
      puts response.to_yaml
    end
  end

  extend self
end
