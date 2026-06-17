# Projet DevOps : Application Conteneurisée à 3 Niveaux (3-Tier)

Ce dépôt contient une architecture d'application web à 3 niveaux entièrement conteneurisée et orchestrée avec **Docker Compose**. L'infrastructure isole les services backend tout en exposant un reverse proxy sécurisé vers la machine hôte.

---

## 🎯 Objectifs
* **Conteneurisation :** Packager les composants frontend, backend et base de données dans des conteneurs Docker légers et indépendants.
* **Isolation Réseau :** Mettre en place un réseau virtuel privé et dédié de type bridge (`bridge_default`) pour isoler les données du backend du trafic public.
* **Découverte de Services (Service Discovery) :** Utiliser le serveur DNS interne de Docker pour router la communication entre services de manière dynamique via leur nom de service, plutôt qu'avec des adresses IP instables.

---

## 🏗️ Aperçu de l'Architecture

Le cluster est composé de trois services principaux s'exécutant au sein d'un réseau Docker isolé :

| Nom du Service | Technologie | Type de Réseau | Port Externe | Port Interne |
| :--- | :--- | :--- | :--- | :--- |
| `frontend-devops` | Nginx (Alpine) | Public / Bridge Interne | `80` | `80` |
| `backend-devops` | Java (Spring Boot) | Bridge Interne Uniquement | *Aucun* | `8080` |
| `mysql-devops` | MySQL 8.0 | Bridge Interne Uniquement | *Aucun* | `3306` |

### Flux du Trafic Réseau
1. **Du Client au Frontend :** L'utilisateur accède à l'application depuis l'extérieur via `http://localhost:80`.
2. **Du Frontend au Backend :** Nginx agit comme un **Reverse Proxy**. Il intercepte le trafic entrant `/api/` et le redirige en interne vers `http://backend-devops:8080/` grâce au DNS interne de Docker. Cela résout nativement les complications liées au CORS (Cross-Origin Resource Sharing).
3. **Du Backend à la Base de Données :** L'application Spring Boot communique de manière sécurisée avec la couche de données en utilisant l'URL interne `jdbc:mysql://mysql-devops:3306/`.

---

## 🚀 Guide d'Utilisation

### Prérequis
Assurez-vous que les outils suivants sont installés sur votre machine :
* [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Windows/Mac) ou Docker Engine (Linux)
* Docker Compose V2

### 1. Cloner le Dépôt
```bash
git clone [https://github.com/marouenksentini/project_devops.git](https://github.com/marouenksentini/project_devops.git)
cd project_devops
