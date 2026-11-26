FROM python:3.12-alpine
RUN apk upgrade --no-cache
WORKDIR /app
RUN adduser -D appuser
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    pip uninstall -y pip setuptools
COPY --chown=appuser:appuser main.py .
USER appuser
EXPOSE 4000
HEALTHCHECK CMD wget -qO- http://localhost:4000/ || exit 1
CMD ["python", "main.py"]
