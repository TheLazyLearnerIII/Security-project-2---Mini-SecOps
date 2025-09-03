FROM python:3.11-slim-bookworm

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Minimal OS deps (git is used by scoutsuite for some ops; ca-certs for HTTPS)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git ca-certificates bash \
    && rm -rf /var/lib/apt/lists/*

# Install Scout Suite
RUN pip install --no-cache-dir scoutsuite

# Where reports will be written (mounted from host/runner)
RUN mkdir -p /output
VOLUME ["/output"]

# Optional: copy a tiny entrypoint to write into /output with a timestamp
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Default: run a scan and drop static HTML under /output
ENTRYPOINT ["/entrypoint.sh"]
