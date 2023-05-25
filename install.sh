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
cat << EOF > ~/ccminer/mine.sh
#!/bin/bash

username=""
password=""
pool=""
algo=""

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -u)
            username="$2"
            shift
            ;;
        -p)
            password="$2"
            shift
            ;;
        -o)
            pool="$2"
            shift
            ;;
        -a)
            algo="$2"
            if [[ "$algo" != "RandomX" && "$algo" != "VerusHash" ]]; then
                echo "Invalid algorithm. Only RandomX and VerusHash are currently allowed."
                exit 1
            fi
            shift
            ;;
        *)
            # Unknown option or argument
            echo "Unknown option or argument: $key"
            exit 1
            ;;
    esac

    shift
done

if [[ -z "$username" || -z "$password" || -z "$pool" || -z "$algo" ]]; then
    echo "Username, password, pool, and the algo options are all required."
    exit 1
fi

echo "Username: $username"
echo "Password: $password"
echo "Pool: $pool"
echo "Algo: $algo"

if [[ "$algo" = "RandomX"]]; then
	cd xmrig
	cd build
	clear
	./xmrig -o $pool -u $username -p $password
fi
if [[ "$algo" = "VerusHash"]]; then
	cd ccminer
	./ccminer -a verus -o $pool -u $username -p $password
fi

EOF

git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build
cd build
cmake ..
make
cd
clear

read -p "Do you want to enable ssh? (y/n) Default(No) : " response
response=${response,,}
if [[ $response == "y" || $response == "yes" ]]; then
    pkg install openssh
    sshd
elif [[ $response == "n" || $response == "no" ]]; then
else
    echo "Invalid response. Please enter 'y' for yes or 'n' for no."
fi
echo "setup nearly complete."
echo 'to run miners type "./mine -o your_pool -u your_username_for_pool -p your_password_for_pool -a your_algorithm_VerusHash_or_RandomX"'
