# dotnetcore-dockerised
Run the following commands to build and run images:

docker build -t dotnet-dockerised .
docker run -d -p 5000:80 --name myapp dotnet-dockerised