#!/bin/bash

# Check KEY_PATH
if [ -z "$KEY_PATH" ]; then
  echo "KEY_PATH env var is expected"
  exit 5
fi

# Check bastion IP
if [ -z "$1" ]; then
  echo "Please provide bastion IP address"
  exit 5
fi

BASTION_IP="$1"
TARGET_IP="$2"
shift 2
REMOTE_CMD="$@"

# Case 1: Just bastion
if [ -z "$TARGET_IP" ]; then
  ssh -i "$KEY_PATH" ubuntu@"$BASTION_IP"
  exit 0
fi

# ✅ NEW: Define ProxyCommand manually to inject key
BASTION_PROXY_CMD="ssh -i $KEY_PATH -W %h:%p ubuntu@$BASTION_IP"

# Case 2: Bastion + target
echo "Connecting to $TARGET_IP through bastion $BASTION_IP..."

if [ -z "$REMOTE_CMD" ]; then
  ssh -o ProxyCommand="$BASTION_PROXY_CMD" -i "$KEY_PATH" ubuntu@"$TARGET_IP"
else
  ssh -o ProxyCommand="$BASTION_PROXY_CMD" -i "$KEY_PATH" ubuntu@"$TARGET_IP" "$REMOTE_CMD"
fi
