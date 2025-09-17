# sim34313setup
Files for setup of the simulation VM for course 34313. The files and scripts assumes an Ubuntu (or derivative) version 24.04 LTS

## Instructions
1. Install git manually (`sudo apt update; sudo apt -y install git`)
2. Clone repo (`git clone https://github.com/lstaalhagen/sim34313setup`)
4. Change dir (`cd sim34313setup`)
5. Edit `env.sh` file and set environment variables to the correct values
6. Run install-system script (`sudo sh ./install-system.sh`)
7. Run install-omnetpp script (`sudo sh ./install-omnetpp.sh`)
8. [Optional] Create a snapshot

## Manual stuff afterwards
1. [Optional] Disable Screensaver
2. [Optional] In Power Manager (Tab = Display), set timeouts to 'never'
3. Guestadditions [Optional]
   - Use 'Install Guest Additions' from VirtualBox menu to mount drive
   - Install using (in terminal) `cd /media/user/VB???? ; sudo sh ./VBoxLinuxAdditions.run`
   - Add user to vboxsf group (`sudo usermod -aG vboxsf user`)
      - Configure shared folder in VM settings when VM shut down
