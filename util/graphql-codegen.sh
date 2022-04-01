##########################################################################################
# Functions
##########################################################################################

# Evals a function and exits the script if any error occured
function run() {
  cmd_output=$(eval $1)
  return_value=$?
  if [ $return_value != 0 ]; then
    echo "Command $1 failed"
    exit -1
  fi
  return $return_value
}

function usage() {
  echo "Usage $0 -a <API_ID> [-r <REGION>]"
}

##########################################################################################
# Parse command-line options
##########################################################################################

# while getopts 'a:f:' c
# do
#   case $c in
#     a) API_ID=$OPTARG ;;
#   esac
# done
while getopts ':a:r:' OPTION; do
  case $OPTION in
    a) API_ID=$OPTARG ;;
    r) REGION=$OPTARG ;;
    ?) usage; exit 1;;
  esac
done

if [ -z $API_ID ]
then
    usage
    exit 2
fi

if [ -z "$REGION" ]; then
  REGION='us-east-1'
  echo "Using default region $REGION"
fi

##########################################################################################

export AWS_DEFAULT_REGION=$REGION

## Fetch Introspection

run "mkdir -p schema"
echo "Downloading latest client GraphQL schema for API ID: $API_ID"
run "aws appsync get-introspection-schema --api-id $API_ID --format JSON graphql/schema/schema.json"
echo "GraphQL schema has been successfully downloaded."

## Generate Code

SCHEMA_FILE="graphql/schema/schema.json"
API_FILE="SudoIdentityVerification/Source/Internal/Utility/SudoIdentityVerificationServiceAPI.swift"
DISABLE_SWIFT_LINT_RULE="// swiftlint:disable all"

run "aws-appsync-codegen generate graphql/*.graphql --schema $SCHEMA_FILE --output $API_FILE"

# Add SwiftLint Disable rule to generated code
sed -i.bak '1s;^;'"$DISABLE_SWIFT_LINT_RULE"'\
;' $API_FILE
# Demote all public references to internal
run "sed -i.bak 's/[[:<:]]public[[:>:]]/internal/g' $API_FILE"

sed -i.bak '1,/internal struct/s/internal struct/internal struct GraphQL {\
internal struct/' $API_FILE

sed -i.bak '$s;$;\
} // Closing Brace for GraphQL;' $API_FILE

rm $API_FILE.bak

echo "Code generated!"
