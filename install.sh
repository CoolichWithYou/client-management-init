
sudo docker compose up --build -d

TOKEN=$(grep '^TOKEN=' .env | cut -d '=' -f2)
POSTGRES_PASSWORD=$(grep '^POSTGRES_PASSWORD=' .env | cut -d '=' -f2)
POSTGRES_USER=$(grep '^POSTGRES_USER=' .env | cut -d '=' -f2)
ROOT_USERNAME=$(grep '^ROOT_USERNAME=' .env | cut -d '=' -f2)
ROOT_PASSWORD=$(grep '^ROOT_PASSWORD=' .env | cut -d '=' -f2)
ADMIN_PASSWORD=$(grep '^ADMIN_PASSWORD=' .env | cut -d '=' -f2)

pip3 install frappe-bench
bench init frappe-bench
cd frappe-bench/

bench get-app client_management https://github.com/CoolichWithYou/frappe-client-managment

bench new-site clients.localhost --db-type postgres --db-name frappe_clients --db-user $POSTGRES_USER --db-password $POSTGRES_PASSWORD --db-root-username  $ROOT_USERNAME --db-root-password $ROOT_PASSWORD --admin-password $ADMIN_PASSWORD

bench pip install -r apps/client_management/requirements.txt
bench --site clients.localhost install-app client_management
bench --site clients.localhost set-config token "$TOKEN"