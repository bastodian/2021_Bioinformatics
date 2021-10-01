#!/bin/bash

# Fetch Trinity and compile plugins
wget https://github.com/trinityrnaseq/trinityrnaseq/releases/download/Trinity-v2.13.2/trinityrnaseq-v2.13.2.FULL.tar.gz
tar xvzf trinityrnaseq-v2.13.2.FULL.tar.gz && cd trinityrnaseq-v2.13.2 && make 
