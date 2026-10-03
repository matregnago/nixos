{ config, lib, ... }:

let
  version = "0.16.2";
  frontendUrl = "http://192.168.1.38:3000";

  backendBase = {
    image = "ghcr.io/securo-finance/securo-backend:${version}";
    environment = {
      DATABASE_URL = "postgresql+asyncpg://postgres:postgres@securo-db:5432/securo";
      REDIS_URL = "redis://securo-redis:6379/0";
      FRONTEND_URL = frontendUrl;
      TRUSTED_PROXY_HOPS = "1";
      TZ = config.time.timeZone;
      STORAGE_LOCAL_PATH = "/app/data/attachments";
      AGENTS_KNOWLEDGE_STORAGE_PATH = "/app/data/agent_knowledge";
    };
    volumes = [
      "/var/lib/secrets/securo:/run/secrets:ro"
      "/var/lib/securo/attachments:/app/data/attachments"
      "/var/lib/securo/agent_knowledge:/app/data/agent_knowledge"
    ];
    dependsOn = [
      "securo-db"
      "securo-redis"
    ];
  };

  containers = {
    securo-db = {
      image = "docker.io/pgvector/pgvector:pg16";
      environment = {
        POSTGRES_USER = "postgres";
        POSTGRES_PASSWORD = "postgres";
        POSTGRES_DB = "securo";
      };
      volumes = [ "/var/lib/securo/postgres:/var/lib/postgresql/data" ];
    };

    securo-redis = {
      image = "docker.io/library/redis:8-alpine";
    };

    securo-backend = backendBase // {
      cmd = [
        "sh"
        "-c"
        "alembic upgrade head && uvicorn app.main:app --host 0.0.0.0 --port 8000"
      ];
    };

    securo-worker = backendBase // {
      cmd = [
        "celery"
        "-A"
        "app.worker"
        "worker"
        "--loglevel=info"
        "--concurrency=2"
      ];
    };

    securo-beat = backendBase // {
      cmd = [
        "celery"
        "-A"
        "app.worker"
        "beat"
        "--loglevel=info"
      ];
    };

    securo-frontend = {
      image = "ghcr.io/securo-finance/securo-frontend:${version}";
      environment.BACKEND_URL = "http://securo-backend:8000";
      ports = [ "3000:8080" ];
      dependsOn = [ "securo-backend" ];
    };
  };
in
{
  virtualisation.oci-containers.containers = containers;

  virtualisation.podman.defaultNetwork.settings.dns_enabled = true;

  systemd.services = lib.mapAttrs' (
    name: _: lib.nameValuePair "podman-${name}" { serviceConfig.RestartSec = "5s"; }
  ) containers;

  systemd.tmpfiles.rules = [
    "d /var/lib/securo 0700 root root -"
    "d /var/lib/securo/postgres 0700 - - -"
    "d /var/lib/securo/attachments 0700 root root -"
    "d /var/lib/securo/agent_knowledge 0700 root root -"
  ];
}
