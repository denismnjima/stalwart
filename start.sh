#!/bin/bash

# Create the config directory if it doesn't exist
mkdir -p /etc/stalwart

# Generate the config.json file dynamically using Railway's environment variables
# Stalwart expects the file to directly be the DataStore object.
cat <<EOF > /etc/stalwart/config.json
{
  "@type": "PostgreSql",
  "host": "${PGHOST}",
  "port": ${PGPORT:-5432},
  "database": "${PGDATABASE}",
  "authUsername": "${PGUSER}",
  "authSecret": {
    "@type": "EnvironmentVariable",
    "variableName": "PGPASSWORD"
  }
}
EOF

# Start the Stalwart mail server using the generated config
exec /usr/local/bin/stalwart --config /etc/stalwart/config.json
