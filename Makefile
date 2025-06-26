cluster:
	kind create cluster --name k8s-labs \
	 --image kindest/node:v1.29.2  \
	 --config ./kind/cluster-conf.yaml

cluster-multi:
	kind create cluster --name k8s-labs \
	--image kindest/node:v1.29.2 \
	--config ./kind/cluster-conf-multi.yaml

ingress:
	kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml

destroy-cluster:
	kind delete cluster --name k8s-labs

deploy-jenkins:
	helm repo add jenkins https://charts.jenkins.io
	helm repo update
	helm upgrade --install jenkins jenkins/jenkins \
	--namespace jenkins \
	--create-namespace \
	-f ./jenkins/jenkins-value.yaml

jenkins-ingress:
	kubectl apply -f ./jenkins/jenkins-ingress.yaml

port-forward-jenkins:
	kubectl port-forward svc/jenkins 8088:8080 -n jenkins

jenkins-delete:
	helm delete jenkins -n jenkins
	kubectl delete -f jenkins/jenkins-ingress.yaml

deploy-argo-cd:
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

argo-cd-ingress:
	kubectl apply -f ./argo-cd/argo-cd-ingress.yaml

argo-cd-delete:
	kubectl delete -f ./argo-cd/argo-cd-ingress.yaml
	kubectl delete namespace argocd

port-forward-argo-cd:
	kubectl port-forward svc/argocd-server 8089:80 -n argocd

argo-init-password:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

httpbin-deploy:
	kubectl create namespace httpbin
	kubectl apply -f ./httpbin/httpbin-deployment.yaml -n httpbin
	kubectl apply -f ./httpbin/httpbin-ingress.yaml -n httpbin

httpbin-delete:
	kubectl delete -f ./httpbin/httpbin-ingress.yaml -n httpbin
	kubectl delete -f ./httpbin/httpbin-deployment.yaml -n httpbin
	kubectl delete namespace httpbin
