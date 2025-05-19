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
#apt update && apt upgrade
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
echo "Adicionando usuário ao grupo sudo do sistema:"
adduser $USER sudo
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
echo "Para adicionar Firmware AMD execute no terminal o comando apt install amd64-microcode"
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

echo "Mostrando a zona padrão atual do firewall"
firewall-cmd --get-default-zone

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
echo "Instalando YAD e TASKSEL ao sistema"
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

installing_flatpak(){
echo "Habilitando pacotes FLATPAK do Flathub ao sistema"

apt install flatpak
apt install gnome-software-plugin-flatpak
echo "Caso esteja no KDE-PLASMA utilize o comando sudo apt install plasma-discover-backend-flatpak"

echo "Adicionando o FlatHub.org ao sistema"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# FIM DE installing_flatpak()
}

installing_codecs_extractors_fonts(){
echo "Instalando Codecs diversos"
apt install faad ffmpeg gstreamer1.0-fdkaac gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly lame libavcodec-extra libavcodec-extra* libavdevice* libgstreamer1.0-0 sox twolame vorbis-tools

echo "Codecs para o MPlayer, Xine"
cd /tmp && wget http://www.deb-multimedia.org/pool/non-free/w/w64codecs/w64codecs_20071007-dmo2_amd64.deb && apt install ./w64codecs_20071007-dmo2_amd64.deb && cd $HOME

echo "Codecs para DVD criptografado"
apt install libdvd-pkg
echo "Comando para continuar a instalação configuração do Codec de DVD"
dpkg-reconfigure libdvd-pkg

echo "Extração e Compactação de arquivos"
apt install arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip

echo "Instalando fontes da Microsoft"
apt install cabextract curl fontconfig xfonts-utils
apt install ttf-mscorefonts-installer
# FIM DE installing_codecs_extractors_fonts()
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

installing_gdebi_gparted_synaptic(){
echo "Instalando GDebi e Synaptic"
apt install gdebi synaptic

echo "Instalando Gparted"
apt install gparted
# FIM DE installing_gdebi_gparted_synaptic()
}

preparing_to_install_web_browsers(){
echo "Adicionando pacotes necessários para a instalação"
apt install software-properties-common apt-transport-https ca-certificates curl wget git -y
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

echo "Segue o arquivo repositório para conferir"
cat /etc/apt/sources.list.d/google-chrome.list

echo "Para instalar o Chrome basta digitar apt install google-chrome-stable -y"
echo "Navegador pronto para ser instalado"
echo "Instalador o navegador CHROME"
apt install ggogle-chrome-stable -y
echo "Navegador instalado e pronto para o uso"
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

echo "Para instalar o Opera basta digitar apt install opera-stable -y"
echo "Navegador pronto para ser instalado"
echo "Instalando o navegador OPERA"
apt install opera-stable -y
echo "Navegador instalado e pronto para o uso"
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

echo "Segue o arquivo repositório para conferir "
cat /etc/apt/sources.list.d/vivaldi.list

echo "Para instalar o Opera basta digitar apt install vivaldi-stable -y "
echo "Navegador pronto para ser instalado"
echo "Instalando o Navegador VIVALDI... "
apt install vivaldi-stable -y
echo "Navegador instalado e pronto para o uso"
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

echo "Segue o arquivo repositório para conferir "
cat /etc/apt/sources.list.d/microsoft-edge.list

echo "Para instalar o Opera basta digitar apt install microsoft-edge-stable -y "
echo "Navegador pronto para ser instalado"
echo "Instalando o Navegador MICROSOFT EDGE... "
apt update && apt install microsoft-edge-stable -y
echo "Navegador instalado e pronto para o uso"
# FIM DE installing_edge_repo
}

installing_chromium_repo(){
echo "Instalando o navegador CHROMIUM..."
apt install chromium
echo "Navegador instalado e pronto para o uso"
# FIM DE installing_chromium_repo()
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
apt update && apt upgrade -y
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
echo "6  - Instala o Firmware da Intel"
echo "7  - SubMenu para a escolha do firewall: (FirewallD ou UFW) "
echo "8  - Submenu para a escolha do web-browser: (Chrome, Opera, Vivaldi, Edge, Chromium)"
echo "9  - Instala o YAD e o Tasksel"
echo "10 - Instala o Flatpak"
echo "11 - Instala Codecs Multimedia, o player VLC, Compactadores, Extratores e Fontes"
echo "12 - Instala os instaladores de pacotes Gdebi Synaptic e o particionador Gparted"
echo "13 - SubMenu para a escolha do player: (Audacius, VLC, SMPlayer, Kodi, Spotify)"
echo "14 - Submenu para a escolha dos pacotes: (Audacity, Blender, Gimp, Handbrake, Inkscape, Kdenlive, Krita, OBS studio, OpenShot)"
echo "15 - SubMenu para a escolha dos pacotes: (Discord, Telegram, Thunderbird) "
echo "16 - Modifica o arquivo sysctl.conf adicionando swappiness"
echo "17 - Otimizando a vida útil da bateria do Laptop"
echo "18 - Instala o driver da Nvidia para placas mais recentes"
echo "19 - Atualiza o sistema"
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
  adding_user_to_sudo
  echo "Procedimento Realizado"
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
  installing_flatpak
  echo "Procedimento Realizado"
  ;;
 11)
  installing_codecs_extractors_fonts
  echo "Procedimento Realizado"
  ;;
 12)
  installing_gdebi_gparted_synaptic
  echo "Procedimento Realizado"
  ;;
 13)
  sub_players
  echo "Digite o valor entre as opções listadas"
  ;;
 14)
  sub_graphicals
  echo "Digite o valor entre as opções listadas"
  ;;
 15)
  sub_comunication
  echo "Digite o valor entre as opções listadas"
  ;;
 16)
  modifying_sysctl_conf
  echo "Procedimento Realizado"
  ;;
 17)
  improving_battery_life
  echo "Procedimento Realizado"
  ;;
 18)
  installing_nvidia
  echo "Procedimento Realizado"
  ;;
 19)
  updating_system
  echo "Procedimento Realizado"
  ;;
 r)
  rebooting_system
  echo "Procedimento Realizado"
  ;;
 x)
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
 q)
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
 q)
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
 q)
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
 q)
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
 q)
  break
  ;;
 *)
  echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_players()
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
improving_battery_life
installing_nvidia
updating_system
rebooting_system
# FIM DE execute_everything()
}

main


# Fonte: https://www.blogopcaolinux.com.br/
# Blog Opção Linux