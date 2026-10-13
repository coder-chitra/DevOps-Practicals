# A. Tag the image as <dockerhub-username>/<repository>:<tag>
docker tag node-http-server:1.0 <dockerhub-username>/node-http-server:1.0

# B. Log in (enter your Docker Hub username and password or access token)
docker login

# C. Push the tagged image
docker push <dockerhub-username>/node-http-server:1.0