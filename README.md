# bw6-dockerfiles
some dockerfiles to run tibco bw6 + Tibco Tea



# Prerequisites
Having TIB_BW-dev_6.5.0_linux26gl23_x86_64.zip install zip in  root folder



# Creating an envirennement
To create an envirennement consisting of Tibco BW6 Agent + TEA we need to :
  1. Build the base image base.Dockerfile
  ```docker build --rm -t="env:latest" . -f .\env.Dockerfile```
  2.  Run envirennement 
      - Integration Envirennement
      
      ```docker run -dt --name INTEG --hostname INTEG --rm -p  8771:8777 env:latest```
      - QA Envirennement 
      
      ```docker run -dt --name INTEG --hostname QA --rm -p  8772:8777 env:latest```
     
      - Production Envirennement
      
      ```docker run -dt --name INTEG --hostname PROD --rm -p  8773:8777 env:latest```
