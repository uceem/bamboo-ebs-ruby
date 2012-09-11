bamboo-ebs-ruby
================

Setup scripts for Elastic Bamboo EBS snapshot for RVM, Ruby, and Rails

Setup:

1. Fire up a Bamboo image and create an attached EBS volume as normal.
2. Login to instance, become root.
3. cd /mnt/bamboo-ebs
4. git clone git://github.com/uceem/bamboo-ebs-ruby.git
5. Modify /mnt/bamboo-ebs/bin/customize-extras.sh to include the line:

    bash /mnt/bamboo-ebs/bamboo-ebs-ruby/customize-ruby.sh 

6. cd /
7. Optionally, run the script (this will make instance load times much faster):

    /mnt/bamboo-ebs/bamboo-ebs-ruby/customize-ruby.sh 

8. Generate a snapsnot as usual:

    killall java 
    generateSnapshot.sh 

9. Configure Bamboo image to use the new snapshot.


