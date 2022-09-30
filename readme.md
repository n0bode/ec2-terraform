# How to configure your repository

## Add environment var to your CI/CD:
```bash

    TF_VAR_region = '<aws-region>'
    TF_VAR_stage = '<stage your app>'
    TF_VAR_vpc_id = '<vpc_id of stage>'
```

## CI/CD

This is a simple script to run in pipeline:

```bash
$ apt install terraform
$ # terraform init for stage app
$ # bucket=terraform-lock-states (bucket s3 to save lock-states terraform) you can change it, but it must exists first
$ terraform init -backend-config="bucket=terraform-lock-states" -backend-config="key=webapp-$TF_VAR_stage" -backend-config="region=$TF_VAR_region"
$ terraform plan -auto-aprove -replace aws_instace.maquina
$ 
```


