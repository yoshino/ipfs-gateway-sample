# IPFS Gateway Sample
## Versions
```
>> terraform -v
Terraform v1.2.4
on linux_amd64
```

```
>> aws --version
aws-cli/2.7.14 Python/3.9.11 Linux/5.4.72-microsoft-standard-WSL2 exe/x86_64.ubuntu.20 prompt/off
```

## Setup
### Creadentials
AWS credential.

```
aws configure
```

SSH key for EC2.

```
ssh-keygen -t rsa -f ipfs_ssh_key -N ''
```

You must be careful to expose `ipfs_ssh_key` to internet.  
`ipfs_ssh_key.pub` value should be in `terrafrom.tfvars` as below.

```
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2E......"
```

### AWS resources

```
cd aws_resources
terrafrom apply
```

## SSH

```
ssh -i ipfs_ssh_key ubuntu@ec2-<Public IPv4 DNS>.ap-northeast-1.compute.amazonaws.com
```
