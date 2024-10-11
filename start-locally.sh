nerdctl stop database-container
nerdctl rm database-container
nerdctl build --file ./Dockerfile.database -t database .
nerdctl run -d --name database-container -p 81:5432 database