import os

def collect_dart_files(output_file):
    with open(output_file, 'w', encoding='utf-8') as out_file:
        for root, _, files in os.walk('.'): 
            for file in files:
                if file.endswith('.dart'): 
                    try:
                        file_path = os.path.join(root, file)
                        with open(file_path, 'r', encoding='utf-8') as in_file:
                            out_file.write(f"{file}\n") 
                            out_file.write(in_file.read() + "\n")
                    except Exception as e:
                        print(f"Error reading {file}: {e}")

script_dir = os.path.dirname(os.path.abspath(__file__))
output_file = os.path.join(script_dir, "dart_files_output.txt")
collect_dart_files(output_file)
print(f"Collected .dart file contents saved to {output_file}")
