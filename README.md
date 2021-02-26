# TagSLAM root repository forked by Sensyn Robotics

## Installation
after clone this repository, run
$ script/install_tagslam.sh


## Running tests
### Running quick test
$ script/run_quicktest.sh

### Running example offline
$ script/run_example_offline.sh

### Running exmaple online
$ script/run_tagslam_online.sh


## How to calibrate your own cameras
- run intrinsic calibration using Kalibr
- create cameras.yaml
  -- combine all Kalibr calibration output yaml files into tagslam_root/data/cameras.yaml
  -- rename camera numbers as continuous (e.g. cam0,cam1,cam2,...)
  -- remove tabs from cameras.yaml
  -- add these 2 lines to each cam*:
  tagtopic: /detector/tags
  rig_body: rig    	 


## reference
original [TagSLAM project](https://berndpfrommer.github.io/tagslam_web).
