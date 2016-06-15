# Elastic Search Examples

## Get ElasticSearch running
On your Mac

```
brew install elasticsearch
```

You should be able to hit [http://localhost:9200](http://localhost:9200)

### Plugins 
These aren't mandatory but they'll make your life WAY easier

#### Head 
Site https://github.com/mobz/elasticsearch-head

```
/usr/local/Cellar/elasticsearch/2.3.1/libexec/bin/plugin install mobz/elasticsearch-head
http://localhost:9200/_plugin/head/
```

## Setup
```
git clone https://github.com/wiseleyb/elastic_search_examples
cd elastic_search_examples
rbenv local 2.2.3
bundle
be rake db:migrate
be rake db:seed
```


## STI Example
This is kind of a pain to get working. See Animal/Dog/Cat/Owner code for how this works.

Create the index ```AnimalSearch.create_index! force: true```
Then check it out in ES [http://localhost:9200](http://localhost:9200)

