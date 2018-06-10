#!/usr/bin/env python3

## Import the CGI library with special traceback function
import cgitb
cgitb.enable()

## Send the content type
print("Content-Type: application/json")

## Mark the end of HTTP response headers:
print()

## Say something:
print("{\"song\": \"500 Miles High\"}")
