## DEPLOY AN APPLICATION ON SPOT

We are redesigning our Microservice example and want our frontend service to be deployed on Spot Instances when they are available. We will ensure that the NodeJS and crystal backend services are deployed on On-Demand Instances. We will use Node Affinity in our manifest file to configure this.

Configure Node Affinity for the services
Open the deployment manifest of the frontend service in your Cloud9 editor - ~/environment/ecsdemo-frontend/kubernetes/deployment.yaml

Edit the spec to configure NodeAffinity to prefer Spot Instances, but not require them. This will allow the pods to be scheduled on On-Demand nodes if no spot instances were available or correctly labelled.

Open the deployment manifest for the backend services in your Cloud9 editor - ~/environment/ecsdemo-nodejs/kubernetes/deployment.yaml and ~/environment/ecsdemo-crystal/kubernetes/deployment.yaml

Edit the spec to configure NodeAffinity to require On-Demand Instances. This will allow the pods to be scheduled on On-Demand nodes and not on the Spot Instances.

For examples of Node Affinity, check this link https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity

Configure Affinity

 Expand here to see the solution
Add this to your deployment file for the frontend service under spec.template.spec
      affinity:
        nodeAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 1
            preference:
              matchExpressions:
              - key: eks.amazonaws.com/capacityType
                operator: In
                values:
                - SPOT
Add this to your deployment file for the backend services under spec.template.spec
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: eks.amazonaws.com/capacityType
                operator: In
                values:
                - ON_DEMAND

Deployment final files are in:

DIR_FOLDER; update-and-redeploy-for-spot

Update as neccessary.


### Redeploy the application - Frontend on Spot and Backend on On-Demand

```bash
#First let’s take a look at all pods deployed on Spot instances

 for n in $(kubectl get nodes -l eks.amazonaws.com/capacityType=SPOT --no-headers | cut -d " " -f1); do echo "Pods on instance ${n}:";kubectl get pods --all-namespaces  --no-headers --field-selector spec.nodeName=${n} ; echo ; done

#Now we will redeploy our microservices with our edited Frontend 
#Manifest

cd deployments/environment/ecsdemo-frontend
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/deployment.yaml

cd deployments/environment/ecsdemo-crystal
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/deployment.yaml

cd deployments/environment/ecsdemo-nodejs
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/deployment.yaml

#We can again check all pods deployed on Spot Instances and 
#should now see the frontend pods running on Spot instances

 for n in $(kubectl get nodes -l eks.amazonaws.com/capacityType=SPOT --no-headers | cut -d " " -f1); do echo "Pods on instance ${n}:";kubectl get pods --all-namespaces  --no-headers --field-selector spec.nodeName=${n} ; echo ; done

#check all the pods deployed on On-Demand Instances and should
#now see all the backend pods running on On-Demand instances

 for n in $(kubectl get nodes -l eks.amazonaws.com/capacityType=ON_DEMAND --no-headers | cut -d " " -f1); do echo "Pods on instance ${n}:";kubectl get pods --all-namespaces  --no-headers --field-selector spec.nodeName=${n} ; echo ; done

 ```