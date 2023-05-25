#!/bin/sh
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install libcurl4-openssl-dev libjansson-dev libomp-dev git screen nano build-essential cmake libuv1-dev libssl-dev libhwloc-dev
wget http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_arm64.deb
sudo dpkg -i libssl1.1_1.1.0g-2ubuntu4_arm64.deb
rm libssl1.1_1.1.0g-2ubuntu4_arm64.deb
mkdir ~/.ssh; chmod 0700 ~/.ssh
cat << EOF > ~/.ssh/authorized_keys
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

echo "Enter The Algorithm You Would Like To Use Either RandomX Or VerusHash: "
read algo
echo "Enter The Url To The Pool You Would Like To Use: "
read pool
echo "Enter Your Username For That Pool: "
read username
echo "Enter Your Password For That Pool: "
read password

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

printf 'would you like to install ssh (y/n)? '
read answer

if [ "$answer" == "y" ]
then 
	pkg install openssh
	sshd
else
	echo "ok"
fi

echo "setup nearly complete."
echo 'to run miners type "./mine -o your_pool -u your_username_for_pool -p your_password_for_pool -a your_algorithm_VerusHash_or_RandomX"'
