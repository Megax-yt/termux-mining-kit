# Android-mining-kit
Quick installation of mining on Android Phones

## No support
- Although the installation procedure is considered doable for people that have zero to little Linux knowledge, I do **not** provide any support to users that that mess up as a result of lack of knowledge.
- Reading is an dying art. There's no instruction video for people that can't follow instructions step-by-step.

## Prerequisites
- Some fundamental Linux knowledge is *required*. (do an online coarse!)
- Knowledge about how to operate Linux *screen* is a must.
- Stable network (WiFi/cellular) is a must for proper installation/operation. Be prepared to troubleshoot and fix them yourself.

## Installation instructions
- install andronix(https://play.google.com/store/apps/details?id=studio.com.techriz.andronix&hl=en_US&gl=US) follow its instructions

```bash
curl -o- -k https://raw.githubusercontent.com/Megax-yt/termux-mining-kit/main/install.sh | bash
```
## Usage
```bash
./mine.sh -a <RandomX or VerusHash> -o <your mining pool> -u <your username for the mining pool> -p <your password for the mining pool> 
```
