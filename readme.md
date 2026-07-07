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

## 🎮 Setting up OVHcloud Game Panel (Containerized Setup)

To spin up the OVHcloud Game Panel with rootless Podman/Docker using our custom compose setup (fully containerized and routed through Nginx proxy):

1. **Deploy the Panel:**
   ```bash
   podman-compose up -d --build
   ```
   *(This builds the all-in-one Ubuntu container including React frontend, Node.js backend, and the local Nginx proxy directly from the root context).*

2. **Access the Web Interface:**
   - The panel UI is mapped to host port `8095` (or routed via Cloudflare Tunnel targeting `ovh-proxy:80`).
   - Use the credentials defined in your environment variables to log in (defaults: Username `admin`, Password `adminpass123`).

3. **Deploying Game Servers:**
   - Click "Deploy Server" from the modern dashboard.
   - Choose Minecraft, Counter-Strike 2, Hytale, or run any custom LinuxGSM / external Docker image directly from the UI.
   - Files are stored in `game-panel/servers` on the host, making it super easy to edit configs or add plugins!

## 😱 Fixing Podman Socket Access in OVH Panel

Since the panel orchestrates games via Docker/Podman container lifecycle, it requires socket access.
- Ensure your `.env` contains the correct host path:
  `PODMAN_SOCK_PATH=/run/user/1000/podman/podman.sock`
- If the panel backend logs show socket communication errors, verify the socket file permissions on the host:
  ```bash
  ls -la /run/user/1000/podman/podman.sock
  ```

## 📅 Roadmap (Coming Soon!)

I'm still working on making this suite even better. Stay tuned for:

- **📧 Mailcow** (For your own mail server)
- **🔗 LinkStack** (A beautiful landing page for your links)

**Happy hosting!** If you hit a snag, just breathe and try the permission fix. You've got this! ✨
