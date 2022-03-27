# code-challenge
The repository is created to demonstrate the IaC code implementation

The repository contains the 3 directories:

  * `api`: contains the api source code
  * `docker`: contains the docker file
  * `iac`: contains the IaC files

## api directory
The api is developed using the python and flask frameworks. The directory contains the source code for the api.

  * `app.py`: contains the api source code & api routes.
  * `requirements.txt`: contains the python dependencies.
  * `version.txt`: contains the version of the api

## docker directory
The docker directory contains the docker file.

  * `Dockerfile` : contains the docker file.

### Deploy the docker image 
**Step 1**: Build the image.
  ```
  docker build -t cc-uat:latest .
  ```
The above command will create a image with tag `cc-uat:latest`

**Step 2**: Run the container.
  ```
  docker run -dit --rm -p 5000:5000 --name cc-uat cc-uat:latest
  ```
The above command will run the container with the port 5000.

**Step 3**: Test the container
Run the below command to test the container and up and running and api is returning the correct output.
  ```
  curl -i http://localhost:5000/
  ```

## iac directory

Men at work.