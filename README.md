# caddy-raspi

## Summary

Code for building a Kubernetes-deployable Docker image with the latest version of <a href="https://caddyserver.com/">Caddy</a> web server 
on top of the latest <a href="https://hub.docker.com/r/arm32v6/alpine/">ARM32v6/Alpine</a> release, for deployment
on a Raspberry Pi K8s based cluster. Caddy installed with the Git & Prometheus plugins to enable content pulls from a Git repo and a Prometheus
metrics endpoint, respectively. 

Also includes a Kubernetes service & deployments template .yml file. Requires a working Kubernetes cluster and that 
image build be deployed to an <a href="https://kubernetes.io/docs/concepts/containers/images/">appropriate container registry</a>, like Docker Hub. 

## Usage

Clone repo.

Customize contents of <a href="https://caddyserver.com/docs/caddyfile">Caddyfile</a> appropriately for your setup. 
At a minimum, 'hostname:port' and Git repository endpoint.

Customize values in caddy-app.yml Kubernetes template file. At a minimum, customize container 'image' field. Caddy 
requires this value match request URL exactly. See <a href="https://caddyserver.com/tutorial/caddyfile">https://caddyserver.com/tutorial/caddyfile</a>.

Build image:
`docker build -t *image/name* .`

Push image to registry, in this example, Docker Hub:

`docker push image/name`

Create Kubernetes Service and Deployment:

`kubectl create -f caddy-app.yml`

Deployment should now be active and accessible outside the cluster at the appropriate URL:Port for your configuration.

Some helpful topics & commands:

 - <a href="https://kubernetes.io/docs/concepts/services-networking/service/">Understanding Kubernetes Services / NodePort</a>
 - Show Kubernetes services: `kubectl get svc`
 - Show K8s Deployments: `kubectl get deployments`
 - Show K8s Pods with node placements: `kubectl get pods -o wide`
 - Remove service and deployment from K8s: `kubectl delete -f caddy-app.yml`

## To-Do

 - [ ] Enable <a href="https://caddyserver.com/docs/automatic-https">Automatic HTTPS</a>
 - [ ] Enable Caddy dymanic web content (<a href="https://caddyserver.com/docs/fastcgi">FastCGI?</a>)
 - [ ] Potentially change dumb load balancing away from NodePort, possibly Ingress or make use of Nginx.

## License

This is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).
