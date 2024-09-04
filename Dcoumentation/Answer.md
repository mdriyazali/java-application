# Comprehensive Deployment and Management Documentation


###

1. ## Dockerize the Application


###


### 1.1 Unzip the Provided Spring Boot Application


- Objective: Extracting the Spring Boot application from the provided ZIP file to make it available for Dockerization.


- - Commands:

    unzip path/to/spring-boot-application.zip -d path/to/extract/directory


--  ![unzip.png](screenshots/unzip%20the%20folder.png)



- Explanation:
    -  This command extracts the contents of the ZIP file into the specified directory, making the Spring Boot application files available for the next steps.


###

###


### 1.2 Review and Modify the Dockerfile


- Objective: 
    - Ensuring the Dockerfile is correctly configured to build and run the Spring Boot application.

- Steps:
    1. Open the Dockerfile: Examine the Dockerfile in the extracted directory.
    2. Review Key Components:
        - Base Image: It Should be appropriate for running Java applications (e.g., openjdk:11-jdk).
        - Application JAR: Verifying that the JAR file name matches the one in the project.
        -  Port Exposure: Ensuring the port is correctly exposed (e.g., 8080).


###



- - - 
### 1.3 Build the Docker Image


- Objective: 
    - Creating a Docker image from the Dockerfile.

    - Commands:
    
    docker build -t spring-boot-app:latest path/to/dockerfile-directory


--  ![building the docker image.png](screenshots/building%20the%20docker%20image.png)


- Explanation:
    -  docker build: Builds the Docker image.
    - -t myimage: Tags the image with the name myimage.
    -  . : Path to the directory containing the Dockerfile.




###


- - -


## Running the docker image 


--  ![building the docker image.png](screenshots/running%20the%20image.png)



- Here, we can see, 


- After, successfully created the docker image using dockerfil


- We are successfully running the image in the port


- - - 


###


###


## 2. Set Up Docker Compose



# 2.1 Create docker-compose.yml



- Objective: 
    - Defining a Docker Compose file to manage the application and its dependencies.



- Sample docker-compose.yml:


   -  version: '3'
   -  services:
   -  spring-boot-app:
   -  image: myimage:latest
   -  ports:
      - "8080:8080"
    environment:
      - SPRING_PROFILES_ACTIVE=dev
  ### Add other dependencies here if needed (e.g., databases)


- Explanation:
    -  version: '3': Specifies the Docker Compose file format version.
    -  services: Defines the services to run. Here, it includes the spring-boot-app service.
    -  image: Uses the Docker image built in the previous step.
    -  ports: Maps port 8080 of the host to port 8080 of the container.
    - environment: Sets environment variables inside the container.



### Running the Docker-compose 

--  ![building docker-compose.png](screenshots/building%20docker-compose.png)

  - In this, i am building docker-compose and later on making the docker compose to be up




###


- - - 


### 2.2 Ensure Application and Dependencies Start Correctly


- Commands:

    - docker-compose up --build


- Explanation:
    -  docker-compose up: Starts the services defined in docker-compose.yml.
    -  --build: build the docker compose image



--  ![building docker-compose.png](screenshots/building%20docker-compose.png)




###



###


- - - 



## 3. CI/CD with Jenkins


### 3.1 Create a Jenkins Pipeline


- Objective: 
    - Automating the build and deployment process using Jenkins.



- Creating Jenkins Pipeline 


--  ![jenkins.png](screenshots/jenkins%20creating%20pipeline.png)


  - Here, giving the name of jenkins pipeline 

  - After that, selecting the pipeline as type of jenkins configuration for the script



- After that, writing the jenkins pipeline for the CI/CD and automation process



### Jenkins Script

--  ![jenkins.png](screenshots/wiriting%20jenkins%20script.png)




- In this,

- After, all configuration of jenkins including docker hub, docker and kubernetes. 

- I have successfully deploy and push the image from github 


- Pull the docker image from the docker hub


- And created deployment and pod in the kubernetes



- - -


### Assigning Docker credentials in the jenkins


--  ![jenkins.png](screenshots/docker%20credentials%20in%20jenkins.png)


- In this, we can i am providing the credentials of docker hub


- Firstly, i am assigning the username 


- After that, the Token of docker hub


###

- - -


### Assigning Kubernetes in the jenkins


--  ![jenkins.png](screenshots/configuring%20kubernetes%20in%20jenkins.png)


- In this, i am configuring kubernetes in the jenkins credentials


- In this, i am uploading the config file of kubernetes as secret file


- I am uploading the config file of kubernetes as secret file in jenkins credentials



- - - 


### Jenkins Pipeline Successfull

--  ![jenkins.png](screenshots/jenkins%20successfull.png)



- Here, in this we can see jenkins pipeline is succcessfully deployed and its running



--  ![jenkins.png](screenshots/jenkins%20successfull%201.png)




###



###


- - - 



## 4. Set Up Nginx



### 4.1 Configure Nginx as a Reverse Proxy



- Objective: 
    - Configure Nginx to route traffic to the Spring Boot application.


- Sample nginx.conf:


--  ![nginx.png](screenshots/nginx%20configuration.png)




--  ![nginx.png](screenshots/nginx%20configuration%201.png)



- Explanation:
    -  server: Defines the server configuration.
    -  listen 80: Listens on port 80.
    -  server_name: Sets the domain name.
    - location /: Configures the reverse proxy to forward requests to the Spring Boot application.




### Building the docker image using nginx with passing the proxy

--  ![nginx.png](screenshots/building%20nginx%20image.png)


- In this, i have created a nginx docker file containing configuration of defining the proxy in nginx.conf


- After that , i am building the image using nginx configuration






### 4.2 Manage Nginx with Docker or Docker Compose


- Sample:


- Add Nginx Service to docker-compose.yml:
  -  nginx:
  -  image: nginx:latest
  -  ports:
    - "80:80"
  - volumes:
    - ./nginx.conf:/etc/nginx/nginx.conf
  -  depends_on:
    - spring-boot-app



- Explanation:
    -  nginx: Defines the Nginx service.
    -  image: Uses the latest Nginx image.
    -  ports: Maps port 80 of the host to port 80 of the container.
    -  volumes: Mounts the Nginx configuration file into the container.
    -  depends_on: Ensures the spring-boot-app service starts before Nginx.


--  ![nginx.png](screenshots/default%20configuration%20in%20nginx.png)


- As, we can see, the proxy_pass have been done using the name of the backend and exposing the port on it.



### Now, Running the Docker-compose which i have created using nginx.conf and default.conf mapping the proxy-server as backend

--  ![nginx.png](screenshots/nginx%20docker%20compose%20successfull.png)

- As, we see i have given docker name as nginxdocker-compose




--  ![nginx.png](screenshots/running%20the%20docker-compose.png)





- In this, i have created docker-compose then after i am running using the command

    - docker-compose up





--  ![nginx.png](screenshots/getting%20result%20of%20nginx%20using%20curl.png)



- Now, after the building the docker image and building the configuration of docker-compose



- The image is running and docker-compose is also up



- Now, we can see we getting the results after the docker-compose up using curl




###



###


- - - 





## 5. Create a Kubernetes Development Namespace



### 5.1 Set Up Kubernetes Cluster


- Objective: 
    - Initialize a Kubernetes cluster.




- Commands for Minikube:
    - minikube start



- Explanation:
    -  minikube start: Starts a local Kubernetes cluster using Minikube.



### 5.2 Create Development Namespace


- Commands:
    - kubectl create namespace development



- Explanation:
    - kubectl create namespace development: Creates a new namespace named development in the Kubernetes cluster.



--  ![kubernetes.png](screenshots/create%20a%20kubernetes%20development%20namesspace.png)




###



###



- - - 



## 6. Deploy the Application Pod

###


### 6.1 Create and Apply Kubernetes Deployment


- Objective: 
    - Deploy the Dockerized Spring Boot application as a pod in Kubernetes.



- Sample Deployment YAML (deployment.yaml):


    - apiVersion: apps/v1
    - kind: Deployment
    - metadata:
    - name: spring-boot-app
    - namespace: development
  - spec:
    - replicas: 1
  - selector:
    -  matchLabels:
    -  app: spring-boot-app
  - template:
    metadata:
      labels:
        app: spring-boot-app
    - spec:
      containers:
      - name: spring-boot-app
        - image: spring-boot-app:latest
       -  resources:
         -  requests:
         -    memory: "2Gi"
         -    cpu: "1"
        -   limits:
            - memory: "2Gi"
            -  cpu: "1"
        ports:
        - containerPort: 8080





###


- Commands:
    - kubectl apply -f k8s/deployment.yaml -n development



- Explanation:
    -  apiVersion: Specifies the API version.
    -  kind: Defines the resource type (Deployment).
    -  metadata: Metadata for the deployment.
    -  spec: Specifications for the deployment, including replicas, labels, and container configuration.



--  ![kubernetes.png](screenshots/kubernetes%20deployment%20created.png)


- Here, we have created the deployment 



--  ![kubernetes.png](screenshots/deploy%20the%20application%20pod.png)




###


###



- - - 



## 7. Implement Horizontal Pod Autoscaling

###

### 7.1 Configure Horizontal Pod Autoscaling (HPA)


- Objective: 
    - Set up HPA to scale pods based on CPU usage.




- Sample HPA YAML (hpa.yaml):

    - apiVersion: autoscaling/v2beta2
    - kind: HorizontalPodAutoscaler
    - metadata:
        - name: spring-boot-hpa
        - namespace: development
    - spec:
        - scaleTargetRef:
            - apiVersion: apps/v1
            - kind: Deployment
            -  name: spring-boot-app
        - minReplicas: 1
        - maxReplicas: 10
        -  metrics:
            - type: Resource
                -  resource:
                - name: cpu
        - target:
            - type: Utilization
            - averageUtilization: 50




- Commands:

    - kubectl apply -f hpa.yaml -n development




- Explanation:
    -  scaleTargetRef: Specifies the deployment to scale.
    -  minReplicas and maxReplicas: Defines the range for the number of replicas.
    -  metrics: Configures CPU utilization-based scaling.




--  ![kubernetes.png](screenshots/creating%20hpa%20yml-implement%20horizontal%20scalling.png)




### Now, Pod Autoscaling


- Here, after configuration of hpa configuration successfully


- We have to look that pod is autoscaling or not


- It will be autoscaling in the development Namespace


--  ![kubernetes.png](screenshots/Implement%20Horizontal%20Pod%20Autoscaling:.png)


- Here, as we can see pod autoscaling is successfully done


###



###


- - -


## 7.2 Simulate CPU Load


- Commands:
    - kubectl exec -it stress-test -- stress --cpu 2 --timeout 600s -n development



- But, for this i can created stress-test yaml file for simulate CPU load


- Explanation:
    -  kubectl exec: Executes a command in a running pod.
    - stress: A tool to generate CPU load.



###


- - - 


- Verify Scaling:
    - kubectl get hpa -n development

--  ![kubernetes.png](screenshots/verifiedd%20successfull%20this%20Implement%20Horizontal%20Pod%20Autoscaling:.png)


- As, we can see scaling is done


- As its scaling as we want




    - kubectl get pods -n development

--  ![kubernetes.png](screenshots/Implement%20Horizontal%20Pod%20Autoscaling:.png)



###


- Explanation:
    - kubectl get hpa: Checks the status of Horizontal Pod Autoscaler.
    - kubectl get pods: Lists the pods to verify scaling.




###



###


- - - 


## 8. Resource Monitoring and Cleanup


###


### 8.1 Set Up Resource Monitoring


- Objective: 
    - Monitor resource usage in the Kubernetes cluster.



- Commands:
    - kubectl top pods -n development
    - kubectl top nodes




###

- Explanation:
    -  kubectl top pods: Displays resource usage of pods.
    - kubectl top nodes: Displays resource usage of nodes.


--  ![kubernetes.png](screenshots/Resource%20Monitoring%20and%20Cleanup:%20successfull.png)



- - - 


### Installing metric server for monitoring


--  ![kubernetes.png](screenshots/installing%20metric%20server.png)




###


###


- - - 


## 8.2 Clean Up Resources


- Commands to Delete Resources:
    - kubectl delete namespace development


--  ![kubernetes.png](screenshots/namspace%20development%20deleted.png)


- Explanation:
    -  kubectl delete namespace: Deletes the specified namespace and all resources within it.



