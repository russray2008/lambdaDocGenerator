#!/bin/bash
set -eo pipefail
FUNCTION=$(aws --region us-east-1 --profile russ_dev cloudformation describe-stack-resource --stack-name lambdaDocGenerator --logical-resource-id SQSQueueFunction --query 'StackResourceDetail.PhysicalResourceId' --output text)
if [[ $(aws --version) =~ "aws-cli/2." ]]; then PAYLOAD_PROTOCOL="fileb"; else  PAYLOAD_PROTOCOL="file"; fi;
while true; do
  aws --region us-east-1 --profile russ_dev  lambda invoke --function-name $FUNCTION --payload $PAYLOAD_PROTOCOL://event.json out.json
  cat out.json
  echo ""
  sleep 2
done