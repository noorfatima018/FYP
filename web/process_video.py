import cv2
import numpy as np
import imageio_ffmpeg
import subprocess
import os

def process_video():
    input_path = r"c:\Users\noorf\Desktop\FYP\web\animate_my_logo.mp4"
    output_path = r"c:\Users\noorf\Desktop\FYP\web\public\animate_my_logo.mp4"
    temp_raw_path = r"c:\Users\noorf\Desktop\FYP\web\temp_raw.mp4"

    cap = cv2.VideoCapture(input_path)
    if not cap.isOpened():
        print("Error: Could not open input video.")
        return

    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    fps = cap.get(cv2.CAP_PROP_FPS) or 24.0
    total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))

    print(f"Video Info: {width}x{height} @ {fps} fps, total frames: {total_frames}")

    # Target background color in BGR for #EFE6D5:
    # #EFE6D5 -> R=239, G=230, B=213 -> BGR=(213, 230, 239)
    target_bg_bgr = np.array([213, 230, 239], dtype=np.float32)

    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    out = cv2.VideoWriter(temp_raw_path, fourcc, fps, (width, height))

    frame_count = 0
    while True:
        ret, frame = cap.read()
        if not ret:
            break

        frame_float = frame.astype(np.float32)
        
        # Convert to HSV to analyze brightness and saturation
        hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
        h, s, v = cv2.split(hsv)

        # Background is any light/greyish pixel: V > 165 and S < 50
        # Smooth alpha mask starting at V=150 up to V=195
        v_float = v.astype(np.float32)
        s_float = s.astype(np.float32)

        v_norm = np.clip((v_float - 150.0) / 40.0, 0.0, 1.0)
        s_norm = np.clip(1.0 - (s_float / 50.0), 0.0, 1.0)
        
        alpha_bg = v_norm * s_norm
        # Force full background replacement for anything with V > 190 and S < 35
        full_bg_mask = (v_float > 185) & (s_float < 40)
        alpha_bg[full_bg_mask] = 1.0

        alpha_bg_3ch = np.dstack([alpha_bg, alpha_bg, alpha_bg])

        processed_frame_float = frame_float * (1.0 - alpha_bg_3ch) + target_bg_bgr * alpha_bg_3ch
        processed_frame = np.clip(processed_frame_float, 0, 255).astype(np.uint8)

        out.write(processed_frame)
        frame_count += 1

    cap.release()
    out.release()

    # Convert temp_raw.mp4 to web-compatible H.264 yuv420p MP4 using imageio_ffmpeg
    ffmpeg_exe = imageio_ffmpeg.get_ffmpeg_exe()
    cmd = [
        ffmpeg_exe,
        "-y",
        "-i", temp_raw_path,
        "-c:v", "libx264",
        "-pix_fmt", "yuv420p",
        "-movflags", "+faststart",
        output_path
    ]

    print("Encoding to web-compatible H.264 MP4...")
    subprocess.run(cmd, check=True)
    print(f"H.264 Web Video generated successfully at: {output_path}")

    if os.path.exists(temp_raw_path):
        os.remove(temp_raw_path)

if __name__ == "__main__":
    process_video()
