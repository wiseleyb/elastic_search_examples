class Owner < ActiveRecord::Base
  belongs_to :animal

  include Elasticsearch::Model

  index_name AnimalSearch::INDEX_NAME

  mapping _parent: { type: 'animal' } do
    indexes :id, index: :not_analyzed
    indexes :name
  end

  after_commit lambda { __elasticsearch__.index_document(parent: animal_id)  },
    on: :create
  after_commit lambda { __elasticsearch__.update_document(parent: animal_id) },
    on: :update
  after_commit lambda { __elasticsearch__.delete_document(parent: animal_id) },
    on: :destroy
end
