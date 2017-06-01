# Convert video file to gif animation
This script will convert video file to optimized gif with fixed 10fps framerate.

## Usage
You can run script through "sh" or set "+x" attribute with "chmod":
```
sh video2gif.sh video1.mov
```
You can set target max size for both dimensions with optional parameter (by default 512 will be used):
```
sh video2gif.sh -s 1024 video1.mov
```