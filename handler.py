#!/usr/bin/env python
# coding=utf-8

# Modules loader
import sys
import subprocess
import tempfile
from downloader import imageDownloader

## Pass yaml through stdin
url = sys.stdin.read()

## Execute specific command from bash which need the yaml file as filename
with tempfile.NamedTemporaryFile() as temp:
    imageDownloader(url)
    bashCommand = "cp out.jpg "+temp.name
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    bashCommand = "python image-classifier-service/classify_image.py --model_dir image-classifier-service/imagenet/ --image_file "+temp.name
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    print(output)
