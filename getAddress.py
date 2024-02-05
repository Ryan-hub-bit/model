import angr
import struct
import sys
import os


if len(sys.argv) < 2:
        print("Usage: python3 script.py <arg1> <arg1>")
        sys.exit(1)
# binary_path = "./nano_3"
binary_path = sys.argv[1]
binary_folder, filename = binary_path.rsplit("/", 1)
print(binary_path)
project = angr.Project(binary_path, load_options={'auto_load_libs': False})
#print(project.loader.main_object.sections)
target_section_name = ".section_for_indirectcall"
sections = project.loader.main_object.sections
target_section = next((section for section in sections if section.name == target_section_name), None)
if target_section == None:
    print(f"{binary_path}'s target_section is None")
#print(target_section)
data_address = target_section.vaddr
data_size = target_section.memsize
data_as_bytes = project.loader.memory.load(data_address, data_size)
#print(data_as_bytes)
mem_size = 8
mem_set = []
data_arr = [data_as_bytes[i:i+8] for i in range(0, len(data_as_bytes), 8)]
#print(data_arr)
for i in range(len(data_arr)):
	address = struct.unpack('<Q', data_arr[i])[0]
	#print(address)
	mem_set.append(hex(address))
addressFileName = filename + "_address.txt"
addressFile = os.path.join(binary_folder,addressFileName)
with open(addressFile, "w") as file:
	# Write each item in the list to the file
  for item in mem_set:
    file.write(item + "\n")
#print(mem_set)
