FROM docker.io/stalwartlabs/mail-server:latest

# Switch to root temporarily to copy and configure our startup script
USER root
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Switch back to the unprivileged stalwart user for security
USER stalwart

# Use our script to dynamically generate the config and start the server
ENTRYPOINT ["/start.sh"]
