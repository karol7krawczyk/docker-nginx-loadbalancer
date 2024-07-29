# NGINX Load Balancer with Prometheus Monitoring

![License](https://img.shields.io/badge/license-MIT-blue.svg)

## Overview

This project sets up an NGINX load balancer with multiple NGINX instances and integrates Prometheus for monitoring. The load balancer distributes incoming requests across several backend NGINX servers and collects metrics to monitor their performance and error rates.

## Table of Contents

- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Docker Compose Configuration](#docker-compose-configuration)
- [Running the Application](#running-the-application)
- [Monitoring with Grafana](#monitoring-with-grafana)


## Architecture

The architecture consists of the following components:

- **NGINX Instances**: Three NGINX instances configured as backend servers.
- **Load Balancer**: An NGINX instance configured as a load balancer to distribute traffic to the backend servers.
- **Prometheus**: A monitoring tool that scrapes metrics from the NGINX instances.
- **Grafana**: A visualization tool for displaying metrics collected by Prometheus.

## Prerequisites

Before you begin, ensure you have the following installed:

- Docker
- Docker Compose
- Basic knowledge of YAML and Docker commands

## Docker Compose Configuration

### `docker-compose.yml`

This file defines the services, networks, and volumes used in the application.

```yaml
services:
  nginx1:
    image: nginx:1.26-alpine
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./default.conf:/etc/nginx/conf.d/default.conf
      - ./app:/var/www/html
    networks:
      - lb_network

  nginx2:
    image: nginx:1.26-alpine
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./default.conf:/etc/nginx/conf.d/default.conf
      - ./app:/var/www/html
    networks:
      - lb_network

  nginx3:
    image: nginx:1.26-alpine
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./default.conf:/etc/nginx/conf.d/default.conf
      - ./app:/var/www/html
    networks:
      - lb_network

  loadbalancer:
    image: nginx:1.26-alpine
    volumes:
      - ./loadbalancer.conf:/etc/nginx/nginx.conf
    ports:
      - "80:80"
    networks:
      - lb_network

  php:golang-log-monitor
    image: php:8.4-fpm-alpine
    volumes:
      - ./app:/var/www/html
    networks:
      - lb_network

  prometheus:
    image: prom/prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"
    networks:
      - lb_network

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    networks:
      - lb_network

networks:
  lb_network:
    driver: bridge
```

### Clone the repository
```bash
git clone https://github.com/Karol7Krawczyk/nginx-load-balancer.git
cd nginx-load-balancer
```

### Run in docker
```bash
make build
make up
```

## Running the Application
- Open a terminal and navigate to the project root directory.

- Run the following command to start all services:

  docker-compose up -d
- Access the NGINX load balancer at http://localhost.

- Access Prometheus at http://localhost:9090.

- Access Grafana at http://localhost:3000 (default login: admin / admin).


## Monitoring with Grafana
- Log in to Grafana and add Prometheus as a data source:
   URL: http://prometheus:9090
- Create dashboards to visualize NGINX metrics and alerts.


## License
This project is licensed under the MIT License - see the LICENSE file for details.
