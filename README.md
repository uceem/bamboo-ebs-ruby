bamboo-ebs-ruby
================

Setup scripts for Elastic Bamboo EBS snapshot for RVM, Ruby, and Rails

Setup:

1. Fire up a Bamboo image and create an attached EBS volume as normal.
2. Login to instance, become root.
3. Modify /mnt/bamboo-ebs/bin/customize-extras.sh to include the line:

    git clone git://github.com/uceem/bamboo-ebs-ruby.git  
    bash /mnt/bamboo-ebs/bamboo-ebs-ruby/customize-ruby.sh  

4. Optionally, run the script (this will make instance load times much faster):

    /mnt/bamboo-ebs/bin/customize-extras.sh  

5. Generate a snapsnot as usual:

    killall java  
    generateSnapshot.sh  

6. Configure Bamboo image to use the new snapshot.


