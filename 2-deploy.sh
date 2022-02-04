#!/bin/bash
set -eo pipefail
ARTIFACT_BUCKET=$(cat bucket-name.txt)
cd src/lambdaDocGenerator
dotnet lambda package
cd ../../
aws --region us-east-1 --profile russ_dev cloudformation package --template-file template.yml --s3-bucket $ARTIFACT_BUCKET --output-template-file out.yml
aws --region us-east-1 --profile russ_dev cloudformation deploy --template-file out.yml --stack-name lambdaDocGenerator --capabilities CAPABILITY_NAMED_IAM