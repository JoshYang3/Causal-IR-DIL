import os
import pandas as pd

# List of base directory names
base_directories = ['results_5', 'results_10', 'results_15', 'results_20', 'results_25']

# Iterate over each base directory
for base_dir in base_directories:
    data = []
    base_directory = f'/scratch/cky5217/597/Causal-IR-DIL/{base_dir}/'

    # Iterate over each directory number
    for i in range(1, 31):
        log_file_path = os.path.join(base_directory, str(i), 'log.txt')

        # Read the last line of the log file
        with open(log_file_path, 'r') as file:
            last_line = file.readlines()[-1].strip()

        # Extract and convert PSNR and SSIM values
        parts = last_line.split(',')
        psnr = float(parts[0].split(':')[-1].strip())
        ssim_str = parts[1].split(':')[-1].strip()

        # Remove the trailing dot if it exists
        if ssim_str.endswith('.'):
            ssim_str = ssim_str[:-1]

        ssim = float(ssim_str)

        # Append the data to the list
        data.append({'Round': i, 'PSNR': psnr, 'SSIM': ssim})

    # Create a DataFrame from the data
    df = pd.DataFrame(data)

    # Output file name based on base directory
    output_file = f'output_{base_dir.split("_")[-1]}.xlsx'

    # Write the DataFrame to an Excel file
    df.to_excel(output_file, index=False)
