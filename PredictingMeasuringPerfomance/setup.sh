#!/bin/bash

# Loads the latest Python module, edit if you prefer a different one
module load python

# Create a Python Virtual Environment for the example
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Download the dataset
python download.py
