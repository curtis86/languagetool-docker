[![BuildBadge](https://github.com/curtis86/languagetool-docker/actions/workflows/main.yml/badge.svg)](https://github.com/curtis86/languagetool-docker/actions/workflows/main.yml/badge.svg)

# languagetool-docker

A simple Docker image for running your own [LanguageTool](https://languagetool.org/) server.

### Option A - Use DockerHub image based off this repo

```
docker run --rm -p 8081 curtiskneisel/languagetool-server:latest
```

### Option B - Build your own docker image

1. Clone this repo and change into the directory

```
git clone https://github.com/curtis86/languagetool-docker/
cd languagetool-docker
```

2. Build image, named `languagetool-server`

```
docker build -t languagetool-server .
```

3. Run the container on port 8081

```
docker run --rm -p 8081:8081 languagetool-server
```

### Run with docker-compose

1. Start the languagetool-server service. Modify the `docker-compose.yaml` file to suit your environment (ie. change port number, etc).

```
docker-compose up -d
```

#### Test Query

You can test your instance of LanguageTool server once it's running with the following command (note - using `jq` to print JSON nicely):

```
curl -d "language=en-US" -d "text=A simple tset" http://localhost:8081/v2/check | jq .

{
  "software": {
    "name": "LanguageTool",
    "version": "5.8",
    "buildDate": "2022-07-02 14:50:13 +0000",
    "apiVersion": 1,
    "premium": false,
    "premiumHint": "You might be missing errors only the Premium version can find. Contact us at support<at>languagetoolplus.com.",
    "status": ""
  },
  "warnings": {
    "incompleteResults": false
  },
  "language": {
    "name": "English (US)",
    "code": "en-US",
    "detectedLanguage": {
      "name": "English (US)",
      "code": "en-US",
      "confidence": 0.549649,
      "source": ""
    }
  },
  "matches": [
    {
      "message": "Possible spelling mistake found.",
      "shortMessage": "Spelling mistake",
      "replacements": [
        {
          "value": "set"
        },
        {
          "value": "test"
        },
        {
          "value": "stet"
        },
        {
          "value": "SET"
        },
        {
          "value": "Set"
        },
        {
          "value": "TSE"
        },
        {
          "value": "Tet"
        },
        {
          "value": "CSET"
        },
        {
          "value": "ESET"
        }
      ],
      "offset": 9,
      "length": 4,
      "context": {
        "text": "A simple tset",
        "offset": 9,
        "length": 4
      },
      "sentence": "A simple tset",
      "type": {
        "typeName": "Other"
      },
      "rule": {
        "id": "MORFOLOGIK_RULE_EN_US",
        "description": "Possible spelling mistake",
        "issueType": "misspelling",
        "category": {
          "id": "TYPOS",
          "name": "Possible Typo"
        }
      },
      "ignoreForIncompleteSentence": false,
      "contextForSureMatch": 0
    }
  ],
  "sentenceRanges": [
    [
      0,
      13
    ]
  ]
}
```

