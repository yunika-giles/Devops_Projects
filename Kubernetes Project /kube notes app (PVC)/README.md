# 📦 Project Title: "Kube Notes App"

A basic Notes API app (Node.js or Python) that stores user notes in a file system and displays a welcome message (configured using a ConfigMap).

# 🧭 Kube Notes App - Kubernetes Workflow

This project demonstrates the following Kubernetes concepts:
- Volumes
- Persistent Volumes (PV)
- ConfigMaps
- Using ConfigMaps in Deployments

---

## 🔹 STEP 1: Prepare Your Environment

**Requirements:**
- Minikube or Kubernetes cluster
- kubectl installed and configured
- Docker (if you build a custom image)

---

## 🔹 STEP 2: Create the Application

Use a simple Python Flask app with:
- `/` - Shows welcome message (from ConfigMap)
- `/note` - Saves notes to volume
- `/notes` - Reads notes from volume

---

## 🔹 STEP 3: Containerize the Application

**Optional Dockerfile**

```python
FROM python:3.9
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
```

**Build & Push**

```bash
docker build -t <your-username>/kube-notes-app:latest .
docker push <your-username>/kube-notes-app:latest
```

---

## 🔹 STEP 4: Create Kubernetes Resources

### ✅ 4.1 ConfigMap

**File: configmap.yaml**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: welcome-config
data:
  WELCOME_MESSAGE: "Welcome to the Kube Notes App!"
```

```
kubectl apply -f configmap.yaml
```

### ✅ 4.2 Persistent Volume Claim

**File: pvc.yaml**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: notes-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

```bash
kubectl apply -f pvc.yaml
```

### ✅ 4.3 Deployment

**File: deployment.yaml**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: notes-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: notes
  template:
    metadata:
      labels:
        app: notes
    spec:
      containers:
      - name: notes-container
        image: <your-dockerhub-username>/kube-notes-app:latest
        ports:
          - containerPort: 5000
        env:
        - name: WELCOME_MESSAGE
          valueFrom:
            configMapKeyRef:
              name: welcome-config
              key: WELCOME_MESSAGE
        volumeMounts:
        - name: notes-volume
          mountPath: /data
      volumes:
      - name: notes-volume
        persistentVolumeClaim:
          claimName: notes-pvc
```

```bash
kubectl apply -f deployment.yaml
```

### ✅ 4.4 Service

**File: service.yaml**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: notes-service
spec:
  type: NodePort
  selector:
    app: notes
  ports:
    - protocol: TCP
      port: 80
      targetPort: 5000
      nodePort: 30036
```

```bash
kubectl apply -f service.yaml
```

---

## 🔹 STEP 5: Access the App

```bash
minikube service notes-service
```

Visit:
```bash
http://<minikube-ip>:30036/
```

---

## 🔹 STEP 6: Test the App

- `GET /` → Welcome message (from ConfigMap)
- `POST /note` with `note=Your text` → Saves it
- `GET /notes` → Shows saved notes

---

## 🔹 STEP 7: Clean Up

```bash
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml
kubectl delete -f pvc.yaml
kubectl delete -f configmap.yaml
```