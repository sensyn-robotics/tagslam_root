TagSLAM root repository forked by Sensyn Robotics

# Installation
after clone this repository, run
```
script/install_tagslam.sh
```


# Running tests
### Running quick test
```
script/run_quicktest.sh
```

### Running example online
uncomment "example params" block in run_tagslam.sh, and comment out "your params" block, and run;
```
script/run_tagslam.sh
```

### Running exmaple offline
additionary uncomment SEPARATESTEP=true, and run;
```
script/run_tagslam.sh
```

### Running sensyn example(offline)
- download sensyn sample data directory from [here](https://drive.google.com/drive/folders/18wC4bnkjUd5_4uVqri4q7CJ_v-FB5XAW?usp=sharing).
- uncomment last parameters block in run_tagslam
```
script/run_tagslam.sh
```


# Running extrinsic calibration
- run intrinsic calibration using Kalibr.
- download sensyn sample data directory from [here](https://drive.google.com/drive/folders/18wC4bnkjUd5_4uVqri4q7CJ_v-FB5XAW?usp=sharing).
- create cameras.yaml in data directory.
  - combine all Kalibr calibration output yaml files into tagslam_root/data/cameras.yaml
  - rename camera numbers as continuous (e.g. cam0,cam1,cam2,...)
  - remove tabs from cameras.yaml
  - add these 2 lines to each cam*:
    tagtopic: /cam0/tags
    rig_body: rig
    (cam0 should be changed on its ids.)
- get images of april tag calibraiton board in png format.
- convert it to a .bag file using kalibr_bagcreater and move the bag file to the data directory.
- run
```
script/run_tagslam.sh
```


# reference
original [TagSLAM project](https://berndpfrommer.github.io/tagslam_web).
