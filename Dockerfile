# Dockerfile - Ubuntu Desktop LXDE avec VNC pour Railway
FROM dorowu/ubuntu-desktop-lxde-vnc:latest

# Métadonnées
LABEL maintainer="votre-email@example.com"
LABEL description="Ubuntu Desktop LXDE accessible via navigateur (noVNC) - Railway ready"

# Variables d'environnement
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV RESOLUTION=1280x720x24
ENV VNC_PASSWORD=

# ⚠️ La directive VOLUME est SUPPRIMÉE car Railway la refuse
# VOLUME ["/root/Desktop"]  <-- Ne pas remettre

USER root

# Mise à jour et installation d'outils supplémentaires
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    nano \
    vim \
    net-tools \
    iputils-ping \
    firefox \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Exposer le port utilisé par Railway
# Railway injecte automatiquement la variable $PORT
EXPOSE 80

# Le script d'entrée officiel de l'image de base gère :
# - Le lancement du serveur VNC
# - Le proxy noVNC (port 80)
# - Le démarrage de LXDE
# Pas besoin de CMD custom
