#!/usr/bin/python
def split_hex_file(input_file, output_prefix):
    with open(input_file, 'r') as infile:
        lines = infile.readlines()

    # Open output files for each byte
    out_files = [
        open(f"{output_prefix}0.hex", 'w'),
        open(f"{output_prefix}1.hex", 'w'),
        open(f"{output_prefix}2.hex", 'w'),
        open(f"{output_prefix}3.hex", 'w')
    ]

    for line in lines:
        #print(f"Processing line: {line.strip()}")  # Print the line being processed
        # Split the line into space-separated hex values
        hex_values = line.split()
        for hex_value in hex_values:
            # Split the 32-bit hex value into four 8-bit values
            bytes_data = [hex_value[i:i + 2] for i in range(0, len(hex_value), 2)]
            for i, byte in enumerate(reversed(bytes_data)):
                #print(f"Writing byte {byte} to firmware{i}.hex")  # Debugging output
                out_files[i].write(f"{byte}\n")

    # Close all output files
    for f in out_files:
        f.close()

    print("Splitting completed. Check the output files.")

# Usage
split_hex_file('firmware.hex', 'bootloader')
