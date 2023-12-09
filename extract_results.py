import os
import pandas as pd

# Function to clean SSIM values
def clean_ssim(value):
    try:
        return float(value.rstrip('.'))
    except ValueError:
        return None

base_dir = "/home/featurize/work/Causal-IR-DIL-main/results_50"  # Replace with the path to your directories

directories = [d for d in os.listdir(base_dir) if os.path.isdir(os.path.join(base_dir, d))]

# DataFrame to store the results
results = pd.DataFrame(columns=["Directory", "PSNR", "SSIM"])

for dir in directories:
    log_file_path = os.path.join(base_dir, dir, "log.txt")

    if not os.path.isfile(log_file_path):
        print(f"log.txt not found in {dir}")
        continue

    try:
        with open(log_file_path, 'r') as file:
            last_line = None
            for line in file:
                last_line = line.strip()
            
            if last_line is None:
                raise ValueError("Empty log file")

            # Parse PSNR and SSIM
            parts = last_line.split(", ")
            if len(parts) < 2:
                raise ValueError("Unexpected format in log file")

            psnr = parts[0].split(": ")[1]
            ssim = clean_ssim(parts[1].split(": ")[1])

            new_row = pd.DataFrame({"Directory": [dir], "PSNR": [psnr], "SSIM": [ssim]})
            results = pd.concat([results, new_row], ignore_index=True)
    except Exception as e:
        print(f"Error processing {dir}: {e}")

results.to_excel("/home/featurize/work/Causal-IR-DIL-main/results_50.xlsx", index=False)
