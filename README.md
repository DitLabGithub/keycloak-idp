## Keycloak IDP

To deploy this stack you will need to have the secrets in place on the machine
echo "your_postgres_username" | docker secret create postgres_user -
echo "your_postgres_password" | docker secret create postgres_password -
echo "your_keycloak_db_username" | docker secret create keycloak_db_user -
echo "your_keycloak_db_password" | docker secret create keycloak_db_pass -
echo "your_keycloak_admin_password" | docker secret create keycloak_admin_password -

# You'll need to provide the actual certificate and key files for these:

docker secret create keycloak_https_certificate /path/to/your/certificate.pem
docker secret create keycloak_https_certificate_key /path/to/your/certificate_key.pem
