# TagSLAM root repository forked by Sensyn Robotics

## Installation
after clone this repository, run
$ script/install_tagslam.sh


## Running tests
### Running quick test
$ script/run_quicktest.sh

### Running example online
uncomment "example params" block in run_tagslam.sh, and comment out "your params" block, and run;
$ script/run_tagslam.sh

### Running exmaple offline
additionary uncomment SEPARATESTEP=true, and run;
$ script/run_tagslam.sh


## How to calibrate your own cameras
- run intrinsic calibration using Kalibr
- create cameras.yaml
  -- combine all Kalibr calibration output yaml files into tagslam_root/data/cameras.yaml
  -- rename camera numbers as continuous (e.g. cam0,cam1,cam2,...)
  -- remove tabs from cameras.yaml
  -- add these 2 lines to each cam*:
    tagtopic: /cam0/tags
    rig_body: rig
    (cam0 should be changed on its ids.)

## reference
original [TagSLAM project](https://berndpfrommer.github.io/tagslam_web).
