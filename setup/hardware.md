# Hardware configuration
## webcam
- devices are listed under /dev/video*
- ```install v4l2-utils```
    - show devices: ```v4l2-ctl --list-devices```
    - show capture format of device: ```v4l2-ctl --list-formats -device /dev/video[N]```
- related software:
    - ```install cheese```
    - ```install vlc```
	    - start instance: ```vlc v4l2:///dev/video[N]```
