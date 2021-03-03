#/bin/sh
# ref: https://berndpfrommer.github.io/tagslam_web/getting_started/
#######

# prepare envs
ROOTDIR=$(dirname $(readlink -f "$0"))/.. # we need absolute path for sync_and_detect_mine.launch
source ${ROOTDIR}/devel/setup.bash

###############
## parameters

# # # example params(if you want to use your own, comment out this block, and uncomment next one)
# LAUNCHDIR="`rospack find tagslam`/launch"
# RVIZFILE=`rospack find tagslam`/example/tagslam_example.rviz
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
LAUNCHDIR=${ROOTDIR}/script
RVIZFILE=${LAUNCHDIR}/tagslam.rviz
BAGFILE=${ROOTDIR}/data/images.bag
TOPICS="" # empty to play all topics
SEPARATESTEP=true
RESULTDIR=${ROOTDIR}/result/20210302_slow
################

TAGSLAMLAUNCH=${LAUNCHDIR}/tagslam.launch
APRILTAGLAUNCH=${LAUNCHDIR}/apriltag_detector_node.launch
SYNCDETLAUNDH=${LAUNCHDIR}/sync_and_detect.launch

# main process
# (
#     roscore & 
#     sleep 3s
#     rosparam set use_sim_time true
#     rviz -d $RVIZFILE &

#     if [ -z $SEPARATESTEP ] ; then # originally called as online 
#     	roslaunch ${TAGSLAMLAUNCH} run_online:=true &
#     	roslaunch ${APRILTAGLAUNCH} &
#     	rosbag play --clock $BAGFILE --topics $TOPICS
#     else
# 	roslaunch ${SYNCDETLAUNDH} bag:=$BAGFILE topics:=$TOPICS
# 	TAGEXTRACTEDBAGFILE=${BAGFILE}_output.bag
#     	roslaunch ${TAGSLAMLAUNCH} bag:=$TAGEXTRACTEDBAGFILE
#     fi
    
#     wait
# )

# copy result
if [ -z ${RESULTDIR} ]; then exit 0; fi

mkdir -p ${RESULTDIR}

RESULTFILES="camera_poses.yaml calibration.yaml poses.yaml error_map.txt 
tag_corners.txt tag_diagnostics.txt time_diagnostics.txt out.bag"
for f in ${RESULTFILES}
do
    cp ~/.ros/$f ${RESULTDIR}
done
