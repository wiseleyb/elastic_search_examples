# ParentChild example from elastic-model specs
module QA
  INDEX_NAME = 'questions_and_answers'

  def create_index!(options={})
    client = Question.__elasticsearch__.client
    client.indices.delete index: INDEX_NAME rescue nil if options[:force]

    settings = Question.settings.to_hash.merge Answer.settings.to_hash
    mappings = Question.mappings.to_hash.merge Answer.mappings.to_hash

    client.indices.create index: INDEX_NAME,
                          body: {
                            settings: settings.to_hash,
                            mappings: mappings.to_hash }

  end

  def test
    Rails.logger.level = 3
    QA.create_index! force: true

    Question.__elasticsearch__.refresh_index!
    #Question.import
    #Answer.import

    response = Question.__elasticsearch__.search(
                       { query: {
                            has_child: {
                              type: 'answer',
                              query: {
                                match: {
                                  author: Answer.shuffle.first.author
                                }
                              }
                            }
                         }
                       })
    puts response.records.first.title

    response = Answer.__elasticsearch__.search(
                         { query: {
                              has_parent: {
                                parent_type: 'question',
                                query: {
                                  match: {
                                    author: Question.shuffle.first.author
                                  }
                                }
                              }
                           }
                         })
    puts response.records.map(&:author).to_yaml

    # Question.where(title: 'First Question').each(&:destroy)
    # Question.__elasticsearch__.refresh_index!

    # response = Answer.__elasticsearch__.search query: { match_all: {} }

    # puts response.results.total
  end

  extend self
end
