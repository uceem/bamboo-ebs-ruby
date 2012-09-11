#!/bin/bash

echo "Beginning Ruby customization"
date

# We need some extra stuff

yum -q -y update
yum -q -y install patch bash awk sed grep which tar curl gunzip bunzip git subversion gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel  make bzip2 iconv-devel libxslt-devel sqlite-devel zlib-static postgresql postgresql-devel postgresql-libs postgresql-server gnupg gnupg2 gpgme gpgme-devel libgpg-error
#yum -y install openssl-devel

# yum install openssl-devel is broken on Atlassian's image
yum -q -y install keyutils-libs-devel krb5-devel libcom_err-devel libselinux-devel libsepol-devel
#if [ ! -d /mnt/bamboo-ebs/openssl ]; then
#	cd /media/ephemeral0
#	wget http://www.openssl.org/source/openssl-1.0.0i.tar.gz
#	tar xzvf openssl-1.0.0i.tar.gz
#	cd openssl-1.0.0i
#	./config --prefix=/mnt/bamboo-ebs/openssl
#	make -j8
#	make install
#fi

# Workaround problem installers that don't honor the PAGER env variable

mv /usr/bin/less /usr/bin/less.dist
printf "#!/bin/sh\nexit 0\n" > /usr/bin/less
chmod a+x /usr/bin/less

# Let's get ruby!  (Most of this will be precompiled if you run this once before making the snapshot)

export rvm_path=/usr/local/rvm
rm -f /usr/local/rvm
mkdir /mnt/bamboo-ebs/rvm 2>/dev/null
ln -s /mnt/bamboo-ebs/rvm /usr/local/rvm
curl -L https://get.rvm.io | grep -v 'builtin read' | bash -s stable
source /etc/profile.d/rvm.sh
rvm pkg install openssl  ## remove this if yum install openssl-devel ever starts working
rvm install 1.9.3 --with-openssl-dir=$rvm_path/usr
rvm install 1.9.2 --with-openssl-dir=$rvm_path/usr
rvm use --default 1.9.2  ## stick with the default ruby at heroku

# Restore less

rm -f /usr/bin/less
mv /usr/bin/less.dist /usr/bin/less

# All done!

date
touch /tmp/customize-ruby.done
echo "Finished Ruby customization"
exit 0

