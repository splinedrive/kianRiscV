#!/usr/bin/python
# Python Script to Generate Hex Data for Verilog
# hexdump -v -e '1/4 "%08x\n"' filename
import sys

def generate_hex_file(input_file, output_file, data_width=4):
    try:
        with open(input_file, 'rb') as infile, open(output_file, 'w') as outfile:
            while True:
                data = infile.read(data_width)
                if not data:
                    break
                # Write data as hex string, padded to the data width
                outfile.write(f"{int.from_bytes(data, byteorder='little'):0{data_width*2}x}\n")
    except IOError as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python generate_hex.py <input_binary_file> <output_hex_file>")
        sys.exit(1)

    input_binary_file = sys.argv[1]
    output_hex_file = sys.argv[2]

    generate_hex_file(input_binary_file, output_hex_file)

