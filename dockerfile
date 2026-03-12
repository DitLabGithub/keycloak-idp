FROM quay.io/keycloak/keycloak:24.0.5

# Copy the realm.json file into the image
COPY data-import/ /opt/keycloak/data/import/
COPY themes /opt/keycloak/themes

# Set the command to start Keycloak and import the realm
CMD ["start", "--import-realm", "--features=passkeys"]