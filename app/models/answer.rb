class Answer < ActiveRecord::Base
  include Elasticsearch::Model

  belongs_to :question

  index_name QA::INDEX_NAME

  mapping _parent: { type: 'question' } do
    indexes :text
    indexes :author
  end

  after_commit lambda { __elasticsearch__.index_document(parent: question_id)  },
    on: :create
  after_commit lambda { __elasticsearch__.update_document(parent: question_id) },
    on: :update
  after_commit lambda { __elasticsearch__.delete_document(parent: question_id) },
    on: :destroy
end
