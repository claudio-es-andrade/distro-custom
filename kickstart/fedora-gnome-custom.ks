# Description:
# custom-fedora-gnome.ks
#
# Description:
# - Customized Fedora Live Spin with the Gnome XFCE Desktop Environment
#
# Maintainer:
# - Claudio Andrade    <claudioe.s.andrade@gmail.com>
#
# Version:1.0

%include fedora-live-workstation.ks 

repo --name=rpmfusion-free --mirrorlist=https://mirrors.rpmfusion.org/metalink?repo=free-fedora-43&arch=x86_64 --install
repo --name=rpmfusion-nonfree --mirrorlist=https://mirrors.rpmfusion.org/metalink?repo=nonfree-fedora-43&arch=x86_64 --install

rootpw --lock
user --groups=wheel --name=live --password=$5$4vwhsbi2sS0ktswv$D0ULi.Xx4rwOtR2RYnrXJpVYj4CRj9DHIJO7Wp4BQ53 --iscrypted --gecos="live"

lang pt_BR.UTF-8
keyboard  --vckeymap=br --xlayouts=br
timezone America/Sao_Paulo --utc

# Packages
%packages

@development-tools
@virtualization

libguestfs-tools
python3-libguestfs
virt-top
virtiofsd

gnome-tweaks
wget
curl
vim
git

# Codecs
gstreamer1-plugins-ugly
ffmpeg

amrnb
amrwb 
faad2 
flac 
gpac-libs 
lame 
libde265 
libfc14audiodecoder 
mencoder 
x264 
x265

# Compactors
cabextract
lzip
p7zip
p7zip-plugins
unrar

%end
