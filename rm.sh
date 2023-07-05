#!/bin/bash
set -o nounset -o errexit -o pipefail

# This is a script that removes ALL ingress and egress rules from security groups for the default VPCs. Check that `jq` is installed:

if ! (which jq >/dev/null 2>&1); then
    echo "jq must be installed" 1>&2
    exit 1
fi

# Get the list of available regions
AWS_REGIONS=$(aws ec2 describe-regions --query 'Regions[].RegionName' --output json | jq -r '.[]')

# Loop over each region
for region in $AWS_REGIONS; do
  echo "Processing region: $region"

  # Get the description for the default security groups in the region. Store it in the `DESCRIPTION` variable so we don't need to re-fetch this.
  DESCRIPTION=$(aws ec2 describe-security-groups \
    --filters Name=group-name,Values=default \
    --region "$region" \
    --query 'SecurityGroups[*]' --output json)

  # Run through all security groups.
  for group_id in $(echo "$DESCRIPTION" | jq -r '.[] | .GroupId'); do
    echo "Removing rules from security group $group_id..."

    # Get the description for this group specifically.
    GROUP_DESCRIPTION=$(echo "$DESCRIPTION" | \
      jq "map(select(.GroupId == \"$group_id\")) | .[0]")

    # Run through ingress permissions.
    {
      IFS=$'\n'  # Make sure we only split on newlines.
      for ingress_rule in $(echo "$GROUP_DESCRIPTION" | \
          jq -c '.IpPermissions | .[]'); do
        echo "Removing ingress rule: $ingress_rule"
        aws ec2 revoke-security-group-ingress \
          --group-id "$group_id" \
          --ip-permissions "$ingress_rule" \
          --region "$region"
      done
      unset IFS
    }

    # Run through egress permissions.
    {
      IFS=$'\n'  # Make sure we only split on newlines.
      for egress_rule in $(echo "$GROUP_DESCRIPTION" | \
          jq -c '.IpPermissionsEgress | .[]'); do
        echo "Removing egress rule: $egress_rule"
        aws ec2 revoke-security-group-egress \
          --group-id "$group_id" \
          --ip-permissions "$egress_rule" \
          --region "$region"
      done
      unset IFS
    }
  done
done
