#!/bin/bash

function check_if_root_is_logged(){

if [ $(whoami) = 'root' ]; then echo "Bem-Vindo Administrador"; else echo "Para executar este arquivo seja root ou utilize o comando SUDO"; exit 0; fi
# FIM DE check_if_root_is_logged()
}

function sources_list_modified(){

echo "Transformando o arquivo sources.list original em cópia"
mv /etc/apt/sources.list /etc/apt/sources.list_original_002
echo "O arquivo anterior foi transformado em cópia: nome_do_arquivo_original_00x"
echo "Adicionando MAIN CONTRIB NON-FREE NON-FREE-FIRMWARE no arquivo sources.list"
cat <<EOF >> /etc/apt/sources.list

#############################################################################################################
#                                Repositórios Oficiais - Debian 12 "Bookworm"                               #
#############################################################################################################
## Para habilitar os repos de código fonte (deb-src) e Backports basta retirar a # da linha correspondente ##
#############################################################################################################

deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
# deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
# deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
# deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware

## Debian Bookworm Backports
deb http://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
# deb-src http://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware

##############################################################################################################

EOF
echo "Fim da modificação no arquivo /etc/apt/sources.list"
echo "Recarregando a lista de repositórios e verificando pacotes a serem atualizados"
apt update && apt upgrade
echo "Modifying sources.list"
cat /etc/apt/sources.list
# FIM de sources_list_modified()
}

changing_locale(){

echo "Instalando o pacote locale"
apt install locales

echo "Alterando o idioma... "
dpkg-reconfigure locales

# FIM DE changing_locale() 
}

adding_user_to_sudo(){
echo "Instalando o comando SUDO"
apt install sudo

echo "Verifica o usuario no sistema"
#echo "cut -d: -f1 /etc/passwd | grep nome_do_usuario"
#echo "Verifica se o usuário está no Grupo SUDO"
#sudo -i -u nome_do_usuario

#echo "Adicionando usuário ao grupo sudo do sistema:"
#adduser nome_do_usuario sudo

# FIM DE adding_user_to_sudo()
}

installing_gnome_tweaks_and_extension_manager(){
echo "Instalando Gnome-Tweaks e Gnome-Shell-Extension-Manager"
apt install gnome-tweaks gnome-shell-extension-manager
# FIM DE installing_gnome_tweaks_and_extension_manager()
}

installing_intel_firmware(){
echo "Adicionando Firmware Intel"
apt install intel-microcode
echo "Para adicionar Firmware AMD"
apt install amd64-microcode

# FIM DE installing_intel_firmware()
}

installing_firewalld(){
echo "Adicionando Firewall FIREWAALLD"
apt install firewalld firewall-applet

echo "Habilitando o firewall ao reinício do sistema"
systemctl enable firewalld
systemctl start firewalld

echo "verificando o estado do firewall"
systemctl status firewalld
firewall-cmd --state

echo "Mostrando a zona padrão atual do firewall (Publica)"
firewall-cmd --get-default-zone

echo "Alterando a zona padrão atual para DROP "
firewall-cmd --set-default-zone=drop

echo "Mostrando as alterações no Firewall"
systemctl status firewalld
firewall-cmd --state
firewall-cmd --get-default-zone
firewall-cmd --list-all
# FIM DE installing_firewalld()
}

installing_firewall_ufw(){
echo "Instalando o firewall UFW e sua parte gráfica GUFW"
apt install ufw gufw

echo "Habilitando o firewall ao reinício do sistema"
systemctl enable ufw
systemctl start ufw
ufw enable

echo "verificando o estado do firewall"
systemctl status ufw
ufw status verbose
# FIM DE installing_firewall_ufw()
}

installing_yad_tasksel(){
echo "Instalando YAD e TASKSEL (Instala os Desktops)"
apt install yad tasksel

echo "Caso queira instalar outro Desktop Environment, por exemplo o MATE, tecle apt install task-mate-desktop"
echo "Caso queira instalar o KDE Plasma Desktop Environment, tecle apt install task-kde-desktop"
echo "Caso queira instalar o LXDE Desktop Environment, por exemplo, tecle apt install task-lxde-desktop"
echo "Caso queira instala o LXQT Desktop Environment, tecle apt install task-lxqt-desktop"
echo "Caso queira instala o XFCE Desktop Environment, tecle apt install task-xfce-desktop"
echo "Caso queira instala o GNOME Desktop Environment, por exemplo, tecle apt install task-gnome-desktop"
echo "Caso queira instala outro Desktop Environment, , tecle apt install tasksel"

# FIM DE installing_yad_tasksel()
}

installing_gnome(){
echo "Instalando o GNOME DESKTOP"
apt install task-gnome-desktop

# FIM DE installing_gnome()
}

installing_kde(){
echo "Instalando o KDE PLASMA"
apt install task-kde-desktop

# FIM DE installing_kde()
}

installing_xfce(){
echo "Instalando o XFCE DESKTOP"
apt install task-xfce-desktop

# FIM DE installing_xfce()
}

installing_lxqt(){
echo "Instalando o LXQT DESKTOP"
apt install task-lxqt-desktop

# FIM DE installing_lxqt()
}

installing_lxde(){
echo "Instalando o LXDE DESKTOP"
apt install task-lxde-desktop

# FIM DE installing_lxde()
}

installing_mate(){
echo "Instalando o MATE DESKTOP"
apt install task-mate-desktop

# FIM DE installing_mate()
}

installing_flatpak(){
echo "Habilitando pacotes FLATPAK do Flathub ao sistema"

apt install flatpak
apt install gnome-software-plugin-flatpak
echo "Caso esteja no KDE-PLASMA utilize o comando sudo apt install plasma-discover-backend-flatpak"

echo "Adicionando o FlatHub.org ao sistema"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# FIM DE installing_flatpak()
}

installing_codecs(){
echo "Instalando Codecs diversos"
apt install faad ffmpeg gstreamer1.0-fdkaac gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly lame libavcodec-extra libavcodec-extra* libavdevice* libgstreamer1.0-0 sox twolame vorbis-tools

echo "Codecs para o MPlayer, Xine"
cd /tmp && wget http://www.deb-multimedia.org/pool/non-free/w/w64codecs/w64codecs_20071007-dmo2_amd64.deb && apt install ./w64codecs_20071007-dmo2_amd64.deb && cd $HOME

echo "Codecs para DVD criptografado"
apt install libdvd-pkg
echo "Comando para continuar a instalação configuração do Codec de DVD"
dpkg-reconfigure libdvd-pkg


# FIM DE installing_codecs()
}

installing_extractors(){
echo "Extração e Compactação de arquivos"
apt install arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip

# FIM DE installing_extractors()
}

installing_fonts(){
echo "Instalando fontes da Microsoft"
apt install cabextract curl fontconfig xfonts-utils
apt install ttf-mscorefonts-installer

# FIM DE installing_fonts()
}

installing_audacious(){
echo "Instalando o player multimedia Audacious"
apt install audacious

# FIM DE installing_audacious()
}

installing_vlc(){
echo "Instalando o player multimedia VLC"
apt install vlc

# FIM DE installing_vlc()
}

installing_smplayer(){
echo "Instalando o player multimedia SMPlayer"
apt install smplayer

# FIM DE installing_smplayer()
}

installing_kodi(){
echo "Instalando a central multimidia Kodi"
apt install kodi

# FIM DE installing_kodi()
}

installing_spotify(){
echo "Instalando o serviçode streaming Spotify"

echo "Importando a chave de assinatura GPG"
cd /tmp && wget -qO- https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | gpg --dearmor | sudo dd of=/etc/apt/keyrings/spotify.gpg && cd $HOME

echo "Adicionando o repositório do aplicativo"
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

echo "Atualizando a lista de repositórios do Sistema e instalando o Spotify"
apt update && apt install spotify-client

# FIM DE installing_spotify()
}

installing_audacity(){
echo "Instalando o editor de audio Audacity"
apt install audacity
# FIM DE installing_audacity()
}

installing_blender(){
echo "Instalando o Blender"
apt install blender
# FIM DE installing_blender()
}

installing_gimp(){
echo "Instalando o GIMP"
apt install gimp
# FIM DE installing_gimp()
}

installing_handbrake(){
echo "Instalando o Handbrake"
apt install handbrake
# FIM DE installing_handbrake()
}

installing_inkscape(){
echo "Instalando o Inkscape"
apt install inkscape
# FIM DE installing_inkscape()
}

installing_kdenlive(){
echo "Instalando o Kdenlive"
apt install kdenlive
# FIM DE installing_kdenlive()
}

installing_krita(){
echo "Instalando o Krita"
apt install krita
# FIM DE installing_krita()
}

installing_obs_studio(){
echo "Instalando o OBS Studio"
apt install obs-studio
# FIM DE installing_obs()
}

installing_openshot(){
echo "Instalando o editor de áudio e vídeo OpenShot"
apt install openshot-qt
# FIM DE installing_openshot()
}

installing_discord(){
echo "Instalando o Discord (Flatpak)"
flatpak install flathub com.discordapp.Discord
# FIM DE installing_discord()
}

installing_telegram(){
echo "Instalando o Telegram"
apt install telegram-desktop
# FIM DE installing_telegram()
}

installing_thunderbird(){
echo "Instalando o Thunderbird"
apt install thunderbird thunderbird-l10n-pt-br
# FIM DE installing_telegram()
}

installing_zoom(){
echo "Instalando o Zoom (Flatpak)"
flatpak install flathub us.zoom.Zoom
# FIM DE installing_zoom()
}

installing_teams(){
echo "Importando a chave GPG"
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

echo "Adicionando o Repositório"
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'

echo "Atualizando a lista dos repositórios"
apt update

echo "Instalando o Microsoft Teams"
apt install teams

# FIM DE installing_teams()
}

installing_gdebi_synaptic(){
echo "Instalando GDebi e Synaptic"
apt install gdebi synaptic

# FIM DE installing_gdebi_synaptic()
}

installing_gparted(){
echo "Instalando Gparted"
apt install gparted

# FIM DE installing_gparted()
}

preparing_to_install_web_browsers(){
echo "Adicionando pacotes necessários para a instalação"
apt install software-properties-common apt-transport-https ca-certificates curl wget 
echo "Agora, vamos adicionar os repositórios dos WebBrowsers Chrome, Opera e Vivaldi SEM a instalação dos mesmos"
# FIM DE preparing_to_install_web_browsers()
}

installing_chrome_repo(){
echo "Adicionando o repositório do Google Chrome"
echo "Adicionando a chave do repositório"
curl -fSsL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg >> /dev/null
echo "Adicionando o repositório"
echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list
echo "Atualizando o repositório"
apt update

#echo "Segue o arquivo repositório para conferir"
#cat /etc/apt/sources.list.d/google-chrome.list

#echo "Para instalar o Chrome basta digitar apt install google-chrome-stable -y"
#echo "Navegador pronto para ser instalado"
echo "Instalando o navegador CHROME"
apt install google-chrome-stable
#echo "Navegador instalado e pronto para o uso"
# FIM DE installing_chrome_repo()
}

installing_opera_repo(){
echo "Adicionando o repositório do Opera"
echo "Adicionando a chave do repositório"
curl -fSsL https://deb.opera.com/archive.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/opera.gpg >> /dev/null
echo "Adicionando o repositório"
echo deb [arch=amd64 signed-by=/usr/share/keyrings/opera.gpg] http://deb.opera.com/opera-stable/ stable main | sudo tee /etc/apt/sources.list.d/opera.list
echo "Atualizando o repositório"
apt update

echo "Segue o arquivo repositório para conferir "
cat /etc/apt/sources.list.d/opera.list

#echo "Para instalar o Opera basta digitar apt install opera-stable -y"
#echo "Navegador pronto para ser instalado"
echo "Instalando o navegador OPERA"
apt install opera-stable 
#echo "Navegador instalado e pronto para o uso"
# FIM DE installing_opera_repo()
}

installing_vivaldi_repo(){
echo "Adicionando o repositório do Vivaldi"
echo "Adicionando a chave do repositório"
cd /tmp && wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo dd of=/usr/share/keyrings/vivaldi-browser.gpg && cd $HOME

echo "Adicionando o repositório"
echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" | sudo dd of=/etc/apt/sources.list.d/vivaldi.list

echo "Atualizando o repositório"
apt update

#echo "Segue o arquivo repositório para conferir "
#cat /etc/apt/sources.list.d/vivaldi.list

#echo "Para instalar o Opera basta digitar apt install vivaldi-stable -y "
#echo "Navegador pronto para ser instalado"
echo "Instalando o Navegador VIVALDI... "
apt install vivaldi-stable
#echo "Navegador instalado e pronto para o uso"
# FIM DE installing_vivaldi_repo
}

installing_edge_repo(){
echo "Adicionando o repositório do navegador Microsoft Edge"
echo "Adicionando a chave do repositório"
cd /tmp && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && cd $HOME

echo "Adicionando o repositório"
echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge/ stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list

echo "Atualizando o repositório"
apt update

#echo "Segue o arquivo repositório para conferir "
#cat /etc/apt/sources.list.d/microsoft-edge.list

#echo "Para instalar o Opera basta digitar apt install microsoft-edge-stable -y "
#echo "Navegador pronto para ser instalado"
echo "Instalando o Navegador MICROSOFT EDGE... "
apt update && apt install microsoft-edge-stable
#echo "Navegador instalado e pronto para o uso"
# FIM DE installing_edge_repo
}

installing_chromium_repo(){
echo "Instalando o navegador CHROMIUM..."
apt install chromium
echo "Navegador instalado e pronto para o uso"
# FIM DE installing_chromium_repo()
}

installing_librewolf(){
echo "Instalando o LibreWolf (Flatpak)"
flatpak install flathub io.gitlab.librewolf-community

# FIM DE installing_librewolf()
}

installing_zen(){
echo "Instalando o Zen Browser (Flatpak)"
flatpak install flathub app.zen_browser.zen

# FIM DE installing_zen()
}


installing_rust(){
echo "Instalando o RUST através do script do site"
echo "Para maiores informações, visite https://www.rust-lang.org/learn/get-started "
echo "Não é necessário ser o administrador para executar este script"
echo " curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  "
echo "Caso queira instalar como o administrador do sistema, desbloqueie o comando na função do script"
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# FIM DE installing_rust()
}

installing_python(){
echo "Instalando o através do próprio repositório do DEBIAN. Versão: 3.11.2-1+bi"
echo "Instalando a IDE THONNY"
apt install python3 python3-dev python3-pip python3-venv libpython3-dev thonny
# FIM DE installing_python()
}

installing_java(){
echo "Instalando através do script do site SDKMAN: (https://sdkman.io) "
echo "Não é necessário ser administrador para instalar através do SDKMAN"
echo "Copie o comando abaixo e execute como usuário normalmente"
echo " curl -s "https://get.sdkman.io" | bash "
echo "Execute no final da instalação o seguinte comando:"
echo ' source "$HOME/.sdkman/bin/sdkman-init.sh" '
echo "Descomente as linhas na função para instalar através do próprio repositório do Debian"
#echo "Instalando o através do próprio repositório do DEBIAN. Versão: 17 LTS"
#apt install openjdk-17-jdk
# FIM DE installing_java()
}

installing_php(){
echo "Instalando o PHP com o APACHE 2"
apt install php-common libapache2-mod-php php-cli php-fpm php-mysql php-curl php-gd apache2
echo "Caso queira instalar os pacotes adicionais vá para o site https://www.php.net"
# FIM DE PHP
}

installing_build_essential(){
echo "Instalando o pacote Build Essential (Verificando) (C, C++), Bibliotecas adicionais, Autotools e CMake"
apt install build-essential ccache

echo "Instalando Bibliotecas Adicionais"
apt install libssl-dev zlib1g-dev libncurses*-dev libncursesw*-dev libreadline-dev libsqlite*-dev libgdbm-dev libdb*-dev libbz*-dev

echo "Instalando o Autotools"
apt install autoconf automake libtool

echo "Instalando o CMake"
apt install cmake

# FIM DE installing_build_essential()
}

installing_nodejs_npm(){
apt install nodejs npm

# FIM DE installing_nodejs_npm()
}

installing_mariadb(){
echo "Importando as chaves PGP"

apt-get install apt-transport-https curl
mkdir -p /etc/apt/keyrings
curl -o /etc/apt/keyrings/mariadb-keyring.pgp 'https://mariadb.org/mariadb_release_signing_key.pgp'

cat <<FIM >> /etc/apt/sources.list.d/mariadb.sources
# MariaDB 11.8 repository list - created 2025-05-22 22:10 UTC
# https://mariadb.org/download/
X-Repolib-Name: MariaDB
Types: deb
# deb.mariadb.org is a dynamic mirror if your preferred mirror goes offline. See https://mariadb.org/mirrorbits/ for details.
# URIs: https://deb.mariadb.org/11.rc/debian
URIs: https://espejito.fder.edu.uy/mariadb/repo/11.8/debian
Suites: bookworm
Components: main
Signed-By: /etc/apt/keyrings/mariadb-keyring.pgp
FIM

echo "Atualizando a lista de repositórios e instalando o pacote"
apt update
apt install mariadb-server

#echo "Instalando o MARIADB pelo repositório Debian"
#apt install mariadb-server

# FIM DE installing_mariadb()
}

installing_postgresql(){
#echo "Instalando o Postgresql pelo repositório Debian"
#apt install postgresql postgresql-contrib

echo "Instalando dependências e Importando a chave ASC"
apt install curl ca-certificates
install -d /usr/share/postgresql-common/pgdg
curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc

echo "Adicionando o repositório"
sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $VERSION_CODENAME-pgdg main' > /etc/apt/sources.list.d/pgdg.list"

echo "Atualizando a lista de repositórios e instalando o pacote"
apt update
apt install postgresql


# FIM DE installing_postgresql()
}

installing_git_subversion_mercurial(){
echo "Instalando o GIT"
apt install git
echo "Instalando o Subversion"
apt install subversion
echo "Instalando o Mercurial"
apt install mercurial

echo "Verificando as Instalações:"
echo "GIT"
git --version
echo "SUBVERSION"
svn --version
echo "MERCURIAL"
hg --version

# FIM DE installing_git_subversion_mercurial()
}

installing_docker(){
echo "Instalando pacotes necessários paa instalar o Docker"
apt install apt-transport-https ca-certificates curl gnupg lsb-release

echo "Instalando a Chave GPG"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "Instalando o repositório"
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Atualizando a lista de repositórios"
apt update
echo "Instalando de fato o Docker"
apt install docker-ce docker-ce-cli containerd.io

echo "Instalando o Docker-Compose"
apt install docker-compose-plugin

echo "Verificando a instalação"
docker --version
docker compose version

# FIM DE installing_docker()
}

installing_code(){
echo "Antes de instalar o VSCode é necessário instalar apt-transport-https"
apt install apt-transport-https

echo "Importando a chave GPG"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/

echo "Adicionando o repositório"
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt update
apt install code

# FIM DE installing_code()
}

installing_sublime(){
echo "Antes de instalar o Sublime é necessário instalar apt-transport-https"
apt install apt-transport-https

echo "Importando a chave GPG"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

echo "Adicionando o repositório"
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

echo "Atualizando a lista de repositórios"
sudo apt update

echo "Instalando o Sublime"
sudo apt install sublime-text

# FIM DE installing_sublime()
}

installing_atom(){
echo "Antes de instalar o Atom é necessário instalar apt-transport-https"
apt install apt-transport-https

echo "Importando a chave GPG"
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -

echo "Adicionando o repositório"
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'

echo "Atualizando a lista de repositórios"
sudo apt update

echo "Instalando o Atom"
sudo apt install atom

# FIM DE installing_atom()
}

installing_vim(){
echo "Instalando do VIM"
apt install vim

echo "Confirmando a sua versão"
vim --version

# FIM DE installing_vim()
}

installing_neo_vim(){
echo "Instalando o NEOVIM"
apt install neovim

# FIM DE installing_neo_vim()
}

installing_dbeaver(){
echo "Intslando o DBeaver Community (Flatpak)"
flatpak install flathub io.dbeaver.DBeaverCommunity

# FIM DE installing_dbeaver()
}

installing_netbeans(){
echo "Instalando o Apache Netbeans (Flatpak)"
flatpak install flathub org.apache.netbeans

# FIM DE installing_netbeans()
}

installing_bluej(){
echo "Instalando a IDE BlueJ (Flatpak)"
flatpak install flathub org.bluej.BlueJ

#echo "Baixando o arquivo do site oficial"
#wget https://github.com/k-pet-group/BlueJ-Greenfoot/releases/download/BLUEJ-RELEASE-5.4.2/BlueJ-linux-x64-5.4.2.deb
# apt install ./BLUEJ-RELEASE-5.4.2/BlueJ-linux-x64-5.4.2.deb 

# FIM DE installing_bluej()
}

installing_eclipse(){
echo "Instalando Eclipse (Flatpak)"
flatpak install flathub org.eclipse.Java

#echo "Baixando o arquivo pelo site oficial"
#wget https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2025-03/R/eclipse-jee-2025-03-R-linux-gtk-x86_64.tar.gz  

#tar -xvf eclipse-jee-2025-03-R-linux-gtk-x86_64.tar.gz; cd eclipse-jee-2025-03-R-linux-gtk-x86_64/eclipse/ ; bash eclipse

# FIM DE installing_eclipse()
}

installing_intellij(){
echo "Instalando o Jet Brains IntelliJ Idea Community Edition (Flatpak)"
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community

#echo "Baixando o arquivo pelo site oficial"
#wget https://download.jetbrains.com/idea/ideaIC-2025.1.1.1-aarch64.tar.gz?_gl=1*1smgpym*_gcl_au*NDYwOTE3NTE3LjE3NDgwMDM5NzY.*FPAU*NDYwOTE3NTE3LjE3NDgwMDM5NzY.*_ga*MTY4MTI3Mjg5My4xNzQ4MDAzOTgw*_ga_9J976DJZ68*czE3NDgwMDM5NzYkbzEkZzEkdDE3NDgwMDQyMTgkajU4JGwwJGgwJGRzVFExTzhZbmR1UlJUb1VRb2tIWTJqRHFwdUJ6ZHhyZDdR

#tar -xvf ideaIC-2025.1.1.1-aarch64.tar.gz; cd /home/claudio/Downloads/ideaIC-2025.1.1.1/idea-IC-251.25410.129/bin/ ; bash idea


# FIM DE installing_intellij()
}


installing_virtualbox(){
echo "Importando a Chave GPG"
wget -O- -q https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmour -o /usr/share/keyrings/oracle_vbox_2016.gpg

echo "Adicionando o repositório:"
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] http://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

echo "Atualizando a lista de repositórios"
apt update
echo "Instalando o pacote"
apt install virtualbox-7.1

echo "Para instalar o Extension Pack verifique a versão com este comando: vboxmanage -v | cut -dr -f1"
echo "Substitua os valores X e Y abaixo e faça o download do pacote com este comando:"
echo "wget https://download.virtualbox.org/virtualbox/7.X.Y/Oracle_VirtualBox_Extension_Pack-7.X.Y.vbox-extpack"
echo "Substitua os valores X e Y abaixo também e Instale o Extension Pack com este comando:"
echo "(sudo) vboxmanage extpack install Oracle_VirtualBox_Extension_Pack-7.X.Y.vbox-extpack"

echo "Verifique se a instalação está correta:"
echo "vboxmanage list extpacks"

echo "Adicione o Usuário ao vboxusers Group com o comando:"
echo "sudo usermod -a -G vboxusers $USER"
echo "Verifique se o usuário foi aceito:"
echo "groups $USER"

# FIM DE installing_virtualbox()
}

installing_virtualmanager(){
echo "Instalando o Virtual Manager a partir do repositório Debian"
apt install virt-manager qemu-system libvirt-clients libvirt-daemon-system

echo "Habilitando o serviço no início do sistema:"
systemctl enable libvirtd

echo "Executando o serviço:"
systemctl start libvirtd

# FIM DE installing_virtualmanager()
}

installing_steam(){
echo "Habilitar o suporte a 32 bits"
dpkg --add-architecture i386

echo "Atualiza a lista dos repositórios"
apt update

echo "Instalando as dependências"
apt install mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386

echo "Caso tenha uma placa de vídeo Nvidia descomente na função o seguinte comando"
echo "apt install nvidia-driver-libs:i386"
# apt install nvidia-driver-libs:i386

echo "A instalação de fato da Steam"
apt install steam

# FIM DE installing_steam()
}

installing_dolphin_emulator(){
echo "Instalando o Emulador de Nintendo GameCube e Nintendo Wii - Dolphin (Flatpak) "
flatpak install flathub org.DolphinEmu.dolphin-emu

# FIM DE installing_dolphin_emulator()
}

installing_citra(){
echo "Instalando o Emulador de Nintendo 3DS - CITRA (Flatpak) "
flatpak install flathub org.citra_emu.citra

# FIM DE installing_citra()
}

installing_flycast(){
echo "Instalando o Emulador de Sega Dreamcast - FLYCAST (Flatpak) "
flatpak install flathub org.flycast.Flycast

# FIM DE installing_flycast()
}

installing_pcsx2(){
echo "Instalando o Emulador de Playstation 2 - PCSX2 (Flatpak)"
flatpak install flathub net.pcsx2.PCSX2

# FIM DE installing_pcsx2()
}

installing_rpcs3(){
echo "Instalando o Emulador de Playstation 3 - RPCS3 (Flatpak)"
flatpak install flathub net.rpcs3.RPCS3

# FIM DE installing_rpcs3()
}

installing_snes9x(){
echo "Instalando o Emulador de Super Nintendo - SNES9X (Flatpak)"
flatpak install flathub com.snes9x.Snes9x

# FIM DE installing_snes9x()
}

installing_mgba(){
echo "Instalando o Emulador de Nintendo Game Boy Advance - MGBA (Flatpak)"
flatpak install flathub io.mgba.mGBA

# FIM DE installing_mgba()
}

installing_xemu(){
echo "Instalando o Emulador de Microsoft Xbox - XEMU (Flatpak)"
flatpak install flathub app.xemu.xemu

# FIM DE installing_xemu()
}

installing_yuzu(){
echo "Instalando o Emulador de Nintendo Switch - YUZU (Flatpak)"
flatpak install flathub org.yuzu_emu.yuzu

# FIM DE installing_yuzu()
}

installing_dropbox(){

#echo "Importando o pacote .DEB do site oficial: https://linux.dropboxstatic.com/packages/debian/"
#wget -O dropbox.deb "https://linux.dropboxstatic.com/packages/debian/dropbox_2024.04.17_i386.deb"
#echo "Instalando o pacote"
#apt install ./dropbox.deb
#echo "Para iniciar o aplicativo pelo terminal basta digitar: dropbox start -i "

echo "Instalando o aplicativo (Flatpak)"
flatpak install flathub com.dropbox.Client

# FIM DE installing_dropbox()
}

installing_mega(){
echo "Importando a chave GPG"
cd /tmp && curl https://mega.nz/linux/repo/Debian_12/Release.key | gpg --dearmor > /usr/share/keyrings/meganz-archive-keyring.gpg && cd $HOME

echo "Adicionando o repositório ao sistema"
echo "deb [signed-by=/usr/share/keyrings/meganz-archive-keyring.gpg] https://mega.nz/linux/repo/Debian_12/ ./" | tee /etc/apt/sources.list.d/megasync.list

echo "Atualizando a lista de repositórios e instalando o pacote"
apt update && apt install megasync

echo "Descomente a linha abaixo para realizar a integração com o Gerenciador de Arquivos do seu DESKTOP"
# Nautilus Gnome
#apt install nautilus-megasync

# Dolphin KDE
#apt install dolphin-megasync

#Nemo Cinnamon:
#apt install nemo-megasync

#Thunar XFCE:
#apt install thunar-megasync

# FIM DE installing_mega()
}

installing_anydesk(){
echo "Importando a chave GPG"
cd /tmp && wget -qO- https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/anydesk.gpg && cd $HOME

echo "Adicionando o repositório"
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list

echo "Atualizando a lista de repositórios e Instalando o AnyDesk"
apt update && apt install anydesk

# FIM DE installing_anydesk()
}

modifying_sysctl_conf(){
sysctl -w vm.swappiness=10
sysctl -w vm.vfs_cache_pressure=50

sysctl --system
sysctl -p

echo "Fim da modificação no arquivo /etc/sysctl.conf"
echo "Segue a descrição do arquivo. Verifique a alteração no final do texto."
cat /etc/sysctl.conf
# FIM DE modifying_sysctl_conf
}

improving_laptop_battery_life(){
echo "Instalando os pacotes TLP e TLP-RDW"
apt install tlp tlp-rdw
echo "Habilitando o serviço ao sistema"
systemctl enable tlp && tlp start

# FIM DE improving_battery_life()
}

installing_nvidia(){
echo "Instalando Driver NVIDIA mais recente"
echo "Instalando linux-headers e nvidia-detect"
apt install linux-headers-amd64
apt install nvidia-detect
echo "verifique sua placa com o comando nvidia-detect ou lspci -nn | egrep -i {3d|display|vga}"

echo "Instalando placas NVIDIA mais recentes"
apt install nvidia-driver firmware-misc-nonfree
echo "Instalando tecnologia NVIDIA CUDA"
apt install nvidia-cuda-dev nvidia-cuda-toolkit

echo "Reinicie o sistema para carregar o driver instalado"
# FIM DE installing_nvidia()
}

updating_system(){
echo "Atualizando a lista de repositórios e atualizando o sistema"
apt update && apt upgrade 
# FIM DE updating_system()
}

rebooting_system(){
echo "Reiniciando o sistema"
reboot
# FIM DE rebooting_system()
}

show_menu() {
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Executa a instalação de vários pacotes selecionados (inclua pacotes desejados na função)"
echo "2  - Modifica o arquivo Sources.List "
echo "3  - Modifica o idioma do sistema"
echo "4  - Adiciona usuário ao grupo SUDO"
echo "5  - Instala Gnome-tweaks e Gnome-Extension_Manager"
echo "6  - Instala o Firmware da Intel/AMD "
echo "7  - SubMenu para a escolha do firewall: (FirewallD ou UFW) "
echo "8  - Submenu para a escolha do web-browser"
echo "9  - Instala o YAD e o Tasksel"
echo "10 - SubMenu para a escolha de outros Desktops"
echo "11 - Instala o Flatpak"
echo "12 - Instala Codecs Multimedia"
echo "13 - Instala Extratores"
echo "14 - Instala Fontes"
echo "15 - Instala o particionador Gparted"
echo "16 - Instala os facilitadores de instalação Gdebi e Synaptic"
echo "17 - SubMenu para a escolha do player: (Audacius, VLC, SMPlayer, Kodi, Spotify)"
echo "18 - Submenu para a escolha dos pacotes: (Audacity, Blender, Gimp, e demais)"
echo "19 - SubMenu para a escolha dos pacotes: (Discord, Telegram, Thunderbird, Zoom, Teams)"
echo "20 - SubMenu para a escolha de Linguagens e IDEs"
echo "21 - SubMenu para a escolha das Máquinas Virtuais: Virtualbox, Virtual Manager"
echo "22 - SubMenu para a escolha dos emuladores (diversos) e STEAM"
echo "23 - SubMenu para a escolha do Dropbox, Mega e AnyDesk"
echo "24 - Modifica o arquivo sysctl.conf adicionando swappiness"
echo "25 - Otimizando a vida útil da bateria do Laptop"
echo "26 - Instala o driver da Nvidia para placas mais recentes"
echo "a  - Atualiza o sistema"
echo "r  - Reinicia o sistema"
echo "x  - Fim do Programa"
echo
}

main() {
check_if_root_is_logged
while true; do
 show_menu
 read -p "Escolha uma opção: " choice
 case $choice in
 1)
  execute_everything
  echo "Procedimento Realizado"
  ;;
 2)
  sources_list_modified
  echo "Procedimento Realizado"
  ;;
 3)
  changing_locale
  echo "Procedimento Realizado"
  ;;
 4)
  echo "Modifique o script para acrescentar o nome do usuário"
  adding_user_to_sudo
  # echo "Procedimento Realizado"
  ;;
 5)
  installing_gnome_tweaks_and_extension_manager
  echo "Procedimento Realizado"
  ;;
 6)
  installing_intel_firmware
  echo "Procedimento Realizado"
  ;;
 7)
  sub_firewall
  echo "Digite o valor entre as opções listadas"
  ;;
 8)
  sub_browsers
  echo "Digite o valor entre as opções listadas"
  ;;
 9)
  installing_yad_tasksel
  echo "Procedimento Realizado"
  ;;
 10)
  sub_desktops
  echo "Procedimento Realizado"
  ;;
 11)
  installing_flatpak
  echo "Procedimento Realizado"
  ;;
 12)
  installing_codecs
  echo "Procedimento Realizado"
  ;;
 13)
  installing_extractors
  echo "Procedimento Realizado"
  ;;
 14)
  installing_fonts
  echo "Procedimento Realizado"
  ;;
 15)
  installing_gparted
  echo "Procedimento Realizado"
  ;;
 16)
  installing_gdebi_synaptic
  echo "Procedimento Realizado"
  ;;
 17)
  sub_players
  echo "Digite o valor entre as opções listadas"
  ;;
 18)
  sub_graphicals
  echo "Digite o valor entre as opções listadas"
  ;;
 19)
  sub_comunication
  echo "Digite o valor entre as opções listadas"
  ;;
 20)
  sub_developers
  echo "Digite o valor entre as opções listadas"
  ;;
 21)
  sub_vmachines
  echo "Digite o valor entre as opções listadas"
  ;;
 22)
  sub_games
  echo "Digite o valor entre as opções listadas"
  ;;
 23)
  sub_cloud
  echo "Digite o valor entre as opções listadas"
  ;;
 24)
  modifying_sysctl_conf
  echo "Procedimento Realizado"
  ;;
 25)
  improving_laptop_battery_life
  echo "Procedimento Realizado"
  ;;
 26)
  installing_nvidia
  echo "Procedimento Realizado"
  ;;
  a|A)
  updating_system
  echo "Procedimento Realizado"
  ;;
 r|R)
  rebooting_system
  echo "Procedimento Realizado"
  ;;
 x|X)
  exit 0
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done

}

show_subMenu_firewall(){
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Instala o firewall FIREWALLD"
echo "2  - Instala o firewall UFW"
echo "q  - Volta para o menu principal" 

# FIM DE show_subMenu_firewall()
}

sub_firewall(){
while true; do
 show_subMenu_firewall
 read -p "Escolha uma opção: " fire
 case $fire in
 1)
  installing_firewalld
  echo "Procedimento Realizado"
  ;;
 2)
  installing_ufw
  echo "Procedimento Realizado"
  ;;
 q|Q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_firewall()
}

show_subMenu_graphicals(){
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Instala o editor de audio Audacity"
echo "2  - Instala o Blender"
echo "3  - Instala o GIMP"
echo "4  - Instala o ripador de DVDs Handbrake"
echo "5  - Instala o Inkscape"
echo "6  - Instala o kdenlive"
echo "7  - Instala o krita"
echo "8  - Instala o OBS Studio"
echo "9  - Instala o editor de vídeos Openshot"
echo "q  - Volta para o menu principal" 

# FIM DE show_subMenu_graphicals()
}

sub_graphicals(){
while true; do
 show_subMenu_graphicals
 read -p "Escolha uma opção: " fire
 case $fire in
 1)
  installing_audacity
  echo "Procedimento Realizado"
  ;;
 2)
  installing_blender
  echo "Procedimento Realizado"
  ;;
 3)
  installing_gimp
  echo "Procedimento Realizado"
  ;;
 4)
  installing_handbrake
  echo "Procedimento Realizado"
  ;; 
 5)
  installing_inkscape
  echo "Procedimento Realizado"
  ;; 
 6)
  installing_kdenlive
  echo "Procedimento Realizado"
  ;;
 7)
  installing_krita
  echo "Procedimento Realizado"
  ;;
 8)
  installing_obs_studio
  echo "Procedimento Realizado"
  ;;
 9)
  installing_openshot
  echo "Procedimento Realizado"
  ;;
 q|Q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_graphicals()
}

show_subMenu_comunication(){
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Instala o Discord"
echo "2  - Instala o Telegram"
echo "3  - Instala o Thunderbird"
echo "4  - Instala o Zoom (Flatpak)"
echo "5  - Instala o Microsoft Teams"
echo "q  - Volta para o menu principal" 

# FIM DE show_subMenu_comunication()
}

sub_comunication(){
while true; do
 show_subMenu_comunication
 read -p "Escolha uma opção: " fire
 case $fire in
 1)
  installing_discord
  echo "Procedimento Realizado"
  ;;
 2)
  installing_telegram
  echo "Procedimento Realizado"
  ;;
 3)
  installing_thunderbird
  echo "Procedimento Realizado"
  ;;
 4)
  installing_zoom
  echo "Procedimento Realizado"
  ;;
 5)
  installing_teams
  echo "Procedimento Realizado"
  ;;
 q|Q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_comunication()
}

show_subMenu_browsers(){ # (Chrome, Opera, Vivaldi, Edge, Chromium)
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Instala o Google Chrome"
echo "2  - Instala o Opera"
echo "3  - Instala o Vivaldi"
echo "4  - Instala o Microsoft Edge"
echo "5  - Instala o Chromium"  
echo "6  - Instala o LibreWolf"
echo "7  - Instala o Zen Browser"
echo "q  - Volta para o menu principal" 

# FIM DE show_subMenu_browsers()
}

sub_browsers(){
while true; do
 show_subMenu_browsers
 read -p "Escolha uma opção: " fire
 case $fire in
 1)
  installing_chrome_repo
  echo "Procedimento Realizado"
  ;;
 2)
  installing_opera_repo
  echo "Procedimento Realizado"
  ;;
 3)
  installing_vivaldi_repo
  echo "Procedimento Realizado"
  ;;
 4)
  installing_edge_repo
  echo "Procedimento Realizado"
  ;; 
 5)
  installing_chromium_repo
  echo "Procedimento Realizado"
  ;; 
 6)
  installing_librewolf
  echo "Procedimento Realizado"
  ;;
 7)
  installing_zen
  echo "Procedimento Realizado"
  ;;
 q|Q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_browsers()
}

# Players

show_subMenu_players(){ # (Chrome, Opera, Vivaldi, Edge, Chromium)
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Instala o Audacius"
echo "2  - Instala o VLC"
echo "3  - Instala o SMPlayer"
echo "4  - Instala o Kodi"
echo "5  - Instala o Spotify"
echo "q  - Volta para o menu principal" 

# FIM DE show_subMenu_players()
}

sub_players(){
while true; do
 show_subMenu_players
 read -p "Escolha uma opção: " fire
 case $fire in
 1)
  installing_audacious
  echo "Procedimento Realizado"
  ;;
 2)
  installing_vlc
  echo "Procedimento Realizado"
  ;;
 3)
  installing_smplayer
  echo "Procedimento Realizado"
  ;;
 4)
  installing_kodi
  echo "Procedimento Realizado"
  ;; 
 5)
  installing_spotify
  echo "Procedimento Realizado"
  ;; 
 q|Q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_players()
}

# DESKTOPS
show_subMenu_desktops(){
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Instala o GNOME"
echo "2  - Instala o XFCE"
echo "3  - Instala o KDE PLASMA"
echo "4  - Instala o CINNAMON"
echo "5  - Instala o MATE"
echo "6  - Instala o LXDE"
echo "7  - Instala o LXQT"
echo "q  - Volta para o menu principal" 

# FIM DE show_subMenu_desktops()
}

sub_desktops(){
while true; do
 show_subMenu_desktops
 read -p "Escolha uma opção: " fire
 case $fire in
 1)
  installing_gnome
  echo "Procedimento Realizado"
  ;;
 2)
  installing_xfce
  echo "Procedimento Realizado"
  ;;
 3)
  installing_kde
  echo "Procedimento Realizado"
  ;;
 4)
  installing_cinnamon
  echo "Procedimento Realizado"
  ;; 
 5)
  installing_mate
  echo "Procedimento Realizado"
  ;; 
 6)
  installing_lxde
  echo "Procedimento Realizado"
  ;;
 7)
  installing_lxqt
  echo "Procedimento Realizado"
  ;;
 q|Q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_desktops()
}

# JAVA && DEVELOPERS

show_subMenu_developers(){
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Instala o RUST"
echo "2  - Instala o PYTHON"
echo "3  - Instala o JAVA"
echo "4  - Instala o PHP e o APACHE 2"
echo "5  - Instala o CCache (C C++), Bibliotecas adicionais, Autotools e CMake "
echo "6  - Instala o NodeJS e NPM"
echo "7  - Instala MariaDB"
echo "8  - Instala Postgresql"
echo "9  - Instala o GIT, o Subversion e o Mercurial"
echo "10 - Instala o Docker e Docker-Compose"
echo "11 - Instala o Visual Studio Code"
echo "12 - Instala o Sublime Text"
echo "13 - Instala o Atom"
echo "14 - Instala o VIM"
echo "15 - Instala o NEOVIM"
echo "16 - Instala o DBeaver Community (Flatpak)"
echo "17 - SubMenu para IDEs JAVA"
echo "q  - Volta para o menu principal" 

# FIM DE show_subMenu_developers()
}

sub_developers(){
while true; do
 show_subMenu_developers
 read -p "Escolha uma opção: " fire
 case $fire in
 1)
  installing_rust
  
  ;;
 2)
  installing_python
  
  ;;
 3)
  installing_java
  
  ;;
 4)
  installing_php
  
  ;; 
 5)
  installing_build_essential
  echo "Procedimento Realizado"
  ;;
 6)
  installing_nodejs_npm
  echo "Procedimento Realizado"
  ;;
 7)
  installing_mariadb
  echo "Procedimento Realizado"
  ;;
 8)
  installing_postgresql
  echo "Procedimento Realizado"
  ;;
 9)
  installing_git_subversion_mercurial
  echo "Procedimento Realizado"
  ;;
 10)
  installing_docker
  echo "Procedimento Realizado"
  ;;
 11)
  installing_code
  echo "Procedimento Realizado"
  ;;
 12)
  installing_sublime
  echo "Procedimento Realizado"
  ;;
 13)
  installing_atom
  echo "Procedimento Realizado"
  ;;
 14)
  installing_vim
  echo "Procedimento Realizado"
  ;;
 15)
  installing_neo_vim
  echo "Procedimento Realizado"
  ;;
 16)
  installing_dbeaver
  echo "Procedimento Realizado"
  ;;
 17)
  echo "IDEs Java"
  sub_IDE_java
  ;;
 q|Q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_developers()
}

# VIRTUAL MACHINES
show_subMenu_vmachines(){
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Instala o VirtualBox"
echo "2  - Instala o Virtual Manager"
echo "q  - Volta para o menu principal" 

# FIM DE show_subMenu_vmachines()
}

sub_vmachines(){
while true; do
 show_subMenu_vmachines
 read -p "Escolha uma opção: " fire
 case $fire in
 1)
  installing_virtualbox
  echo "Procedimento Realizado"
  ;;
 2)
  installing_virtualmanager
  echo "Procedimento Realizado"
  ;;
 q|Q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_vmachines()
}

show_subMenu_games(){
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Instala o STEAM"
echo "2  - Instala o Dolpin Emulator"
echo "3  - Instala o Emulador de Nintendo 3DS - CITRA"
echo "4  - Instala o Emulador de SEGA DREAMCAST - Flycast"
echo "5  - Instala o Emulador de PlayStation 2 - PCSX2"
echo "6  - Instala o Emulador de PlayStation3 - RPCS3"
echo "7  - Instala o Emulador de Super Nintendo - Snes9x"
echo "8  - Instala o Emulador de Nintendo Game Boy Advance - mGBA"
echo "9  - Instala o Emulador de Microsoft Xbox - xemu"
echo "10 - Instala o Emulador de Nintendo Switch - Yuzu"
echo "q  - Volta para o menu principal" 

# FIM DE show_subMenu_games()
}

sub_games(){
while true; do
 show_subMenu_games
 read -p "Escolha uma opção: " fire
 case $fire in
 1)
  installing_steam
  echo "Procedimento Realizado"
  ;;
 2)
  installing_dolphin_emulator
  echo "Procedimento Realizado"
  ;;
 3)
  installing_citra
  echo "Procedimento Realizado"
  ;;
 4)
  installing_flycast
  echo "Procedimento Realizado"
  ;; 
 5)
  installing_pcsx2
  echo "Procedimento Realizado"
  ;; 
 6)
  installing_rpcs3
  echo "Procedimento Realizado"
  ;;
 7)
  installing_snes9x
  echo "Procedimento Realizado"
  ;;
 8)
  installing_mgba
  echo "Procedimento Realizado"
  ;;
 9)
  installing_xemu
  echo "Procedimento Realizado"
  ;;
 10)
  installing_yuzu
  echo "Procedimento Realizado"
  ;;
 q|Q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_games()
}

# CLOUD STORAGE

show_subMenu_cloud(){
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Instala o Dropbox (Flatpak)"
echo "2  - Instala o Mega"
echo "3  - Instala o AnyDesk"
echo "q  - Volta para o menu principal" 

# FIM DE show_subMenu_cloud()
}

sub_cloud(){
while true; do
 show_subMenu_cloud
 read -p "Escolha uma opção: " fire
 case $fire in
 1)
  installing_dropbox
  echo "Procedimento Realizado"
  ;;
 2)
  installing_mega
  echo "Procedimento Realizado"
  ;;
 3)
  installing_anydesk
  ;;
 q|Q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_cloud()
}

# IDEs JAVA

show_subMenu_IDE_java(){
echo "Escolha a opção pela numeração abaixo: "
echo "1  - Instala o APACHE NETBEANS"
echo "2  - Instala o BLUEJ"
echo "3  - Instala o ECLIPSE"
echo "4  - Instala o INTELLIJ IDEA"
echo "q  - Volta para o menu principal" 

# FIM DE show_subMenu_IDE_java()
}

sub_IDE_java(){
while true; do
 show_subMenu_IDE_java
 read -p "Escolha uma opção: " fire
 case $fire in
 1)
  installing_netbeans 
  echo "Procedimento Realizado"
  ;;
 2)
  installing_bluej
  echo "Procedimento Realizado"
  ;;
 3)
  installing_eclipse
  echo "Procedimento Realizado"
  ;;
 4)
  installing_intellij
  echo "Procedimento Realizado"
  ;; 
 q|Q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_IDE_java()
}

execute_everything(){

check_if_root_is_logged
sources_list_modified
changing_locale
#adding_user_to_sudo
installing_gnome_tweaks_and_extension_manager
installing_intel_firmware
#installing_firewalld
installing_firewall_ufw
installing_yad_tasksel
installing_flatpak
installing_codecs_extractors_fonts
installing_gdebi_gparted_synaptic
installing_vlc
preparing_to_install_web_browsers
#installing_chrome_repo
#installing_opera_repo
installing_vivaldi_repo
installing_gimp
modifying_sysctl_conf
improving_laptop_battery_life
installing_nvidia
updating_system
rebooting_system
# FIM DE execute_everything()
}

main


# Fonte de referência: https://www.blogopcaolinux.com.br/
# Blog Opção Linux
# Site dos demais aplicativos.

