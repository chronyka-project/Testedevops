# Chronyka Project

Este repositório contém o **Chronyka Project**, um desafio de **DevOps** que envolve a automação de provisionamento e configuração de ambientes utilizando **Terraform** e **Ansible**, além da criação de pipelines de **CI/CD**.

O objetivo é demonstrar boas práticas de **Infraestrutura como Código (IaC)**, **automação de deploy** e **gestão de múltiplos ambientes** (DEV, QA e PROD), aplicando conceitos modernos de integração contínua e entrega contínua.

---

## 🔹 Estrutura do Projeto

```
devops-challenge/
│
├── apps/                        # Aplicações utilizadas no desafio
│   ├── wordpress/               # App monolítica
│   ├── sock-shop/               # App baseada em microsserviços
│   └── ghost-blog/              # App leve para testes
│
├── terraform/                   # IaC com Terraform
│   ├── vmware/                  # Ambientes DEV e QA (on-prem)
│   └── aws/                     # Ambiente PROD (cloud AWS)
│
├── ansible/                     # Automação de configuração
│   ├── inventories/             # Inventários de DEV, QA e PROD
│   └── roles/                   # Roles para cada aplicação
│
├── ci-cd/                       # Definições de pipelines CI/CD
│   ├── github-actions/
│   └── gitlab-ci/
│
├── monitoring/                  # Configurações de monitoramento
│
└── docs/                        # Documentação e diagramas
```

---

## 🔹 Tecnologias Utilizadas

* **Terraform** → Provisionamento de infraestrutura (VMware e AWS).
* **Ansible** → Configuração e deploy das aplicações.
* **GitHub Actions** → CI/CD automatizado (build, test, deploy).
* **Docker** → Containerização de serviços.
* **Prometheus & Grafana** → Monitoramento e observabilidade.

---

## 🔹 Ambientes

* **DEV** → VMware (infra local).
* **QA** → VMware (infra local, homologação).
* **PROD** → AWS (nuvem, alta disponibilidade).

---

## 🔹 Aplicações

1. **Node JS**
2. **Sock Shop**
3. **App Flask**

---

## 🔹 Fluxo de Branches

* `dev` → Deploy automático em DEV.
* `qa` → Deploy automático em QA.
* `main` → Deploy automático em PROD.
* `feature/...` → Desenvolvimento de novas funcionalidades.
* `hotfix/...` → Correções urgentes em produção.

---

## 🔹 Objetivo

O **Chronyka Project** demonstra como estruturar e automatizar ambientes híbridos (on-prem + cloud), utilizando pipelines modernas e práticas de DevOps.

Esse projeto é uma simulação realista de como empresas podem gerenciar aplicações em diferentes ambientes, garantindo consistência, automação e rastreabilidade em todo o ciclo de vida do software.

---

