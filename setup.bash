# on one EC-2 window, type the following:
sudo apt update
sudo apt install zip
sudo apt-get install gcc

# we want to install Java for Kafka and Spark
sudo apt install default-jre
sudo apt install default-jdk

# we want to install Miniconda to take care of all our Python problems without
# being the smothering idiot that Anaconda is
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc

# let's install Kafka!
pip install kafka-python
wget http://apache-mirror.8birdsvideo.com/kafka/2.3.0/kafka_2.12-2.3.0.tgz
tar -xzf kafka_2.12-2.3.0.tgz

# ADD THE FOLLOWING TO YOUR ~/.bashrc:
# --------------
# for kafka installation
export PATH=/home/ubuntu/kafka_2.12-2.3.0/bin:$PATH
# --------------
source ~/.bashrc

# set up Github properly to clone the repo:
git clone https://github.com/nathancooperjones/python-kafka-spark-kafka-bigquery-trump.git

# You will need four EC2 windows open, either by making new tabs or using tmux.
# We will refer to these windows as EC2-1, EC2-2, EC2-3, and EC2-4.

# EC2-1:
zookeeper-server-start.sh config/zookeeper.properties &
# *Enter*
kafka-server-start.sh config/server.properties &
# *Enter*

# EC2-2:
python kafka_1_to_kafka_2.py

# EC2-3:
python kafka_2_to_bigquery.py

# EC2-4:
python user_to_kafka_1.py
