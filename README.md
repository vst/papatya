# papatya - yet another rapache image

## Quickstart

Build the Docker image:

```
docker build . -t papatya
```

Run the Docker image:

```
docker run -d -p 8000:80 -v </path/to/your/code>:/var/www/html/ --name my-papatya papatya
```

Test it:

1. See plain/vanilla root page (No R involved): [http://localhost:8000/](http://localhost:8000/)
2. Run one of your scripts, say `myscript.R`: [http://localhost:8000/myscript.R](http://localhost:8000/myscript.R)
3. Run one of your Rhtml files, say `mypage.Rhtml`: [http://localhost:8000/mypage.Rhtml](http://localhost:8000/mypage.Rhtml)
4. Run one of your Rmd files, say `mypage.Rmd`: [http://localhost:8000/mypage.Rmd](http://localhost:8000/mypage.Rmd)
