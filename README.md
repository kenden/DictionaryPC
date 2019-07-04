# DictionaryPC

This repository is used to generate new dictionaries for the QuickDic app.
The code of that app is at: https://github.com/rdoeffinger/Dictionary

# How to generate new dictinaries

## Requirements

In order to build a newer version of the dictionary, you should have a machine with at least 5GB of RAM memory

Docker should be installed on the machine, see https://docs.docker.com/install
docker-compose should be installed on the machine, see https://docs.docker.com/compose/install/

## Get the code

```bash
$ git clone --recursive git@github.com:rdoeffinger/Dictionary.git
$ git clone git@github.com:rdoeffinger/DictionaryPC.git
```

## Download data from wikipedia/wiktionary/etc.

```bash
$ cd DictionaryPC/
$ docker-compose up download_inputs
```

## Compile

```bash
$ cd DictionaryPC/
$ docker-compose up compile
```

## Split the Wiktionary data

Generate per-language data files from wikipedia data files.

```bash
$ cd DictionaryPC/
$ docker-compose up wiktionary_splitter
```

## Generate dictionaries

Edit the settings at the start of file `DictionaryPC/generate_dictionaries.sh` so it does not generate all dictionaries.  

Edit input files:  
```
DictionaryPC/DE-foreign-dictlist.txt
DictionaryPC/EN-foreign-dictlist.txt
DictionaryPC/FR-foreign-dictlist.txt
DictionaryPC/IT-foreign-dictlist.txt
DictionaryPC/EN-trans-dictlist.txt
```
to choose which ditionaries to create.

```bash
$ cd DictionaryPC/
$ docker-compose up generate_dictionaries
```
