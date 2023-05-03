
# deploy traefik


```
helm upgrade --install traefik --namespace traefik --set dashboard.enabled=true --set rbac.enabled=true --set="additionalArguments={--api.dashboard=true,--log.level=INFO,--providers.kubernetesingress.ingressclass=traefik-internal,--serversTransport.insecureSkipVerify=true}" traefik/traefik --version 10.19.4

```
## before we procced further get your self sign certificate and get your ssl domain secret to point on ingress-route

```
helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install cert-manager jetstack/cert-manager \
    --create-namespace \
    --namespace cert-manager \
    --timeout 5m0s \
    --wait
```
create certificates
```
kubectl apply -f ./cert-manager
```

## create middleware for accessing dashboard
### before we create middleware for dashboard we need to create credentilas.
first of all run credentials.sh to create credentials then create kubernetes secret

```
chmod +x ./credentials.sh
./credentials.sh
```

### create secret for middleware.
```
kubectl create secret generic traefik-dashboard-auth-secret --from-file=./USER/temp/traefik-ui-creds/htpasswd --namespace traefik
```
## now you can apply middleware yaml file

```
kubectl apply -f middleware-traefik-dashboard.yaml
```
### now you create ingress route 

```
kubectl apply -f ingress-route.yaml

```
edit your /etc/hosts and point your taefik loadbalncer against your domain, for example local.opshive.io
you can navigate on your doamin and enter user and password. 

