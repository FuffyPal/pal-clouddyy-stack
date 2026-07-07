# 🌟 My Awesome Self-Hosted Suite 🌟

Hello! Ready to deploy your own cloud, communication hub, and secure tunnel? This project bundles **Nextcloud**, **Mattermost**, and **Cloudflare Tunnel** into one cozy `docker-compose` setup. 🚀

---

## 🚀 Quick Start

If the stars align, you only need one command to get started:

```bash
docker-compose up -d
```

## 📝 Important: The .env File

To keep everything running smoothly, **you must create a .env file**. Without it, the configuration won't know where to go, and the setup might get a little grumpy! 🌸

## 🛠 Troubleshooting (Known Issues)

### 🌐 Ağ Bağlantı Hataları (Network Errors)

Eğer kurulum sırasında ağların bulunamadığına dair bir hata alırsanız, bu ağları manuel olarak oluşturmanız gerekir:

**Podman kullanıyorsanız:**

```bash
podman network create tailscale_net
podman network create cloud_public
podman network create cloud_internal
```

**Docker kullanıyorsanız:**

```bash
docker network create tailscale_net
docker network create cloud_public
docker network create cloud_internal
```

---

Sometimes **Mattermost** can be a bit sensitive regarding folder permissions. If you see "Permission Denied" errors or if Mattermost refuses to start while others work fine, don't worry! Here is the magic fix:

## 😱 Fixing Mattermost Permission Errors

If you run into permission issues, follow these steps to reset the environment properly:

- **Delete** the existing (broken) directories first.
- **Recreate** the necessary folders:

```bash
mkdir mm_data mm_logs mm_config mm_plugins mm_client_plugins mm_bleve_indexes
```

- **Apply** the correct ownership so Mattermost can access them:

```bash
podman unshare chown -R 2000:2000 mm_*
```

After running these, just restart your containers and you're good to go! 🌈

## 😱 Fixing SCP Secret Laboratory Permission Errors

```bash
chmod -R 777 ./scp_plugins_labapi ./scp_config
```

**or**

```bash
podman unshare chown -R 777 ./scp_plugins_labapi ./scp_config
```

## 🎮 Setting up Pelican Panel & Wings (Game Server Panel)

To get Pelican Panel and Wings up and running with Podman/Docker:

1. **Start Panel & Database:**
   ```bash
   podman-compose -f pelican/docker-compose.yml up -d pelican-db pelican-app
   ```
2. **Run DB Migrations:**
   ```bash
   podman exec -it pelican-app php artisan migrate --seed --force
   ```
3. **Create your Admin User:**
   ```bash
   podman exec -it pelican-app php artisan p:user:make
   ```
4. **Setup Node & get Config:**
   - Log into the panel interface.
   - Create a Location, then add a Node.
   - For internal communication, set the node's **FQDN/Address** to `pelican-wings`.
   - Copy the generated `config.yml` configuration.
5. **Save Configuration & Start Wings:**
   - Create a file at `pelican/wings/config.yml` on the host and paste the configuration.
   - Start the Wings container:
     ```bash
     podman-compose -f pelican/docker-compose.yml up -d pelican-wings
     ```

## 😱 Fixing Pelican Database Connection Errors (Connection Refused)

If you run migrations right after starting the database and get a `Connection refused` error, don't panic! The MariaDB server just needs 10-15 seconds to initialize the data directory on its first run.
- Check database startup progress:
  ```bash
  podman logs pelican-db
  ```
- Wait a few seconds until the logs show `ready for connections`, then run the migration command again:
  ```bash
  podman exec -it pelican-app php artisan migrate --seed --force
  ```

## 📅 Roadmap (Coming Soon!)

I'm still working on making this suite even better. Stay tuned for:

- **📧 Mailcow** (For your own mail server)
- **🔗 LinkStack** (A beautiful landing page for your links)

**Happy hosting!** If you hit a snag, just breathe and try the permission fix. You've got this! ✨
