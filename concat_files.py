#!/usr/bin/env python3

"""
Concatenate multiple files together into a single file with file names
This script is used to easily paste entire codebases into LLM context windows

`ln -s ~/code/dotfiles/concat_files.py ~/.bin/concat_files`

Usage: ./concat_files.py rs | pbcopy
"""

import argparse
import os
import sys
from pathlib import Path


def find_files_with_extension(extension, start_path):
    for root, dirs, files in os.walk(start_path):
        for file in files:
            if file.endswith(extension):
                yield os.path.join(root, file)


def main(extension, outfile_path=None):
    # Modify this list as necessary
    skipped_items = ["node_modules", ".git", "venv"]
    start_path = os.getcwd()
    output_stream = open(outfile_path, "w") if outfile_path else sys.stdout
    try:
        for filepath in find_files_with_extension(extension, start_path):
            relative_path = Path(filepath).relative_to(start_path)
            should_skip = any(
                skip_item in str(relative_path).split(os.sep)
                for skip_item in skipped_items
            )
            if not should_skip:
                output_stream.write(f"====== {relative_path}\n")
                with open(filepath, "r") as file:
                    output_stream.write(file.read())
                    output_stream.write("\n")
    finally:
        if outfile_path:
            output_stream.close()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Concatenate files with a given extension into a single output."
    )
    parser.add_argument("extension", type=str, help="File extension to search for.")
    parser.add_argument(
        "outfile_path",
        type=str,
        nargs="?",
        help="Optional path to the output file. Outputs to stdout if not provided.",
    )
    args = parser.parse_args()
    main(args.extension, args.outfile_path)
