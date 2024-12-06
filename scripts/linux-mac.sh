# Check if the script is run as sudo (needed for modifying the hosts file)
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root (use sudo)."
  exit 1
fi

# Define the custom domain
CUSTOM_DOMAIN="dashboard.local"
LOCAL_IP="127.0.0.1"

# Modify the /etc/hosts file to map custom domain to localhost
echo "Adding $CUSTOM_DOMAIN to /etc/hosts"
echo "$LOCAL_IP $CUSTOM_DOMAIN" | sudo tee -a /etc/hosts > /dev/null

# Check if the domain was successfully added
if grep -q "$CUSTOM_DOMAIN" /etc/hosts; then
  echo "Successfully added $CUSTOM_DOMAIN to /etc/hosts."
else
  echo "Failed to add $CUSTOM_DOMAIN to /etc/hosts."
  exit 1
fi

# Start the Next.js development server
echo "Starting Next.js development server..."
npm run dev