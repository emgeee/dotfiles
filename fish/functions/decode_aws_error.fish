

# Decode aws error messages
# https://aws.amazon.com/premiumsupport/knowledge-center/aws-backup-encoded-authorization-failure/
function decode_aws_error
  aws sts decode-authorization-message --encoded-message $argv[1] --query DecodedMessage --output text | jq '.'
end
