## Project Goal

Deploy a simple Nginx web server using Kubernetes Pods, then manage it efficiently using Deployments and Scaling.

## Step 1: Create a Simple Pod

A Pod is the smallest unit in Kubernetes, running one or more containers.

### 1. Create `nginx-pod.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
```
### 2. Deploy the Pod
```bash
kubectl apply -f nginx-pod.yaml
```
### 3. Verify the Pod

```bash
kubectl get pods
kubectl describe pod nginx-pod
```
## Step 2: Understand Pod 
Networking
Pod have unique IPs inside cluster

**Test Networking**

```bash
kubectl exec -it nginx-pod -- curl http://localhost
```
## Step 3: Explore Pod Lifecycle

Pods go through phases (`Pending`, `Running`, `Succeeded/Failed`).

**Check Pod Status**

```bash
kubectl get pods -w  # Watch status changes
```

**Simulate a Crash & Recovery**

```bash
kubectl delete pod nginx-pod  # Delete the Pod manually
kubectl get pods              # Verify it's gone
```
## Step 4: Use Deployments for Better Management

Deployments manage Pods via ReplicaSets and allow easy updates/rollbacks.

### 1. Create `nginx-deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
        ports:
        - containerPort: 80
```
### 2. Deploy It
```bash
kubectl apply -f nginx-deployment.yaml
```
### 3. Check Deployment & Pods

```bash
kubectl get deployments
kubectl get pods
```
## Step 5: Scale the Deployment

### 1. Manually Scale Up

```bash
kubectl scale deployment nginx-deployment --replicas=4
kubectl get pods  # Now shows 4 Pods
```
### 2. Auto-Scaling (Optional - Needs Metrics Server)
```bash
kubectl autoscale deployment nginx-deployment --min=2 --max=5 --cpu-percent=80
kubectl get hpa  # Check Horizontal Pod Autoscaler
```
## Step 6: Rolling Updates & Rollbacks

### 1. Update Nginx Version

```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.22
kubectl rollout status deployment/nginx-deployment
```
### 2. Undo if Something Goes Wrong

```bash
kubectl rollout undo deployment/nginx-deployment
```
**Final Verification**
```bash
kubectl get all  # See Pods, Deployments, ReplicaSets
kubectl describe deployment nginx-deployment
```