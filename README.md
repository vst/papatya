# papatya - yet another rapache image

## Quickstart

Build the Docker image:

```
docker build . -t papatya
```

Run the Docker image:

```
docker run -d -p 8000:80 -v </path/to/your/scripts>:/var/www/scripts/ --name my-papatya papatya
```

Test it:

1. **See plain/vanilla root page (No R involved):** [http://localhost:8000/](http://localhost:8000/)
2. **Run one of your scripts, say myscript.R:** [http://localhost:8000/endpoints/myscript.R](http://localhost:8000/endpoints/myscript.R)
