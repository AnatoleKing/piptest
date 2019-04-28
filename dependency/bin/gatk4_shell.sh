#!/bin/bash
# The basic GATK4 pipeline, by Wang Xiaoshan, 2019-04-25

# get options use getopt

fq1=""
fq2=""
dbPath=""
ncpu=4
mem='8G'

function usage() {
    echo "USAGE:"
    echo "  gatk4Pip [-h] [-1 <filename>] [-2 <filename>] [-p <reference_path>]"
    exit 1
}

while getopts :h1:2:p: opt
do
    case "$opt" in
        1)
            fq1=$OPTARG
            ;;
        2)
            fq2=$OPTARG
            ;;
        p)
            dbPath=$OPTARG
            ;;
        h)
            usage
            exit

    esac
done

echo $fq1
# get sample prefix name
prefix=`basename $fq1 | sed "s/_1.fq.gz//"`

# do fastp
fastp1=${prefix}"_fastp_1.fq.gz"
fastp2=${prefix}"_fastp_2.fq.gz"


fastp -w $ncpu --json=$prefix.json --html=$prefix.html -i $fq1 -o $fastp1 -I $fq2 -O $fastp2 2>$prefix.fastp.log && run_stat_check $? "fastp success" "fastp fail"
echo "job done"
echo $pwd


            


