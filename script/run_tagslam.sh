#/bin/sh
# ref: https://berndpfrommer.github.io/tagslam_web/getting_started/
#######

# prepare envs
ROOTDIR=$(dirname $(readlink -f "$0"))/.. # we need absolute path for sync_and_detect_mine.launch
source ${ROOTDIR}/devel/setup.bash

###############
## parameters

# # example params(if you want to use your own, comment out this block, and uncomment next one)
# RVIZFILE=`rospack find tagslam`/example/tagslam_example.rviz
# TAGSLAMLAUNCH="tagslam tagslam.launch"
# APRILTAGLAUNCH="tagslam apriltag_detector_node.launch"
# BAGFILE=`rospack find tagslam`/example/example.bag
# TOPICS=/pg_17274483/image_raw/compressed
# # SEPARATESTEP=true

# # multicam calib example. (but this example send already extracted odometry)
# RVIZFILE=`rospack find tagslam`/example/tagslam_example.rviz
# TAGSLAMLAUNCH="tagslam tagslam.launch"
# APRILTAGLAUNCH="tagslam apriltag_detector_node.launch"
# BAGFILE=${ROOTDIR}/src/tagslam_test/tests/test_2/reference.bag
# TOPICS=""

# your params(you can edit)
RVIZFILE=${ROOTDIR}/script/tagslam.rviz
TAGSLAMLAUNCH=${ROOTDIR}/script/tagslam.launch
APRILTAGLAUNCH=${ROOTDIR}/script/apriltag_detector_node.launch
BAGFILE=${ROOTDIR}/data/images.bag
TOPICS="" # empty to play all topics
# SEPARATESTEP=true
################


# main process
(
    roscore & 
    sleep 3s
    rosparam set use_sim_time true
    rviz -d $RVIZFILE &

    if [ -z $SEPARATESTEP ] ; then # originally called as online 
    	roslaunch ${TAGSLAMLAUNCH} run_online:=true &
    	roslaunch ${APRILTAGLAUNCH} &
	rosrun image_transport republish raw in:=/cam0/image_raw compressed out:=/cam0/image_raw &
    	rosbag play --clock $BAGFILE --topics $TOPICS
    else
	roslaunch ${ROOTDIR}/script/sync_and_detect.launch bag:=$BAGFILE topics:=$TOPICS
	rosparam get topics
	TAGEXTRACTEDBAGFILE=${BAGFILE}_output.bag
    	roslaunch tagslam tagslam.launch bag:=$TAGEXTRACTEDBAGFILE
    fi
    
    wait
)
