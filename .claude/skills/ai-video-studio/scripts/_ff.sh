#!/usr/bin/env bash
# Resolve an ffmpeg binary: PATH first, then the one bundled with the imageio-ffmpeg Python package.
if command -v ffmpeg >/dev/null 2>&1; then
  FF=ffmpeg
else
  FF=$( (py -c "import imageio_ffmpeg;print(imageio_ffmpeg.get_ffmpeg_exe())" 2>/dev/null) \
     || (python3 -c "import imageio_ffmpeg;print(imageio_ffmpeg.get_ffmpeg_exe())" 2>/dev/null) )
fi
if [ -z "$FF" ]; then
  echo "ffmpeg not found. Install ffmpeg, or: pip install imageio-ffmpeg" >&2
  exit 1
fi
