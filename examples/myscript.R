## Send the "Content-Type" header:
setContentType("application/json")

## Send the JSON encoded content:
cat(sprintf("{\"version\": \"\"}\n", Sys.getenv("PAPATYA_VERSION")))
