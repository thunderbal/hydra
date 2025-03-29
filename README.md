# thunderball/hydra

## Build

Check for releases available at https://github.com/ory/hydra/releases

```bash
VERSION=v2.3.0
docker build -t thunderball/hydra:${VERSION} --build-arg VERSION=${VERSION} .
```

## Hydra CLI


```bash
alias hydra='docker run --rm thunderball/hydra:v2.3.0 -e http://localhost:4445'
```