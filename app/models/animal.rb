class Animal < ActiveRecord::Base
  has_many :owners

  include Elasticsearch::Model

  index_name AnimalSearch::INDEX_NAME
  document_type 'animal'

  mapping do
    indexes :name
    indexes :type
  end

  def self.inherited(subclass)
    subclass.instance_eval do
      index_name AnimalSearch::INDEX_NAME
      document_type 'animal'
    end

    super
  end

  after_commit lambda { __elasticsearch__.index_document  },  on: :create
  after_commit lambda { __elasticsearch__.update_document },  on: :update
  after_commit lambda { __elasticsearch__.delete_document },  on: :destroy
end
