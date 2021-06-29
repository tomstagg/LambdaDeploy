#!/usr/bin/env bash

# install required aws runtime dependencies and zip
rm -rf dist
pip install --target ./dist/package -r requirements_deploy.txt
pushd dist/package
zip -9rq ../lambdaDeploy.zip .
popd

zip -urq ./dist/lambdaDeploy.zip **/*.py *.py -x "package/*" -x "env/*"
