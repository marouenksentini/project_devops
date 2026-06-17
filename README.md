# Projet DevOps : Application Conteneurisée 3 Niveaux

Ce dépôt contient une architecture d'application web 3 niveaux entièrement conteneurisée, orchestrée avec **Docker Compose**. L'infrastructure isole les services backend tout en exposant un reverse proxy sécurisé vers la machine hôte.

---

## 🎯 Objectifs

- **Conteneurisation :** Empaqueter les composants frontend, backend et base de données dans des conteneurs Docker légers et indépendants.
- **Isolation réseau :** Mettre en place un réseau bridge virtuel privé dédié (`bridge_default`) pour isoler les données backend du trafic public.
- **Découverte de services :** Utiliser le serveur DNS interne intégré de Docker pour router la communication inter-services dynamiquement par nom de service plutôt que par des adresses IP instables.

---

## 🏗️ Vue d'ensemble de l'architecture

Le cluster est composé de trois services principaux s'exécutant dans un réseau Docker isolé :

| Nom du service | Technologie | Type de réseau | Port externe | Port interne |
| --- | --- | --- | --- | --- |
| `frontend-devops` | Nginx (Alpine) | Bridge public / interne | `80` | `80` |
| `backend-devops` | Java (Spring Boot) | Bridge interne uniquement | *Aucun* | `8080` |
| `mysql-devops` | MySQL 8.0 | Bridge interne uniquement | *Aucun* | `3306` |

### Flux du trafic réseau

1. **Client → Frontend :** L'utilisateur accède à l'application depuis l'extérieur via `http://localhost:80`.
2. **Frontend → Backend :** Nginx joue le rôle de **Reverse Proxy**. Il intercepte le trafic entrant sur `/api/` et le transfère en interne vers `http://backend-devops:8080/` via le DNS interne de Docker. Cela résout nativement les problèmes de Cross-Origin Resource Sharing (CORS).
3. **Backend → Base de données :** L'application Spring Boot communique de manière sécurisée avec la couche base de données via l'URL interne `jdbc:mysql://mysql-devops:3306/`.

---

## 🚀 Guide d'utilisation

### Prérequis

Assurez-vous d'avoir installé sur votre machine :

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Windows/Mac) ou Docker Engine (Linux)
- Docker Compose V2

### 1. Cloner le dépôt

```bash
git clone https://github.com/marouenksentini/project_devops.git
cd project_devops
```
