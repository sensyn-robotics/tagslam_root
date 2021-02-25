#/bin/sh
# ref: https://berndpfrommer.github.io/tagslam_web/getting_started/
#######

# prepare envs
ROOTDIR=$(dirname "$0")/..
source ${ROOTDIR}/devel/setup.bash

###############
## parameters
# example params(if you want to use your own, comment out this block, and uncomment next one)
#BAGFILE=`rospack find tagslam`/example/example.bag
#TOPICS=/pg_17274483/image_raw/compressed
#IMAGES_ARE_COMPRESSED=true

# multicam calib example
BAGFILE=${ROOTDIR}/src/tagslam_test/tests/test_6/reference.bag
TOPICS=""

# # your params(you can edit)
# #SEPARATESTEP=true
# BAGFILE=${ROOTDIR}/data/images.bag
# TOPICS=/cam0/image_raw
# IMAGES_ARE_COMPRESSED=false
################


# main process
(
    roscore & 
    sleep 3s
    rosparam set use_sim_time true
    rviz -d `rospack find tagslam`/example/tagslam_example.rviz &

    if [ -z $SEPARATESTEP ] ; then # originally called as online 
    	roslaunch ${ROOTDIR}/script/tagslam_mine.launch run_online:=true has_compressed_images:=$IMAGES_ARE_COMPRESSED &
    	roslaunch tagslam apriltag_detector_node.launch &
    	rosbag play --clock $BAGFILE --topics $TOPICS
    else
	roslaunch ${ROOTDIR}/script/sync_and_detect_mine.launch bag:=$BAGFILE topics:=$TOPICS images_are_compressed:=$IMAGES_ARE_COMPRESSED
	rosparam get topics
	TAGEXTRACTEDBAGFILE=${BAGFILE}_output.bag
    	roslaunch tagslam tagslam.launch bag:=$TAGEXTRACTEDBAGFILE
    fi
    
    wait
)

