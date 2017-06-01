#!/usr/bin/env bash
# requirements: brew install ffmpeg && brew install gifsicle

# max size for target bounds rect (MAX_SIZE x MAX_SIZE) - video will be rescaled to fit it.
# default value is 512.
maxSize=512

while getopts ":s:" opt; do
    case $opt in
        s)
            maxSize=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
  esac
done

shift $(($OPTIND - 1))

if [ "$1" == "" ]
then
    echo 'Usage: [sh] video2gif [-s size] path-to-video'
    exit 1
fi
if ! [[ "$maxSize" =~ ^[0-9]+$ && "$maxSize" > 0 ]]
then
    echo 'Size parameter should be positive integer number.' >&2
    exit 1
fi

name="$(basename "$1")"
ffmpeg -i "$1" -hide_banner -vf scale=w=$maxSize:h=$maxSize:force_original_aspect_ratio=decrease -r 10 -f gif - | gifsicle --optimize=3 --delay=10 --careful --dither > "${name%.*}.gif"