#!/bin/bash

check_if_last_command_was_done(){

 if [ $? -eq 0 ]; then
    echo "Procedimento Realizado"
   else
    echo "Comando Falhou"
   fi

# FIM DE check_if_last_command_was_done()
}

installing_packages(){

  echo "Add Custom Packages (One per line)"
  mkdir -p config/package-lists
cat <<- EOF >> config/package-lists/custom.list.chroot

  live-boot
  live-config
  live-config-systemd

  vim
  nano
  wget
  curl
  git
  sudo

  less
  iputils-ping
  net-tools
  yad
  tasksel

  ufw
  gufw
  flatpak
  gnome-software-plugin-flatpak
  extrepo
  nala
  bat
  htop

  calamares
  calamares-settings-debian

EOF

# FIM DE installing_packages()
}

# Desktop Modules
installing_gnome_core(){
  echo "Instalando a ISO com o GNOME DESKTOP BÁSICO"
 
  # Add Custom Packages
  echo "Add Custom Packages (One per line)"

  installing_packages

  echo "gnome-core" >> config/package-lists/custom.list.chroot
  echo "gnome-tweaks" >> config/package-lists/custom.list.chroot
  echo "gnome-shell-extension-manager" >> config/package-lists/custom.list.chroot
  echo "gnome-system-monitor" >> config/package-lists/custom.list.chroot

# FIM DE installing_gnome_core()
}

installing_gnome(){
  echo "Instalando a ISO com o GNOME DESKTOP"
 
  # Add Custom Packages
  installing_packages

  echo "task-gnome-desktop" >> config/package-lists/custom.list.chroot
  echo "gnome-tweaks"  >> config/package-lists/custom.list.chroot    
  echo "gnome-shell-extension-manager" >> config/package-lists/custom.list.chroot
 
# FIM DE installing_gnome()
}
installing_xfce_core(){
  echo "Instalando o XFCE DESKTOP"

# Add Custom Packages
  installing_packages
  
  echo "xfce4" >> config/package-lists/custom.list.chroot
  echo "xfce4-goodies" >> config/package-lists/custom.list.chroot

# FIM DE installing_xfce()
}

installing_xfce(){
  echo "Instalando o XFCE DESKTOP"

# Add Custom Packages
  installing_packages
  
  echo "task-xfce-desktop" >> config/package-lists/custom.list.chroot

# FIM DE installing_xfce()
}

installing_kde_core(){
  echo "Instalando o KDE PLASMA"

# Add Custom Packages
  installing_packages

  echo "kde-plasma-desktop" >> config/package-lists/custom.list.chroot


# FIM DE installing_kde()
}

installing_kde(){
  echo "Instalando o KDE PLASMA"

# Add Custom Packages
  installing_packages

  echo "task-kde-desktop" >> config/package-lists/custom.list.chroot


# FIM DE installing_kde()
}
installing_cinnamon_core(){
  echo "Instalando o LXDE DESKTOP"
 
 # Add Custom Packages
  installing_packages
  
  echo "cinnamon-core" >> config/package-lists/custom.list.chroot


# FIM DE installing_cinnamon()
}

installing_cinnamon(){
  echo "Instalando o LXDE DESKTOP"
 
 # Add Custom Packages
  installing_packages
  
  echo "task-cinnamon-desktop" >> config/package-lists/custom.list.chroot


# FIM DE installing_cinnamon()
}

installing_mate_core(){
  echo "Instalando o MATE DESKTOP"
 
 # Add Custom Packages
  installing_packages

  echo "mate-desktop-environment-core" >> config/package-lists/custom.list.chroot


# FIM DE installing_mate()
}


installing_mate(){
  echo "Instalando o MATE DESKTOP"
 
 # Add Custom Packages
  installing_packages

  echo "task-mate-desktop" >> config/package-lists/custom.list.chroot


# FIM DE installing_mate()
}

installing_lxde_core(){
  echo "Instalando o LXDE DESKTOP"
 
 # Add Custom Packages
  installing_packages
 
  echo "lxde-core" >> config/package-lists/custom.list.chroot

# FIM DE installing_lxde()
}

installing_lxde(){
  echo "Instalando o LXDE DESKTOP"
 
 # Add Custom Packages
  installing_packages
 
  echo "task-lxde-desktop" >> config/package-lists/custom.list.chroot

# FIM DE installing_lxde()
}

installing_lxqt_core(){
 echo "Instalando o LXQT DESKTOP"

# Add Custom Packages
  installing_packages 

 echo "lxqt-core" >> config/package-lists/custom.list.chroot


# FIM DE installing_lxqt()
}

installing_lxqt(){
 echo "Instalando o LXQT DESKTOP"

# Add Custom Packages
  installing_packages 

 echo "task-lxqt-desktop" >> config/package-lists/custom.list.chroot


# FIM DE installing_lxqt()
}

# DESKTOPS
show_Menu_Desktops(){
 echo "Escolha a opção pela numeração abaixo: "
 echo "1  - Instala o GNOME-CORE (Basico)"
 echo "2  - Instala o GNOME"
 echo "3  - Instala o XFCE-CORE (Basico)"
 echo "4  - Instala o XFCE"
 echo "5  - Instala o KDE-CORE (Basico)"
 echo "6  - Instala o KDE PLASMA"
 echo "7  - Instala o CINNAMON-CORE (Basido)"
 echo "8  - Instala o CINNAMON"
 echo "9  - Instala o MATE-CORE (Basico)"
 echo "10 - Instala o MATE"
 echo "11 - Instala o LXDE-CORE (Basico)"
 echo "12 - Instala o LXDE"
 echo "13 - Instala o LXQT-CORE (Basico)"
 echo "14 - Instala o LXQT"
 echo "X  - Sai do sistema" 

# FIM DE show_subMenu_desktops()
}

sub_desktops(){
 while true; do
  show_Menu_Desktops
  read -p "Escolha uma opção: " fire
  case $fire in
  1)
   installing_gnome_core
   check_if_last_command_was_done
  ;;
  2)
   installing_gnome
   check_if_last_command_was_done
  ;;
  3)
   installing_xfce_core
   check_if_last_command_was_done
  ;;
  4)
   installing_xfce
   check_if_last_command_was_done
  ;;
  5)
   installing_kde_core
   check_if_last_command_was_done
  ;;
  6)
   installing_kde
   check_if_last_command_was_done
  ;;
  7)
   installing_cinnamon_core
   check_if_last_command_was_done
  ;;
  8)
   installing_cinnamon
   check_if_last_command_was_done
  ;; 
  9)
   installing_mate_core
   check_if_last_command_was_done
  ;; 
  10)
   installing_mate
   check_if_last_command_was_done
  ;; 
  11)
   installing_lxde_core
   check_if_last_command_was_done
  ;;
  12)
   installing_lxde
   check_if_last_command_was_done
  ;;
  13)
   installing_lxqt_core
   check_if_last_command_was_done
  ;;
  14)
   installing_lxqt
   check_if_last_command_was_done
  ;;
  x|X)
  exit 0
  ;;
  *)
   echo "O valor escolhido deve estar entre os valores apresentados nas opções."
  ;;
  esac
 done
 
# FIM DE sub_desktops()
}


main(){

sub_desktops

# FIM DE main()
}


main
