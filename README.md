# Elastic stack (ELK) on Docker

Get latest `README.md` [here](https://github.com/deviantony/docker-elk)

### Install one script

```shell
bash <(curl -s https://raw.githubusercontent.com/liasica/docker-elk/svc/install.sh)
```

### Useful links
- [Import and export dashboard APIs](https://www.elastic.co/guide/en/kibana/current/dashboard-api.html)

### Questions

#### 1. Setup fails with `maybe these locations are not writable or multiple nodes were started on the same data path`

You should set correct permission with the data folder
```
chown -Rv 1000:0 /your/data/folder
```