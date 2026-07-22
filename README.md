# Melina: Automated Kernel Fallback Shield for Arch Linux

<div align="center">
  <img src="https://raw.githubusercontent.com/sluiys/Melina/refs/heads/main/melina.jpg" width="670" alt="Melina">
</div>

Melina is a zero-configuration, automated fallback shield for Arch Linux systems using `systemd-boot`. It intercepts `pacman` kernel and system transactions, creating an isolated, bootable safety net before any destructive writes occur on your disk.

If a system crash, power outage, or fatal error occurs during a kernel update, your primary boot entries will corrupt. Melina ensures you always have a pristine, untouched `Arch Linux {Melina}` entry waiting in your boot menu to instantly recover your machine.

## Architecture

Melina is designed with infrastructure-as-code principles and operates autonomously:

*   **Dynamic Detection:** Automatically detects your boot architecture, fully supporting both **Standard** (discrete `vmlinuz` + `initramfs`) and **UKI** (Unified Kernel Image) deployments.
*   **ALPM Hook Integration:** Uses pacman `PreTransaction` hooks. The backup occurs *before* pacman extracts the new kernel, guaranteeing the backup is made from a known-working state.
*   **Idempotent Execution:** Reads storage capacity on the EFI System Partition (ESP) and aborts operations safely if space is insufficient.

## Installation

Run the following bootstrap command to fetch and register the CLI globally on your system.

```bash
curl -sSL https://raw.githubusercontent.com/sluiys/melina/main/install.sh | sudo bash
```
After registering the command, initialize the infrastructure:
```bash
sudo melina init
```

## Usage and CLI Commands

The tool is entirely managed via the melina CLI, which requires administrative privileges (sudo).

* "sudo melina init" --- 
  Installs the bash engine, configures the pacman ALPM hooks, and triggers the first backup. Your system is now shielded.

* "sudo melina remove" --- 
  Completely purges the tool from your system. It removes all isolated backup files, .conf entries, hooks, and executables, leaving the system in its original state.

* "sudo melina restore" --- 
  The emergency recovery protocol. Use this strictly when your primary boot fails and you have booted into the {Melina} fallback entry. It rebuilds your primary boot binaries by delegating a clean installation to pacman.

## Emergency Recovery Protocol

If your system crashes during an update and your primary Arch Linux boot option disappears or fails to boot:

  * Reboot your machine.

  * In the systemd-boot menu, select Arch Linux {Melina}.

  * Once booted into the operational system, open your terminal.

    Execute the recovery command:
    ```bash
    sudo melina restore
    ```
    The CLI will temporarily disarm the safety hook, query the ALPM database for your core packages (e.g., linux, systemd, amd-ucode, mkinitcpio), force a clean pacman reinstallation to fix the broken binaries, and rearm the shield automatically.

Requirements

    Arch Linux (or Arch-based distributions)

    systemd-boot as the active bootloader

    Sufficient space on the EFI System Partition to duplicate your kernel/UKI files.
