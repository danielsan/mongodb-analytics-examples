
## DISCLAIMER

Please note: all tools/ scripts in this repo are released for use "AS IS" without any warranties of any kind, including, but not limited to their installation, use, or performance. We disclaim any and all warranties, either express or implied, including but not limited to any warranty of noninfringement, merchantability, and/ or fitness for a particular purpose. We do not warrant that the technology will meet your requirements, that the operation thereof will be uninterrupted or error-free, or that any errors will be corrected. Any use of these scripts and tools is at your own risk. There is no guarantee that they have been through thorough testing in a comparable environment and we are not responsible for any damage or data loss incurred with their use. You are responsible for reviewing and testing any scripts you run thoroughly before use in any non-testing environment.

## Release Notes

This is an example referenced in [this blog on Hive and Spark](https://www.mongodb.com/blog/post/using-mongodb-hadoop-spark-part-1-introduction-setup).

## Getting the code

    mkdir SOME_DIRECORY
    cd SOME_DIRECORY
    git clone https://github.com/danielsan/mongodb-analytics-examples.git

## Preparing everything
The `setup.sh` script assumes that you already have curl, python, mongodb and Java installed in your system.

Before running the [setup.sh](setup.sh) script I recommend you to see the source code and understand what is it going to do when you run it on your computer.

    cd mongodb-analytics-examples && $SHELL ./setup.sh

## Running the analysis with Spark

Assuming your working directory (your current directory in your shell) is the `mongodb-analytics-examples` one

    ./spark-ohlcbars-example.submit.sh

Tha script will submit `spark-ohlcbars-example.py` to Spark using `spark-submit`
