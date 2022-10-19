# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

apiVersion: apps/v1
kind: Deployment
metadata:
  name: test-php
  labels:
    app: test-php
spec:
  replicas: 1
  selector:
    matchLabels:
      app: test-php
  template:
    metadata:
      labels:
        app: test-php
    spec:
      containers:
      - name: hello-cloudbuild
        image: us-central1-docker.pkg.dev/GOOGLE_CLOUD_PROJECT/my-repository/hello-cloudbuild:COMMIT_SHA
        ports:
        - containerPort: 8080
---
kind: Service
apiVersion: v1
metadata:
  name: test-php
spec:
  selector:
    app: test-php
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  type: LoadBalancer
