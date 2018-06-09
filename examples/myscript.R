## Send the "Content-Type" header:
setContentType("application/json")

## Send the JSON encoded content:
cat(sprintf("{\"version\": \"%s\"}\n", .PAPATYA_VERSION))
