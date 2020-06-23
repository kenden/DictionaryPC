
# DictionaryPC

This repository is made to generate dictionaries for the QuickDic Android application, an offline dictionary.
 
## Description

To generate the dictionaries, the DictionaryPC and Dictionary code need to be obtained, then compiled.
It requires an environment to compile and run, a docker container.

## How to get the source code (on Linux)

~~~bash
# Create a dev directory when to clone the 2 repositories
$ mkdir QuickDic
$ cd QuickDic
# clone the code with the submodule
$ git clone --recursive git@github.com:rdoeffinger/Dictionary.git
$ git clone git@github.com:rdoeffinger/DictionaryPC.git
~~~

## How to create the build environment (a docker image)

The build environment is a docker container.  
The docker image needed to start the container needs to be created. 
For this, docker is needed.

### Install docker

Install docker following the instructions at: https://docs.docker.com/get-docker/

### Build the docker image

Use the following command to build the docker image.

~~~bash
# create the development environment
$ docker build --tag dictionary_build_env --file=Dictionary/docker/Dockerfile Dictionary/docker
Sending build context to Docker daemon  2.048kB
Step 1/2 : FROM ubuntu:20.04
 ---> 74435f89ab78
Step 2/2 : RUN apt-get update     && apt-get install -y          openjdk-14-jdk          libicu4j-java          junit          libxerces2-java          libcommons-lang3-java          libcommons-text-java          libcommons-compress-java
(... truncated log... )
Successfully built cb19ad0b1a95
Successfully tagged dictionary_build_env:latest
~~~

## How to get the dictionaries data

The dictionary data needs to be downloaded from various sources, e.g. wiktionary.com.  
At the beginning of the file, select the languages to get. Edit line:  
`for l in en fr it de es pt; do`
~~~bash
$ docker run -it --rm \
    --volume $(pwd):/workspace \
    dictionary_build_env \
    /workspace/DictionaryPC/data/downloadInputs.sh
~~~
## Compile the code to generate the dictionaries

The java code needs to be compiled in order to generate dictionaries.  
Use the following to build inside the docker container.

This is optional, as a binary was pre-compiled, and made available here:  
https://github.com/rdoeffinger/DictionaryPC/releases  
The file is `DictionaryPC.zip`.  

~~~bash
# build inside the development environment
$ docker run -it --rm \
    --volume $(pwd):/workspace \
    dictionary_build_env \
    /workspace/DictionaryPC/compile.sh
~~~

## Split the data of the downloaded dictionaries

~~~bash
# build inside the development environment
$ docker run -it --rm \
    --volume $(pwd):/workspace \
    dictionary_build_env \
    /workspace/DictionaryPC/WiktionarySplitter.sh
~~~

## Generate the dictionaries

This steps depends on the previous steps.

First, edit the list of dictionaries to generate, at the beginning of file  `DictionaryPC/generate_dictionaries.sh`.  
Also edit the input files, e.g. `EN-trans-dictlist.txt`, to add new dictionaries.

~~~bash
# build inside the development environment
$ docker run -it --rm \
    --volume $(pwd):/workspace \
    dictionary_build_env \
    /workspace/DictionaryPC/generate_dictionaries.sh
~~~

For a more manual approach, the commands it runs are something like
~~~bash
./run.sh --lang1=ES --lang2=PT --lang1Stoplist=data/inputs/stoplists/es.txt \
--dictOut=data/outputs/ES-PT.quickdic \
--dictInfo="(EN)Wiktionary-based ES-PT dictionary." --input1=data/inputs/wikiSplit/en/EN.data \
--input1Name=enwikitionary --input1Format=EnTranslationToTranslation \
--input1LangPattern1=es --input1LangPattern2=pt
~~~
