# Surface Duo 2 Custom Kernel Cloud Builder

Automated, 1-click cloud compiler for the **Microsoft Surface Duo 2** (Snapdragon 888 / SM8350) based on Microsoft's official open-source kernel tree (`surfaceduo2/11/2022.823.41`).

---

### Features Built into This Kernel
* **Native In-Kernel KernelSU:** Compiled directly into the kernel binary (`Image`). Invisible to user-space detection tools (such as Touch 'n Go AppProtect) because no standalone su manager package is required.
* **TCP BBR Congestion Control:** Replaces Qualcomm's default `cubic` algorithm with Google's `bbr` for minimal latency and sustained bandwidth on 5G and Wi-Fi 6.
* **In-Kernel WireGuard (`CONFIG_WIREGUARD=y`):** WireGuard crypto handled directly in kernel space, saving battery and CPU cycles.
* **Fixed Manifest Mirrors:** Automatically patches Qualcomm's deprecated CodeAurora (CAF) URLs to active Google/AOSP git mirrors so builds never fail with 404s.

---

### Quick Setup Instructions

#### Step 1: Create a GitHub Repository
1. Log in to [GitHub](https://github.com/) in your browser.
2. Click **New Repository** (choose either Public or Private).
3. Name it: `duo2-kernel-builder` (leave "Initialize with README" unchecked).
4. Copy your repository URL (e.g. `https://github.com/YourUsername/duo2-kernel-builder.git`).

#### Step 2: Push This Directory to Your GitHub Repository
Double-click `setup_repo.bat` in this folder, or run the following in terminal:
```cmd
cd C:\Users\MiePC\Downloads\Duo2_Kernel_Builder
git init
git add .
git commit -m "Initialize Duo 2 Kernel Builder with GitHub Actions"
git branch -M main
git remote add origin https://github.com/YourUsername/duo2-kernel-builder.git
git push -u origin main
```

#### Step 3: Trigger the Build in GitHub
1. Open your repository on GitHub in your browser.
2. Click the **Actions** tab at the top.
3. In the left sidebar, click **Build Surface Duo 2 Custom Kernel**.
4. Click the **Run workflow** button on the right:
   * **Target Defconfig:** `lahaina-gki_defconfig` (recommended)
   * **Embed KernelSU:** `true`
   * **Enable In-Kernel BBR:** `true`
   * **Enable In-Kernel WireGuard:** `true`
5. Click the green **Run workflow** button.

GitHub's cloud servers will sync Microsoft's code, compile the kernel, and package the output in ~15–20 minutes.

---

### Downloading & Testing Your New Kernel

Once the build finishes (green checkmark):
1. Click the completed workflow run.
2. Scroll down to the **Artifacts** section at the bottom.
3. Download `SurfaceDuo2-Kernel-lahaina-gki_defconfig.zip`.
4. Inside you will find:
   * `Image`: The raw compiled ARM64 Linux kernel.
   * `SurfaceDuo2-CustomKernel-AnyKernel3.zip`: Flashable kernel zip.
   * `vendor_modules.zip`: Associated kernel drivers.

#### Zero-Risk Testing Method (RAM Boot):
If you want to test the kernel temporarily before flashing:
```bash
# Repack with your existing stock boot image and boot into RAM
fastboot boot custom_boot.img
```
If the phone boots smoothly, you can flash it permanently or install via KernelSU / APatch / AnyKernel3. If anything panics, a simple power-button reboot immediately restores your stock kernel.
