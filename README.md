lign="center">
  AKS devops infrastructure
</h1>

<p align="center">
  <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square"/>
  <img src="https://img.shields.io/github/last-commit/DzeCin/devops-aks-infra?color=green"/>
</p>

<h4 align="center">
  Status: 🚧 In Construction
</h4>

<p align="center">
  <a href="#about">About</a> •
  <a href="#tech-stack">Tech Stack</a> •
  <a href="#contact">Contact</a> 
</p>

## About
This project provides an easy way to create a production ready AKS cluster. Important logs export are configured to an Event Hub which can be used as a Kafka endpoint for input plugin in Logstash or Fluentd.

## Tech Stack
<img src="https://img.shields.io/badge/Bash-05122A?style=flat&logo=gnu-bash" alt="bash Badge" height="25">&nbsp;

## Contact

Made by [Dzenan](https://github.com/DzeCin), get in touch!

<a href="mailto:dzenancindrak@outlook.fr" target="_blank"><img src="https://img.shields.io/badge/Email-D14836?style=flat&logo=gmail&logoColor=white" alt="Email Badge" height="25"></a>&nbsp;

<br clear="left"/>

## TODO

- [x] Config Azure diag exports for audit log
- [x] Config exports for log analytics workspace
- [] Define logs to export from Azure Diagnostics to event hub and from analytics workspace to event hub
- [] Clean up the code and better exec.sh
- [] Use azure cni plugin
- [] Options with exec.sh  
- [] Ansible for logstash install