# Maven docker multi-stage builder

Cache the maven dependencies used by maen, got the idea from  https://github.com/carlossg/docker-maven#packaging-a-local-repository-with-the-image

Use make use the cache, add a `-s /usr/share/maven/ref/settings-docker.xml` option to the maven command


