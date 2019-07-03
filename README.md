# DictionaryPC

This repository is used to generate new dictionaries for the QuickDic app.
The code of that app is at: https://github.com/rdoeffinger/Dictionary

# How to generate a new dictinory

## Requirements

In order to build a newer version of the dictionary, you should have a machine with at least 5GB of RAM memory

Docker should be installed on the machine, see https://docs.docker.com/install
docker-compose should be installed on the machine, see https://docs.docker.com/compose/install/

## Get the code

```bash
$ git clone git@github.com:rdoeffinger/Dictionary.git
$ git clone git@github.com:rdoeffinger/DictionaryPC.git
``

## Compile

```bash
$ cd DictionaryPC/
$ docker-compose up
```
