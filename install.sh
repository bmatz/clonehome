#!/bin/bash

_echo () {
    LEN=$(echo $1 | wc -c)
    ((LEN--))
    DECO=""
    STARS=50

    counter=1
    while [ $counter -le ${STARS} ]
    do
        DECO="${DECO}#"
        ((counter++))
    done

    SHORTSTARS=$(expr $STARS - $LEN - 2)
    OSTARS=$(expr $SHORTSTARS / 2)

    ADDONE=$(expr $LEN % 2)

    LINE=""

    #stars begin
    counter=1
    while [ $counter -le ${OSTARS} ]
    do
        LINE="${LINE}#"
        ((counter++))
    done

    # word
    LINE="${LINE} "
    LINE="${LINE}$1"
    LINE="${LINE} "

    if [ $ADDONE -eq 1 ]
    then
        LINE="${LINE}#"
    fi

    # stars end
    counter=1
    while [ $counter -le ${OSTARS} ]
    do
        LINE="${LINE}#"
        ((counter++))
    done

    echo $DECO
    echo $LINE
    echo $DECO
}

# base
_echo "APT REPOS"
sudo add-apt-repository -y ppa:vincent-c/ponysay
_echo "APT Update"
sudo apt -y update
_echo "APT Install"
sudo apt -y install \
jq zip unzip git-secret neofetch \
git-secret zsh curl nnn ponysay tmux \
libncurses5-dev libncursesw5-dev

_echo "PYTHON (PIP)"
sudo apt -y install python3-dev python3-pip python3-setuptools

_echo "thefuck & TLDR"
sudo pip3 install thefuck tldr

_echo "RUBY (GEM)"
sudo apt -y install ruby-full

_echo "TMUXINATOR"
sudo gem install tmuxinator


# dir tree
_echo "Creating dir tree"
mkdir -p ~/.bin/ch/bin && \
mkdir -p ~/.bin/ch/repos && \
mkdir -p ~/.bin/ch/pkgs && \
mkdir -p ~/.bin/ch/scripts && \
mkdir -p ~/.bin/ch/zip && \
mkdir -p ~/.ssh

export PATH=$PATH:$HOME/.bin/ch/bin

# tmuxinator completion script
wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O ~/.bin/ch/scripts/tmuxinator.zsh

# bitwarden cli
_echo "BITWARDEN CLI"
pushd ~/.bin/ch/zip && \
curl -L "https://vault.bitwarden.com/download/?app=cli&platform=linux" -o bitwarden.zip && \
unzip bitwarden.zip && \
mv bw ~/.bin/ch/bin && \
chmod +x ~/.bin/ch/bin/bw && \
popd

# ssh & gpg keys from bitwarden
_echo "BITWARDEN LOGIN"
bw login --raw > .bwsession && \
export BW_SESSION=`cat .bwsession`

_echo "Importing Keys from Bitwarden"
mkdir -p ~/.ssh && \
pushd ~/.ssh && \
bw get attachment cesn4eg4ekfdtg6vnrrs1pl3f3e2bdjx --raw --itemid b3919757-7ee4-4655-88fd-ab700093b7e7 && \
bw get attachment hxcfvzique0rfvyz2eunjnpjct4n8r76 --raw --itemid b3919757-7ee4-4655-88fd-ab700093b7e7 && \
bw get attachment id_rsa.pub --raw --itemid b3919757-7ee4-4655-88fd-ab700093b7e7 && \
chmod 600 id_rsa && \
chmod 600 id_rsa.ppk && \
chmod 600 id_rsa.pub && \
bw get attachment private.key --raw --itemid e44911b2-b010-49ba-8351-ab72009a24ef && \
bw get attachment public.key --raw --itemid e44911b2-b010-49ba-8351-ab72009a24ef && \ 
gpg --allow-secret-key-import --import private.key && \
rm private.key && \
rm public.key && \
popd

_echo "SSH File Permissions"
chmod 700 ~/.ssh ; \
chmod 644 ~/.ssh/authorized_keys ; \
chmod 644 ~/.ssh/known_hosts ; \
chmod 644 ~/.ssh/config ; \
chmod 600 ~/.ssh/id_rsa ; \
chmod 644 ~/.ssh/id_rsa.pub ; \
chmod 600 ~/.ssh/github_rsa ; \
chmod 644 ~/.ssh/github_rsa.pub ; \
chmod 600 ~/.ssh/mozilla_rsa ; \
chmod 644 ~/.ssh/mozilla_rsa.pub

# nvm
_echo "NVM"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash && \
export NVM_DIR="$HOME/.nvm" && \
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
nvm install node

# bat
_echo "BAT"
pushd ~/.bin/ch/pkgs
wget https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_amd64.deb && \
sudo dpkg -i bat_0.12.1_amd64.deb && \
popd

# fzf
_echo "FZF"
pushd ~/.bin/ch/repos
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.bin/ch/repos/fzf && \
pushd fzf
./install --key-bindings --completion --no-update-rc
popd
popd


# prettyping
_echo "Prettyping"
pushd ~/.bin/ch/bin && \
curl -O https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping && \
chmod +x prettyping && \
popd

# diff-so-fancy
_echo "Diff-so-fancy"
curl -L "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy" -o ~/.bin/ch/bin/diff-so-fancy && \
chmod +x ~/.bin/ch/bin/diff-so-fancy

# fd (fd-find)
_echo "FD"
pushd ~/.bin/ch/pkgs && \
wget https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb && \
sudo dpkg -i fd_7.4.0_amd64.deb && \
popd


# ncdu https://dev.yorhel.nl/download/ncdu-1.14.2.tar.gz
_echo "NCDU"
pushd ~/.bin/ch/zip && \
curl -OL https://dev.yorhel.nl/download/ncdu-1.14.2.tar.gz && \
curl -OL https://dev.yorhel.nl/download/ncdu-linux-x86_64-1.14.2.tar.gz
tar -xzf ncdu-linux-x86_64-1.14.2.tar.gz && \
sudo mv ncdu /usr/bin/ && \
popd

# mdcat (markdown cat)
# pushd ~/.bin/ch/zip && \
# curl -OL https://github.com/lunaryorn/mdcat/releases/download/mdcat-0.15.1/mdcat-0.15.1-x86_64-unknown-linux-musl.tar.gz && \
# tar -xzf mdcat-0.15.1-x86_64-unknown-linux-musl.tar.gz && \
# popd

# exa (ls replacement)
_echo "EXA"
pushd ~/.bin/ch/zip && \
curl -OL https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip && \
unzip exa-linux-x86_64-0.9.0.zip && \
cp exa-linux-x86_64 ~/.bin/ch/bin/exa && \
popd

# tig
_echo "TIG"
pushd ~/.bin/ch/zip && \
curl -OL https://github.com/jonas/tig/releases/download/tig-2.5.0/tig-2.5.0.tar.gz && \
tar -xzf tig-2.5.0.tar.gz && \
pushd ~/.bin/ch/zip/tig-2.5.0 && \
./configure && \
make && sudo make install && \
popd
popd

# gh (github cli)
_echo "Github CLI"
pushd ~/.bin/ch/pkgs && \
curl -OL https://github.com/cli/cli/releases/download/v0.6.1/gh_0.6.1_linux_amd64.deb && \
sudo dpkg -i gh_0.6.1_linux_amd64.deb && \
popd

# docker client
_echo "Docker Client"
sudo apt -y install apt-transport-https ca-certificates gnupg-agent software-properties-common && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
sudo add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" && \
sudo apt -y update && \
sudo apt -y install docker-ce docker-ce-cli containerd.io && \
sudo usermod -aG docker bb

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o ~/.bin/ch/bin/docker-compose
sudo chmod +x ~/.bin/ch/bin/docker-compose

# oc (openshift client)
_echo "Openshift"
pushd ~/.bin/ch/zip && \
curl -OL https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz && \
tar -xzf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz && \
pushd openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit && \
cp kubectl ~/.bin/ch/bin/ && \
cp oc ~/.bin/ch/bin/ && \
popd && \
rm -rf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit && \
rm openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz && \
popd

# /etc/wsl.conf
# [automount]
# root = /
# enabled = true
# options = "metadata,umask=22,fmask=11"

_echo "Configuring WSL Automount"
echo "[automount]\nroot = /\nenabled = true\noptions = \"metadata,umask=22,fmask=11\"" > /etc/wsl.conf

#mount c command
# sudo mount -t drvfs C: /mnt/c -o metadata,uid=1000,gid=1000,umask=027



# change default shell to zsh
# chsh -s $(which zsh)

# install oh-my-zsh
_echo "Installing Oh-my-zsh"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone clonehome
_echo "Cloning clonehome"
pushd ~/.bin/ch/repos && \
git clone git@git.kerrigan.cloud:bmatz/clonehome.git && \
pushd clonehome && \
git secret reveal && \
tar -xzf dotfiles.tar.gz && \
chmod +x ./update-github.sh && \
chmod +x ./sync-up.sh && \
chmod +x ./sync-down.sh && \
chmod +x ./configure-git.sh && \
./sync-down.sh && \
./configure-git.sh && \
popd && \
popd
