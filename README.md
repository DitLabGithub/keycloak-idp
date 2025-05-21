# Keycloak IDP (Identity Provider)

This repository contains the configuration and deployment scripts for a Keycloak Identity Provider (IDP) setup using Docker Swarm and Traefik.

## Overview

The Keycloak IDP setup consists of two main services:

1. PostgreSQL database (postgres-idp)
2. Keycloak instance

These services are deployed using GitHub Actions, which automates the deployment process to a Docker Swarm cluster.

## Key Features

- **Docker Swarm Deployment**: Utilizes Docker Swarm for orchestration, providing scalability and high availability.
- **Traefik Integration**: Uses Traefik as a reverse proxy and load balancer, handling SSL termination and routing.
- **Automated Deployment**: GitHub Actions workflow for automated deployment to a remote server.
- **Secure Configuration**: Sensitive information is managed through GitHub Secrets.
- **Realm Configuration**: Custom realm configuration is baked into the Keycloak Docker image.

## Configuration

### Environment Variables

The project uses a `.env-template` file to define the required environment variables. In the actual deployment, these variables are set as GitHub Secrets and injected into the deployment process. This approach ensures that sensitive information is not stored in the repository.

Key environment variables include:

- Database credentials
- Keycloak admin credentials
- Hostname configuration

### realm.json

The `realm.json` file contains the configuration for the Keycloak realm. This file is baked into the Keycloak Docker image during the build process, ensuring that the realm configuration is always available without needing to persist it on the host system.

## Deployment Process

1. **GitHub Actions Trigger**: The deployment is triggered on pushes to the main branch.

2. **Environment Setup**:

   - The workflow sets up SSH access to the remote server.
   - It creates necessary directories on the remote server.

3. **File Transfer**:

   - `docker-compose.yml`, `Dockerfile`, and `realm.json` are copied to the remote server.
   - A `.env` file is created on the remote server using the GitHub Secrets.

4. **Docker Network**:

   - Checks for the existence of a `web` network and creates it if not present.

5. **Deployment**:

   - The Docker stack is deployed using `docker stack deploy`.

6. **Cleanup**:
   - After successful deployment, all deployment files are removed from the remote server.

## Docker Swarm and Traefik

This setup is designed to work with a Docker Swarm cluster and Traefik as the edge router:

- **Docker Swarm**: Provides orchestration for the services, allowing for easy scaling and management of the Keycloak and PostgreSQL containers.
- **Traefik**: Acts as a reverse proxy and load balancer. It's responsible for routing incoming requests to the appropriate services and handling SSL termination.

## Security Considerations

- SSL certificates are mounted into the Keycloak container for HTTPS support.
- All sensitive information is managed through GitHub Secrets, not stored in the repository.
- The `realm.json` file is baked into the Docker image, reducing the risk of unauthorized modifications.

## Maintenance

After deployment, the repository files are removed from the remote server. Any updates to the configuration or realm settings will require a new deployment through the GitHub Actions workflow.

## Prerequisites

- A server with Docker Swarm initialized
- Traefik set up as the edge router in the Swarm
- GitHub repository with appropriate secrets configured
- SSL certificates for the Keycloak domain
