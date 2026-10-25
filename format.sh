# Define the path to the Verible formatting binary
VERIBLE_BIN="/home/alejandro-armenta/verible-v0.0-4296-g0f262651-linux-static-x86_64/verible-v0.0-4296-g0f262651/bin/verible-verilog-format"

# Format all SystemVerilog files (.sv and .svh) in the source directory in-place
find ./src -type f \( -name "*.sv" -o -name "*.svh" \) -exec "$VERIBLE_BIN" --inplace {} +

# Format all SystemVerilog files (.sv and .svh) in the simulation directory in-place
find ./sim -type f \( -name "*.sv" -o -name "*.svh" \) -exec "$VERIBLE_BIN" --inplace {} +
