#/bin/sh
# ref: https://berndpfrommer.github.io/tagslam_web/getting_started/
#######

usage(){ echo "Usage: $0 [-b bagfile] [-t topicname] 
If you don't specify a bag file, it will use the original example.bag file." 1>&2; exit 1; }

while getopts hb:t: OPT; do
    case $OPT in
	h) usage ;;
	b) BAGFILE=$OPTARG ;;
	t) TOPICS=$OPTARG ;;
	*) break ;;
    esac
done
shift $((OPTIND - 1))

runtagslam() {
    ROOTDIR=$(dirname "$0")/..
    (
    	source ${ROOTDIR}/devel/setup.bash
	
	BAGFILE=$1
	BAGFILE=${BAGFILE:=`rospack find tagslam`/example/example.bag}
	TOPICS=$2
	TOPICS=${TOPICS:=/pg_17274483/image_raw/compressed}
	
	echo "run tagslam with bagfile=${BAGFILE}, topics=${TOPICS}"

    	roscore & 
    	rosparam set use_sim_time true
    	sleep 1s
    	roslaunch tagslam tagslam.launch run_online:=true &
    	roslaunch tagslam apriltag_detector_node.launch &
    	rviz -d `rospack find tagslam`/example/tagslam_example.rviz &
    	rosbag play --clock $BAGFILE --topics $TOPICS
    	wait
    )
}

runtagslam $BAGFILE $TOPICS

