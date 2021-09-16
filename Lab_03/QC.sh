#!/bin/bash

for FastQ in ./FastQ/*fastq
do
    fastqc -t 8 $FastQ
done
