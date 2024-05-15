
# Sulu Create Project Docker Image

Cette image Docker personnalisée permet de créer un projet Sulu en utilisant Composer. Elle inclut toutes les extensions PHP nécessaires, comme GD et intl, pour éviter les erreurs courantes lors de l'installation. De plus, elle s'assure que les fichiers créés appartiennent à l'utilisateur et au groupe actuels de l'hôte.

## But

Le but de cette image est de simplifier la création d'un projet Sulu en automatisant le processus et en évitant les erreurs de dépendances. Cette image garantit également que les fichiers du projet appartiennent correctement à l'utilisateur de l'hôte, ce qui évite les problèmes de permissions.

## Utilisation

Pour créer un nouveau projet Sulu en utilisant cette image Docker, exécutez la commande suivante :

```sh
docker run -it --rm -v $(pwd):/app -e UID=$(id -u) -e GID=$(id -g) duffman033/sulu-create-project
```

Cette commande :
1. Lance un conteneur en mode interactif (`-it`).
2. Supprime le conteneur après son exécution (`--rm`).
3. Monte le répertoire courant de l'hôte dans `/app` du conteneur (`-v $(pwd):/app`).
4. Passe les UID et GID actuels en tant que variables d'environnement (`-e UID=$(id -u) -e GID=$(id -g)`).
5. Utilise l'image Docker `duffman033/sulu-create-project` pour créer le projet Sulu.

Si vous souhaitez spécifier un nom de projet différent, ajoutez simplement le nom à la fin de la commande :

```sh
docker run -it --rm -v $(pwd):/app -e UID=$(id -u) -e GID=$(id -g) duffman033/sulu-create-project mon-nouveau-projet
```

## Détails Techniques

### Dockerfile

Le Dockerfile de cette image inclut les étapes suivantes :
1. Utilisation de l'image officielle `php:8.0-cli` comme base.
2. Installation des extensions PHP nécessaires (GD, intl, etc.).
3. Installation de Composer.
4. Augmentation de la limite de mémoire PHP.
5. Définition d'un script d'entrée pour créer le projet Sulu et ajuster les permissions des fichiers.

### Script `entrypoint.sh`

Le script `entrypoint.sh` exécute la commande `composer create-project` et ajuste les permissions des fichiers créés :

```sh
#!/bin/sh

# Vérifier si le nom du projet est passé en argument
PROJECT_NAME=${1:-my-sulu-project}

# Créer le projet Sulu
composer create-project sulu/skeleton $PROJECT_NAME

# Changer les permissions du projet créé pour l'utilisateur actuel
chown -R $UID:$GID $PROJECT_NAME
```
