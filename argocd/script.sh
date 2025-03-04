APP_NAME="serverless"
COMMIT_HASH_PASS="4ebc9415ae66ed9149c37cebe4c85b889953c2b6"
COMMIT_HASH_FAIL="b58b8e58d7f097f10dc7d56a4147de84543fa7b7"

# Run ArgoCD sync with dry-run and capture YAML output
OUTPUT=$(argocd app sync "$APP_NAME" --revision "$COMMIT_HASH_FAIL" --dry-run --server-side -o yaml)

# Extract sync phase
SYNC_PHASE=$(echo "$OUTPUT" | yq e '.status.operationState.phase' -)

# Extract sync error message if any
ERROR_MESSAGE=$(echo "$OUTPUT" | yq e '.status.operationState.message' -)

# Check if sync failed
if [[ "$SYNC_PHASE" != "Succeeded" ]]; then
    echo "❌ ArgoCD dry-run sync failed for commit $COMMIT_HASH_FAIL"
    echo
    echo "Error Message: $ERROR_MESSAGE"
    echo
    # This will display full output for debugging
    argocd app sync $APP_NAME --revision $COMMIT_HASH_FAIL --dry-run --server-side
    exit 1
else
    echo "✅ ArgoCD dry-run sync succeeded for commit $COMMIT_HASH_FAIL"
fi