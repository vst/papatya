# papatya - lazy man's polyglot Web application container

## Quickstart

Pull the latest *papatya* Docker image:

```
docker pull vehbisinan/papatya:latest
```

Run the Docker image without any custom content:

```
docker run -d -p 8000:80 --name my-papatya vehbisinan/papatya:latest
```

By now, you should be able to see the plain/vanilla index page
provided in the Docker image and served by Apache (No R involved):

[http://localhost:8000/](http://localhost:8000/)


Let's run the Docker image with custom content (as provided in the
`/examples` directory on the Git repository). First, remove the
container which we created above:

```
docker rm -f my-papatya
```

Now, run the Docker image by providing the `examples` directory as the
Web content directory:

```
docker run -d -p 8000:80 -v $(pwd)/examples:/var/www/html --name my-papatya vehbisinan/papatya:latest
```

Test it:

- Run one of your PHP scripts, say `myscript.php`: [http://localhost:8000/myscript.php](http://localhost:8000/myscript.php)
- Run one of your Python CGI scripts, say `myscript.py`: [http://localhost:8000/myscript.py](http://localhost:8000/myscript.py)
- Run one of your R scripts, say `myscript.R`: [http://localhost:8000/myscript.R](http://localhost:8000/myscript.R)
- Run one of your Rhtml files, say `mypage.Rhtml`: [http://localhost:8000/mypage.Rhtml](http://localhost:8000/mypage.Rhtml)
- Run one of your Rmd files, say `mypage.Rmd`: [http://localhost:8000/mypage.Rmd](http://localhost:8000/mypage.Rmd)
- Run one of your Rmd files with plots, say `mypage_with_plot.Rmd`: [http://localhost:8000/mypage\_with\_plot.Rmd](http://localhost:8000/mypage_with_plot.Rmd)

## Building the Docker Image

Clone this repository:

```
git clone git@github.com:vst/papatya.git
```

Change the directory:

```
cd papatya
```

Build a local Docker image:

```
docker build . -t papatya
```
