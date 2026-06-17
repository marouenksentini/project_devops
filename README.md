# DevOps Project: 3-Tier Containerized Application

This repository contains a fully containerized 3-tier web application architecture orchestrated using **Docker Compose**. The infrastructure isolates backend services while exposing a secure reverse proxy to the host machine.

---

## 🎯 Objectives
* **Containerization:** Package the frontend, backend, and database components into lightweight, independent Docker containers.
* **Network Isolation:** Establish a secure, dedicated private virtual bridge network (`bridge_default`) to isolate backend data from public traffic.
* **Service Discovery:** Utilize Docker's internal embedded DNS server to route service-to-service communication dynamically by service name rather than unstable IP addresses.

---

## 🏗️ Architecture Overview

The cluster consists of three main services running inside an isolated Docker network:

| Service Name | Technology | Network Type | External Port | Internal Port |
| :--- | :--- | :--- | :--- | :--- |
| `frontend-devops` | Nginx (Alpine) | Public / Internal Bridge | `80` | `80` |
| `backend-devops` | Java (Spring Boot) | Internal Bridge Only | *None* | `8080` |
| `mysql-devops` | MySQL 8.0 | Internal Bridge Only | *None* | `3306` |

### Network Traffic Flow
1. **Client to Frontend:** The user accesses the application externally via `http://localhost:80`.
2. **Frontend to Backend:** Nginx acts as a **Reverse Proxy**. It catches incoming `/api/` traffic and forwards it internally to `http://backend-devops:8080/` using Docker's internal DNS. This natively resolves Cross-Origin Resource Sharing (CORS) complications.
3. **Backend to Database:** The Spring Boot application communicates securely with the database layer using the internal URL `jdbc:mysql://mysql-devops:3306/`.

---

## 🚀 How to Use

### Prerequisites
Make sure you have the following installed on your machine:
* [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Windows/Mac) or Docker Engine (Linux)
* Docker Compose V2

### 1. Clone the Repository
```bash
git clone [https://github.com/marouenksentini/project_devops.git](https://github.com/marouenksentini/project_devops.git)
cd project_devops