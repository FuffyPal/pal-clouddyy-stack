#!/bin/bash

# Start Nginx in background
nginx

# Start Backend in foreground
cd /app/backend
exec node dist/index.js
