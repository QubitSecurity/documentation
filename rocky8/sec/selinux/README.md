## 1. Solr




## 2. Solr

### 2.1 Add-field-type

```
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field-type": {
    "name": "keyword_analysis",
    "class": "solr.TextField",
    "positionIncrementGap": "100",
    "indexAnalyzer": {
      "tokenizer": {
        "class": "solr.KeywordTokenizerFactory"
      },
      "filters": [
        {
          "class": "solr.LowerCaseFilterFactory"
        },
        {
          "class": "solr.EdgeNGramFilterFactory",
          "maxGramSize": "32",
          "minGramSize": "2"
        }
      ]
    },
    "queryAnalyzer": {
      "tokenizer": {
        "class": "solr.KeywordTokenizerFactory"
      },
      "filters": [
        {
          "class": "solr.LowerCaseFilterFactory"
        }
      ]
    }
  }
}' http://localhost:8983/solr/syslog/schema
```
<hr/>
### 2.2 Replace-field

```
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "replace-field":{
     "name":"logMessage",
     "type":"keyword_analysis",
     "multiValued":false,
     "indexed":true,
     "required":false,
     "stored":true}
}' http://localhost:8983/solr/syslog/schema
```

<hr/>

```
a
```

<hr/>

```
b
```

<hr/>

```
c
```

<hr/>

```
d
```
