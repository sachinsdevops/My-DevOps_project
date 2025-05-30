
import subprocess

try:
    # Run the 'ls' command to list files in the current directory
    subprocess.check_output(['ls1'], stderr=subprocess.STDOUT, shell=True)

    # If 'ls' command succeeds, print "Hello, World"
    print("Hello, World2")
except subprocess.CalledProcessError as e:
    # If 'ls' command fails, print the error and exit with a custom exit code
    print(f"Error running 'ls' command: {e.output.decode()}")
    exit_code = 1  # Custom exit code for failure
    exit(exit_code)

# Exit with a custom exit code (e.g., 0) for successful completion
exit_code = 0
exit(exit_code)
