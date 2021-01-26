#!/bin/bash -e
SCRIPT_DIR=$(dirname $0)

# Build Java 8 image
pushd ${SCRIPT_DIR}/images/java8
cekit build docker
popd

# Test Java 8 image if TEST_MODE is set
if [[ ! -z "${TEST_MODE:-}" ]]; then
  echo Testing version ${JAVA8_IMAGE_VERSION}
  IMAGE_VERSION=${JAVA8_IMAGE_VERSION}; . ${SCRIPT_DIR}/test/run
fi

# Build Java 11 image
pushd ${SCRIPT_DIR}/images/java11
cekit build docker
popd

# Test Java 11 image if TEST_MODE is set
if [[ ! -z "${TEST_MODE:-}" ]]; then
  echo Testing version ${JAVA11_IMAGE_VERSION}
  IMAGE_VERSION=${JAVA11_IMAGE_VERSION}; . ${SCRIPT_DIR}/test/run
fi