#/bin/sh

ROOTDIR=$(dirname "$0")/..
source ${ROOTDIR}/devel/setup.bash
roslaunch tagslam tagslam.launch bag:=`rospack find tagslam`/example/example.bag
