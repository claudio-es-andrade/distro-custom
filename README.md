 Distro-Custom IMAGENS GNU/LINUX e FreeBSD

# README

## Outubro/03/2025

#### ISOs Originais : 

- Linux Lite 7.6 (Ubuntu 24.04 LTS): Link do Brasil desatualizado.
Distro com XFCE Desktop e bastante recursos (Synaptic, Firewalld, Timeshift Backup) que facilitam a vida do usuário mais novo. A wiki, apesar do idioma ser outro, possui bons exemplos e detalhes de procedimentos.

### https://drive.google.com/file/d/1oQPFA20mwSJabGHg7-nmjNXiWl6YSvac/view?usp=drive_link


- GhostBSD MATE (Atualização Agosto/25/2025): Unix (Kernel) FreeBSD Distro que já vem com um Desktop Environment, MATE, pronto para uso.
Firewall, a maioria dos codecs multimedia instalado, Atualizador de pacotes Gráfico, tudo muito simples e prático. Documentação: https://ghostbsd-documentation-portal.readthedocs.io/en/latest/index.html

 Várias Melhorias incluindo:
 - 1 Atualização alinhada ao lançamento do FreeBSD releng/14.3;
 - 2 Auto detecção de placas AMD Radeon HD 8790M, Radeon HD 8240 Kabini, NVidia RTX 4000/5000 series;
 - 3 Adicionada WiFi firmware compatibility para FreeBSD 14.3; 
 - 4 Melhorias no gerenciamento de boot com detecçaõ de ambientes de boot antigos;
 - 5 Atualização e melhorias de traduções, incluindo Russo, Português (Brazil) e,
 mais

### https://drive.google.com/file/d/1P8aJc9LIG3RDAhFBENh57Jd8qeijUhXA/view?usp=drive_link 

# DISTRO-CUSTOM (MODIFICADA):

- BR-OS (KDE - Debian 13): Distro Linux com bastante aplicativos gráficos, como por exemplo, Blender, Inkscape, Krita e o GIMP.
Chat GPT (Prompt - AI), Web-Browsers: Firefox e LibreWolf, KDE Connect, VLC Player e OnlyOffice como Office padrão.

Adicionados: Codecs Multimedia, Compactadores e extratores gerais, Gerenciador de Pacotes Synaptic e o Gerenciador de Instalação GDebi, Firewall GUFW (UFW Gráfico), Docker, Distrobox e Firefox (143)

Repositório Debian BackPorts (Kernel mais recente, Firmwares,  entre outros).
Repositório para o Waydroid.

### https://drive.google.com/file/d/1XvlcjeJuNIq8ISBgFzNto8-48BAUv_gL/view?usp=drive_link

# ISO(s) para testar na sua máquina virtual:

- Linux Mint Debian Edition - LMDE7- Gigi (Cinnamon): Versão Beta liberada para teste com quase tudo pronto para o lançamento.

### https://mint.c3sl.ufpr.br/testing/lmde-7-cinnamon-64bit-beta.iso

- Fedora 43 Beta Test Net Install : Versão Beta pronta para testes do Fedora 43 que será lançada no final do ano.
Na minha máquina, após instalação do LXQT, a tela ficou preta. Gnome, instalação e pós: OK. Testem e informem os resultados.

### https://dl.fedoraproject.org/pub/fedora/linux/development/43/Server/x86_64/iso/Fedora-Server-netinst-x86_64-43-20250920.n.0.iso

- Linux Zorin 18 Beta: Distro que possui interface amigável pretendendo substituir o Windows e ou o Mac.
Web Apps: Microsoft Office/365, Teams, Google Docs, Adobe Photoshop e outros mais (170).

### https://zorin.com/os/download/18/core/beta/

- Ubuntu 25.10 Beta: Próximo lançamento do Ubuntu.

### https://cdimage.ubuntu.com/daily-live/current/

- Ubuntu Daily Dangerous: Teste o Ubuntu lançado diariamente com correções e aprimoramentos recém lançados e não testados ainda.

### https://cdimage.ubuntu.com/daily-dangerous/

- System76 - POP!_OS 22.04 LTS Beta: O sistema baseado no Ubuntu

### https://iso.pop-os.org/24.04/amd64/intel/19/pop-os_24.04_amd64_intel_19.iso

- System76 - POP!_OS 22.04 LTS Beta (NVidia):

### https://iso.pop-os.org/24.04/amd64/nvidia/19/pop-os_24.04_amd64_nvidia_19.iso

- System76 - Cosmic: O novo ambiente de Desktop está quase pronto. pode ser utilizado em diversas distros.

### https://system76.com/cosmic/download

- Redox OS : O Sistema Operacional totalmente feito do zero e em linguagem RUST assim como o seu Kernel.

### https://static.redox-os.org/releases/0.9.0/x86_64/redox_desktop_x86_64_2024-09-07_1225_harddrive.img.zst

- KDE LINUX BETA: Depois da criação do KDE Neon, uma nova distro atômica, baseada no Arch Linux, com o de mais novo do KDE Plasma. Versões da ISO atualizada quase diariamente.

### https://files.kde.org/kde-linux/?C=M;O=A

- GNOME OS Nightly: Distro atômica que não possui pacotes próprios e nem se baseia em pacotes de outras distros, utiliza apenas Flatpaks ou Snaps, se houver a habilitação (sudo updatectl enable snapd). Esta distro pode ser testada em hardware reais também possibilitando até configurar algumas placas da NVidia. É necessário ter o Gnome Boxes para rodar a ISO virtualmente.
As extensões que o Gnome OS oferece são:

1 - devel (Gnome SDK e outras ferramentas );

2 - debug;

3 - snapd; 

4 - apparmor e,

5 - Nvidia.

### https://os.gnome.org/download/latest/gnome_os_nightly.iso

# Arquivo de Verificação da ISO

- Linux Lite (MD5)

### https://drive.google.com/file/d/1T1rDggzS14yZIrhwFVBFQcfelrMImEFW/view?usp=drive_link

- GhostBSD (SHA256)

### https://drive.google.com/file/d/1AXSWqd75qPqMnMKzxbDBkoVG4uUBwuTW/view?usp=drive_link

- BR OS (MD5)

### https://drive.google.com/file/d/1rnbEjKUZWY64nKM6TbX8dgA3epVE2oal/view?usp=drive_link


## Maiores Informações:

- Debian Pos Install Script (Bookworm):

### https://github.com/claudio-es-andrade/distro-custom/blob/main/DebianBookwormPosInstallationScript.sh

- Debian Pos Install Script (Trixie):

### https://github.com/claudio-es-andrade/distro-custom/blob/main/DebianTrixiePosInstallationScript.sh

- Cubic:

### https://github.com/PJ-Singh-001/Cubic

- Penguins-Eggs:

### https://penguins-eggs.net/
### https://github.com/pieroproietti/penguins-eggs

- Github Debullshit Script:

### https://github.com/polkaulfield/ubuntu-debullshit
