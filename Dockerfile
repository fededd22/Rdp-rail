# Dockerfile - Ubuntu Desktop LXDE avec VNC (Web + Client VNC)
FROM dorowu/ubuntu-desktop-lxde-vnc:latest

# Métadonnées
LABEL maintainer="votre-email@example.com"
LABEL description="Ubuntu Desktop LXDE accessible via navigateur (noVNC) et client VNC"

# Variables d'environnement
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV RESOLUTION=1280x720x24
ENV VNC_PASSWORD=

# Mise à jour et installation d'outils supplémentaires
USER root
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

# Exposer les ports
# 80   -> noVNC (accès navigateur via http://localhost:6080)
# 5900 -> Client VNC classique (VNC Viewer, Remmina...)
EXPOSE 80 5900

# Point de montage (optionnel pour persistance)
VOLUME ["/root/Desktop"]

# Le script d'entrée officiel gère le lancement de VNC + noVNC + LXDE
# Pas besoin de CMD custom, on garde celui de l'image de base
