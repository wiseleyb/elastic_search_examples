class Question < ActiveRecord::Base
  include Elasticsearch::Model

  has_many :answers, dependent: :destroy

  index_name QA::INDEX_NAME

  mapping do
    indexes :title
    indexes :text
    indexes :author
  end

  after_commit lambda { __elasticsearch__.index_document  },  on: :create
  after_commit lambda { __elasticsearch__.update_document },  on: :update
  after_commit lambda { __elasticsearch__.delete_document },  on: :destroy
end
