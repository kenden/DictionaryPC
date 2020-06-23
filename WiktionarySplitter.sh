#!/usr/bin/env bash

set -e
set -x

this_dir=$(dirname "${0}")
cd "$this_dir" # allows the script to be executed from anywhere

ICU4J=/usr/share/java/icu4j-60.2.jar
test -r "$ICU4J" || ICU4J=/usr/share/icu4j-55/lib/icu4j.jar
COMMONS_COMPRESS=/usr/share/java/commons-compress.jar
JAVA=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
test -x ${JAVA} || JAVA=java

if [ ! -r "${ICU4J}" ] ; then
    echo "ICU4J needs to be installed"
    exit 1;
fi
if [ ! -r "${COMMONS_COMPRESS}" ] ; then
    echo "commons-compress needs to be installed"
    exit 1;
fi

${JAVA} -Xmx4096m -Xverify:none \
      -classpath bin/:"${ICU4J}":"${COMMONS_COMPRESS}" \
      com.hughes.android.dictionary.engine.Runner \
      WiktionarySplitter
