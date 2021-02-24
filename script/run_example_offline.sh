#/bin/sh
# ref: https://berndpfrommer.github.io/tagslam_web/getting_started/
#######

runtagslam() {
    ROOTDIR=$(dirname "$0")/..
    (
	source ${ROOTDIR}/devel/setup.bash

	roscore &
	rosparam set use_sim_time true
	sleep 1s
	rviz -d `rospack find tagslam`/example/tagslam_example.rviz &
	roslaunch tagslam tagslam.launch bag:=`rospack find tagslam`/example/example.bag
	rosservice call /tagslam/replay
	wait
    )
}

runtagslam

