#!/bin/bash

# Loads the latest Python module, edit if you prefer a different one
module load python

python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

python download.py
