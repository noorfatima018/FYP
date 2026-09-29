import cv2
import numpy as np
import imageio_ffmpeg
import subprocess
import os

def process_transparent_video():
    input_path = r"c:\Users\noorf\Desktop\FYP\web\animate_my_logo.mp4"
    webm_output_path = r"c:\Users\noorf\Desktop\FYP\web\public\animate_my_logo.webm"
    mp4_white_output_path = r"c:\Users\noorf\Desktop\FYP\web\public\animate_my_logo.mp4"
    
    temp_png_dir = r"c:\Users\noorf\Desktop\FYP\web\temp_frames"
    os.makedirs(temp_png_dir, exist_ok=True)

    cap = cv2.VideoCapture(input_path)
    if not cap.isOpened():
        print("Error: Could not open input video.")
        return

    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    fps = cap.get(cv2.CAP_PROP_FPS) or 24.0
    total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))

    print(f"Video Info: {width}x{height} @ {fps} fps, total frames: {total_frames}")

    frame_count = 0
    while True:
        ret, frame = cap.read()
        if not ret:
            break

        frame_float = frame.astype(np.float32)
        
        # Convert to HSV to analyze brightness and saturation
        hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
        h, s, v = cv2.split(hsv)

        v_float = v.astype(np.float32)
        s_float = s.astype(np.float32)

        # Background mask calculation
        v_norm = np.clip((v_float - 150.0) / 45.0, 0.0, 1.0)
        s_norm = np.clip(1.0 - (s_float / 45.0), 0.0, 1.0)
        
        alpha_bg = v_norm * s_norm
        full_bg_mask = (v_float > 180) & (s_float < 40)
        alpha_bg[full_bg_mask] = 1.0

        # Alpha for foreground logo (1.0 = logo, 0.0 = transparent background)
        alpha_fg = 1.0 - alpha_bg
        alpha_fg_255 = (alpha_fg * 255.0).astype(np.uint8)

        # Build BGRA 4-channel image with true transparency
        b, g, r = cv2.split(frame)
        bgra_frame = cv2.merge([b, g, r, alpha_fg_255])

        frame_filename = os.path.join(temp_png_dir, f"frame_{frame_count:04d}.png")
        cv2.imwrite(frame_filename, bgra_frame)
        frame_count += 1

    cap.release()
    print(f"Saved {frame_count} RGBA PNG frames.")

    ffmpeg_exe = imageio_ffmpeg.get_ffmpeg_exe()

    # 1. Generate Transparent WebM (VP9 + yuva420p)
    cmd_webm = [
        ffmpeg_exe,
        "-y",
        "-framerate", str(fps),
        "-i", os.path.join(temp_png_dir, "frame_%04d.png"),
        "-c:v", "libvpx-vp9",
        "-pix_fmt", "yuva420p",
        webm_output_path
    ]
    print("Encoding transparent WebM video...")
    subprocess.run(cmd_webm, check=True)
    print(f"Transparent WebM created at: {webm_output_path}")

    # 2. Generate Pure White MP4 (for mix-blend-multiply fallback)
    # Background replaced with pure white (255, 255, 255)
    temp_raw_mp4 = r"c:\Users\noorf\Desktop\FYP\web\temp_raw.mp4"
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    out_mp4 = cv2.VideoWriter(temp_raw_mp4, fourcc, fps, (width, height))

    white_bg_bgr = np.array([255, 255, 255], dtype=np.float32)

    for i in range(frame_count):
        frame_filename = os.path.join(temp_png_dir, f"frame_{i:04d}.png")
        img_rgba = cv2.imread(frame_filename, cv2.IMREAD_UNCHANGED)
        
        rgb = img_rgba[:, :, :3].astype(np.float32)
        alpha = (img_rgba[:, :, 3].astype(np.float32) / 255.0)[:, :, np.newaxis]

        # Blend over pure white
        white_blended = rgb * alpha + white_bg_bgr * (1.0 - alpha)
        out_mp4.write(np.clip(white_blended, 0, 255).astype(np.uint8))

    out_mp4.release()

    cmd_mp4 = [
        ffmpeg_exe,
        "-y",
        "-i", temp_raw_mp4,
        "-c:v", "libx264",
        "-pix_fmt", "yuv420p",
        "-movflags", "+faststart",
        mp4_white_output_path
    ]
    print("Encoding web-standard MP4 video...")
    subprocess.run(cmd_mp4, check=True)
    print(f"Pure White MP4 created at: {mp4_white_output_path}")

    # Clean up temp folder
    import shutil
    shutil.rmtree(temp_png_dir, ignore_errors=True)
    if os.path.exists(temp_raw_mp4):
        os.remove(temp_raw_mp4)

if __name__ == "__main__":
    process_transparent_video()
