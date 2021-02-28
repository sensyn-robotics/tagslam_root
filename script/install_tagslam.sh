#/bin/sh
# TagSLAM installation script
# requirements: OS: Ubuntu18.04 or later
# Author: Masahiro Ogawa @Sensyn-robotics.com
#####

# prepare installation using apt
sudo apt install python-catkin-tools 
sudo apt -y remove gtsam
sudo add-apt-repository -y --remove ppa:bernd-pfrommer/gtsam
sudo apt-add-repository -y ppa:borglab/gtsam-release-4.0
sudo apt update
sudo apt install libgtsam-dev libgtsam-unstable-dev 

# install tagslam root
ROOTDIR=$(dirname $0)/..
cd $ROOTDIR
git submodule update --init --recursive
catkin config -DCMAKE_BUILD_TYPE=Release
catkin build

# extract sample data
bunzip2 src/tagslam_test/tests/*/*.bz2
