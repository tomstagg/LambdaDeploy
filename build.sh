#!/usr/bin/env bash

# install required aws runtime dependencies and zip
rm -rf dist
pip install --target ./dist/package -r requirements_deploy.txt
pushd dist/package
zip -9rq ../lambda.zip .
popd

zip -urq ./dist/lambda.zip **/*.py *.py -x "package/*" -x "env/*"
