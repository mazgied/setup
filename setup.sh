sudo apt update
sudo apt install openssh-server picocom -y
sudo systemctl enable --now ssh
sudo adduser admin dialout
echo -e "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICectmfLInid+wqITnWl3KxNQaP2j+xxEEqhzFpEwOyi\n" > ~/.ssh/authorized_keys
cd ~/Downloads
wget https://download.nomachine.com/packages/8.11-PRODUCTION/Linux/nomachine-enterprise-desktop_8.11.3_4_amd64.deb
sudo dpkg -i nomachine-enterprise-desktop_8.11.3_4_amd64.deb && rm nomachine-enterprise-desktop_8.11.3_4_amd64.deb


# install wine
# https://wine.htmlvalidator.com/install-wine-on-ubuntu-22.04.html
# https://wine.htmlvalidator.com/install-wine-on-ubuntu-20.04.html
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
# 20.04
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources
sudo apt update
sudo apt install --install-recommends winehq-stable -y
wine --version

## from nomachine/teamviewer
## 
wine winecfg

# get u-center ublox
wget https://content.u-blox.com/sites/default/files/2023-08/u-centersetup_v23.08.zip
unzip u-centersetup_v23.08.zip && rm u-centersetup_v23.08.zip
## from nomachine/teamviewer
wine /home/$USER/Downloads/u-center_v23.08.exe

# map ublox board serial to fixed name
sudo su
sudo echo -e 'SUBSYSTEM=="tty", ATTRS{idVendor}=="1546", ATTRS{idProduct}=="01a9", MODE="0660", SYMLINK+="ttyUSB_UBX1"' >> /etc/udev/rules.d/10-usb-serial.rules
sudo echo -e 'SUBSYSTEM=="tty", ATTRS{idVendor}=="1546", ATTRS{idProduct}=="01a9", MODE="0660", SYMLINK+="ttyUSB_UBX1"' >> /etc/udev/rules.d/10-usb-serial.rules
exit




## when ublox F9P board connected

# then add simlinks for wine, so that ublox can see those too
cd ~/.wine/dosdevices
ln -s /dev/ttyUSB_UBX1 com40
ln -s /dev/ttyUSB_UBX2 com41


+
# ublox base config file
# make scp to the device
wget https://github.com/u-blox/ublox-C099_F9P-uCS/blob/master/zed-f9p/F9P%20Base%20config%20C99.txt
wget https://www.ardusimple.com/configuration-files/
wget https://www.ardusimple.com/wp-content/uploads/2022/09/simpleRTK2B_FW132_Base-00.txt

sudo apt install rtklib

# Settings -> Power -> 
#     High Performance 
#     Screen Blank -> never
#     Automatic suspend -> off
# Settings -> Privacy ->
#     Blank Screen Delay -> never 
#     Automatic Screen Lock -> Off
#     Lock Screen on Suspend -> Off


