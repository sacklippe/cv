# Curriculum Vitae

Shout out to the [Twenty-seconds-CV](https://github.com/alanBZH/Twenty-seconds-CV) project. It is a good template to create my own CV format.

## Build

Additionally to the make file you can use the `Dockerfile` to generate the pdf.

```shell
docker build -t latexbuilder .
docker run --rm -v $(pwd):/usr/src/mylatex latexbuilder
```
