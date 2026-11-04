#!/bin/bash

STORAGE_ACCOUNT="kotnalaa"
CONTAINER_NAME="batr"

echo "Listing soft-deleted blobs..."

DELETED_BLOBS=$(az storage blob list \
    --account-name "$STORAGE_ACCOUNT" \
    --container-name "$CONTAINER_NAME" \
    --include d \
    --auth-mode login \
    --num-results '*' \
    --query "[?deleted == \`true\`].name" \
    -o tsv)

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to list deleted blobs."
    exit 1
fi

if [ -z "$DELETED_BLOBS" ]; then
    echo "No deleted blobs found."
    exit 0
fi

SUCCESS=0
FAILED=0

while IFS= read -r blob; do

    [ -z "$blob" ] && continue

    # Preserve the original leading slash and prepend another slash
    if [[ "$blob" == /* ]]; then
        RESTORE_NAME="/$blob"
    else
        RESTORE_NAME="$blob"
    fi

    echo "Original blob name : '$blob'"
    echo "Undelete name      : '$RESTORE_NAME'"

    if az storage blob undelete \
        --account-name "$STORAGE_ACCOUNT" \
        --container-name "$CONTAINER_NAME" \
        --name "$RESTORE_NAME" \
        --auth-mode login; then

        echo "SUCCESS: $blob"
        ((SUCCESS++))
    else
        echo "FAILED: $blob"
        ((FAILED++))
    fi

done <<< "$DELETED_BLOBS"

echo "--------------------------------"
echo "Recovery completed."
echo "Successful: $SUCCESS"
echo "Failed: $FAILED"