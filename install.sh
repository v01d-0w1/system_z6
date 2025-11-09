#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon

sudo xbps-install -Syvu < packages.txt

sudo ln -s /etc/sv/{dbus,NetworkManager,lightdm,avahi-daemon} /var/service/ && sudo sv up dbus NetworkManager lightdm avahi-daemon

brew install nvim oh-my-posh clcokify-cli ncurces nmap xz hcxtools autojump gh sfml AmmarAbouZor/homebrew-tui-journal/tui-journal java

pipx install gitfetch textual-paint

cd ~/system_z6/ 

cp -r .bashrc .config .mpd .ncmpcpp .themes Downloads app code img workspace ~/

cd Downloads
mkdir Hacker-C && tar -xzf Hacker-C.tar.gz -C Hacker-C
mkdir Midnight-Green && 7z x Midnight-Green.7z -oMidnight-Green
mkdir Ubuntu-Mono-Dark-Green && tar -xzf Ubuntu-Mono-Dark-Green.tar.gz -C Ubuntu-Mono-Dark-Green

sudo cp -r Hacker-C Midnight-Green Ubuntu-Mono-Dark-Green /usr/share/icons/
cp -r Midnight-Green ~/.themes

cd ~/

for repo in \
  https://github.com/v01d-0w1/z3.git\
  https://github.com/v01d-0w1/zicom.git\
  https://github.com/v01d-0w1/zvim.git \
  https://github.com/v01d-0w1/z6.git \
  https://github.com/v01d-0w1/zpoly.git \
  https://github.com/v01d-0w1/zmux.git \
  https://github.com/v01d-0w1/zbat.git \
  https://github.com/v01d-0w1/kitty_z6.git \
  https://github.com/v01d-0w1/zute.git \
  https://github.com/v01d-0w1/z6_sh.git\
  https://github.com/Matars/gitfetch.git\
  https://github.com/ReidoBoss/tttui.git\
  https://github.com/dacctal/pkgit\
  https://github.com/CrowCpp/Crow.git

do
  git clone $repo
done

cp -r z3/* ~/.config/i3/
cp -r zvim/* ~/.config/nvim/
cp -r zpoly/* ~/.config/polybar/
cp -r zmux/* ~/
cp -r zbat/* ~/.config/bat/
cp -r kitty_z6/* ~/.config/kitty/
cp -r zute/* ~/.config/qutebrowser/

chmod +X ~/tttui/bin/tttui
cd ~/gitfetch/
pipx install -e .
nimble install parsetoml
cd ~/pkgit
./install.sh
pkgit ar https://github.com/dacctal/pkgit
pkgit i pkgit
rm -rf ~/pkgit
cd ~/Crow/
cmake .. -DCROW_BUILD_EXAMPLES=OFF -DCROW_BUILD_TESTS=OFF
make install
cd ~
sudo cp -r ~/Crow/include/* /usr/local/include/
cd ~/system_z6/
7zip x SFML-2.6.0-linux-gcc-64-bit.tar
cp -r SFML-2.6.0/{include,lib} /usr/local/

sudo tee /etc/acpi/handler.sh << 'EOF'
#!/bin/sh
case "$1" in
    button/lid)
        case "$3" in
            close)
                logger "ACPI: Lid closed - locking then suspending"
                USER=$(who | grep "(:0)" | awk '{print $1}' | head -n1)
                if [ -n "$USER" ] && [ -f "/home/$USER/.Xauthority" ]; then
                    export XAUTHORITY=/home/$USER/.Xauthority
                    export DISPLAY=:0
                    sudo -u $USER betterlockscreen -l &
                    # Wait for lock to show, then suspend
                    sleep 2
                    echo "mem" > /sys/power/state
                fi
                ;;
            open)
                logger "ACPI: Lid opened - system resumed"
                ;;
        esac
        ;;
    *)
        logger "ACPI: Ignoring event $1"
        ;;
esac
EOF

sudo chmod +x /etc/acpi/handler.sh
sudo sv restart acpid


chmod +x ~/app/JDownloader2Setup_unix_nojre.sh
~/app/JDownloader2Setup_unix_nojre.sh
