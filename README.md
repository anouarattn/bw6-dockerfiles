# bw6-dockerfiles
some dockerfiles to run tibco bw6 + Tibco Tea



# Prerequisites
Having TIB_BW-dev_6.5.0_linux26gl23_x86_64.zip install zip in  root folder



# Creating an envirennement
To create an envirennement consisting of Tibco BW6 Agent + TEA we need to :
  1. Build the image env.Dockerfile
  ```docker build --rm -t="env:latest" . -f env.Dockerfile```
  2.  Run envirennement 
      - Integration Envirennement
      
      ```docker run -dt --name INTEG --hostname INTEG -p  8771:8777 -p 8079:8079 env:latest```
	  
      - QA Envirennement 
      
      ```docker run -dt --name QA --hostname QA -p  8772:8777 -p 8078:8079 env:latest```
     
      - Production Envirennement
      
      ```docker run -dt --name PROD --hostname PROD -p  8773:8777 -p 8077:8079 env:latest```

# Creating dev bw6 studio container

  1. Build the image dev.Dockerfile
  
	```docker build --rm -t="dev:latest" . -f dev.Dockerfile```
	
  2.  Run  
	
	```docker run -dt -p  6081:80  dev:latest```

# Creating Azure Agent container 

  1. Build the image agentazure.Dockerfile

	```docker build --rm -t="agentazure:latest" . -f agentazure.Dockerfile```
	
  2.  Run azure agent container 

	```docker run -dt --name agent-azure --hostname agent-azure -e AZP_URL=TO_BE_REPLACED -e AZP_TOKEN=TO_BE_REPLACED -e AZP_POOL=TO_BE_REPLACED agentazure:latest
