
```bash
k create ns serverless

kubectl apply -f argocd/app.yaml

kubectl delete -f argocd/app.yaml


argocd login localhost:8080 --insecure --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

# PASS
argocd app sync serverless --dry-run --revision 4ebc9415ae66ed9149c37cebe4c85b889953c2b6
echo $?

# FAIL
argocd app sync serverless --dry-run --revision 4ebc9415ae66ed9149c37cebe4c85b889953c2b6
echo $?

```