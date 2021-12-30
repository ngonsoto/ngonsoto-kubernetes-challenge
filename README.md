# [DigitalOcean Kubernetes Challenge](https://www.digitalocean.com/community/pages/kubernetes-challenge)
Challenge selected: Deploy a log monitoring system.

## Requisites
- [Terraform](https://www.terraform.io/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/)
- [Doctl](https://docs.digitalocean.com/reference/doctl/)

## Using this repo
### Configure doctl

The official documentation details the steps [here](https://docs.digitalocean.com/reference/doctl/how-to/install/). The short version is detailed below:
- Login to your account/project.
- Click on API on left menu.
- Click on generate a new token.
- Give a name to the token.
- Copy the new generated token.
- Execute `doctl auth init` con your local console.
- Enter the token.

### Deploying the stack
This project uses Terraform to manage the infrastructure as code and Helm to easily deploy the charts for the created cluster. We use a [EFK](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-elasticsearch-fluentd-and-kibana-efk-logging-stack-on-kubernetes) stack (ElasticSearch, Fluent-Bit, Kibana) as our centralized logging solution.

- To start, we initialize the Terraform project with `terraform init`.
- Copy the default config file and edit the DigitalOcean Token API variable.
```shellscript
cp terraform.tfvars.example terraform.tfvars
```
- Visualize the changes with `terraform plan` or deploy them with `terraform apply`.
- When deployment finishes, it outputs the public IP to connect to the Kibana UI and cluster connection commnad for `kubectl`.
```shellscript
Outputs:

cluster_connection = "doctl kubernetes cluster kubeconfig save xxxx-xxxx-xxxx-xxxx"
kibana_load_balancer_ip = "x.x.x.x"
```
- Configure the `kubectl` connection with the previous output.
```shellscript
doctl kubernetes cluster kubeconfig save xxxx-xxxx-xxxx-xxxx
```
- Verify the stack is running.
```shellscript
kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
elasticsearch-master-0          1/1     Running   0          5m
elasticsearch-master-1          1/1     Running   0          5m
fluentbit-fluent-bit-xxxx       1/1     Running   0          5m
fluentbit-fluent-bit-xxxx       1/1     Running   0          5m
fluentbit-fluent-bit-xxxx       1/1     Running   0          5m
kibana-kibana-xxxx-xxxx         1/1     Running   0          5m
```
- Check the logs at `http://x.x.x.x/app/discover` replacing "x.x.x.x" with the output IP.
- Create and Index Pattern with name `logstash-*` and timestamp `@timestamp`.
- Go back to "Discover" section and view the aggregated logs.

Once finished, do not forget to destroy the infrastructure to avoid unwanted fees.
```shellscript
terraform destroy
```

## Final thoughts
The challenge idea was great to try and test the provider (DigitalOcean) and the deployment of the Kubernetes with Helm. Had some previous experience with Terraform, AWS and Grafana as a monitoring solution so I got to experiment with new tools with this challenge.

I found really easy the process of deploying Kubernetes with DigitalOcean compared to AWS for example, and probably will use it again in the future for personal projects. :)
