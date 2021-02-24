#/bin/sh
# ref: https://berndpfrommer.github.io/tagslam_web/getting_started/
#######

usage(){ echo "Usage: $0 [-b bagfile] 
If you don't specify a bag file, it will use the original example.bag file." 1>&2; exit 1; }

while getopts hb: OPT; do
    case $OPT in
	h) usage ;;
	b) BAGFILE=$OPTARG ;;
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
	echo "running tagslam with bagfile=${BAGFILE}"

    	roscore & 
    	rosparam set use_sim_time true
    	sleep 1s
    	roslaunch tagslam sync_and_detect.launch bag:=$BAGFILE

	TAGEXTRACTEDBAGFILE=`rospack find tagslam`/example/example.bag_output.bag
    	rviz -d `rospack find tagslam`/example/tagslam_example.rviz &
    	roslaunch tagslam tagslam.launch bag:=$TAGEXTRACTEDBAGFILE
    	wait
    )
}

runtagslam $BAGFILE

