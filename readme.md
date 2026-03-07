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

* **Delete** the existing (broken) directories first.
* **Recreate** the necessary folders:

```bash
mkdir mm_data mm_logs mm_config mm_plugins mm_client_plugins mm_bleve_indexes
```

* **Apply** the correct ownership so Mattermost can access them:

```bash
podman unshare chown -R 2000:2000 mm_*
```

After running these, just restart your containers and you're good to go! 🌈

## 📅 Roadmap (Coming Soon!)

I'm still working on making this suite even better. Stay tuned for:

* **📧 Mailcow** (For your own mail server)
* **🔗 LinkStack** (A beautiful landing page for your links)

**Happy hosting!** If you hit a snag, just breathe and try the permission fix. You've got this! ✨
