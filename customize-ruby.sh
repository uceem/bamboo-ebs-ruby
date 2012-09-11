#!/bin/bash

echo "Beginning Ruby customization"
date

# We need some extra stuff

yum -q -y update
yum -q -y install patch bash awk sed grep which tar curl gunzip bunzip git subversion gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel  make bzip2 iconv-devel libxslt-devel sqlite-devel zlib-static
#yum -y install openssl-devel

# Workaround problem installers

mv /usr/bin/less /usr/bin/less.dist
printf "#!/bin/sh\nexit 0\n" > /usr/bin/less
chmod a+x /usr/bin/less

# Let's get ruby!  (Most of this will be precompiled if you run this once before making the snapshot)

export rvm_path=/usr/local/rvm
rm -f /usr/local/rvm
mkdir /mnt/bamboo-ebs/rvm 2>/dev/null
ln -s /mnt/bamboo-ebs/rvm /usr/local/rvm
curl -L https://get.rvm.io | grep -v 'builtin read' >/tmp/rvm.install.sh
su bamboo -c "cat /tmp/rvm.install.sh | sudo bash -s stable --ruby"
source /etc/profile.d/rvm.sh
rvm install 1.9.2
rvm use 1.9.2  ## stick with the default ruby at heroku

# Restore less

rm -f /usr/bin/less
mv /usr/bin/less.dist /usr/bin/less

# All done!

date
touch /tmp/customize-ruby.done
echo "Finished Ruby customization"
exit 0

