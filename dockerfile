FROM quay.io/keycloak/keycloak:latest

# Copy the realm.json file into the image
COPY realm.json /opt/keycloak/data/import/
COPY dropdown.ftl /opt/keycloak/themes

# Set the command to start Keycloak and import the realm
CMD ["start", "--import-realm"]