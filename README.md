A Virtual Machine for Zojax Development
=======================================

This project automates the setup of a development environment. Use this virtual machine to work on a pull request with everything ready for development.


Before up
=========


On Mac OS X, you do not need to do anything, NFS is already installed.

On Debian/Ubuntu, you just need to install the NFS package:

    $ sudo apt-get install nfs-common nfs-kernel-server


Adding new box
==============


    $ git clone git@github.com:Zojax/zojax-dev-box.git zojaxbox

    $ cd zojaxbox

    $ vagrant up


Mounting code from box
======================


    $ vagrant ssh

    (box) $ sudo tee -a /etc/exports <<<'/home/vagrant/zojax      *(rw,async,all_squash,insecure,anonuid=1000,anongid=1000,no_subtree_check)'>/dev/null

    (box) $ sudo service nfs-kernel-server restart

    (box) $ logout


for your Ubuntu:
----------------

    $ sudo apt-get install nfs-common

    $ mkdir /home/YOUR-USER/workspace/zojax

    $ sudo tee -a /etc/fstab <<<'192.168.33.10:/home/vagrant/zojax  /home/USER/workspace/zojax/files  nfs   rw,async 0 0'>/dev/null

    $ sudo mount /home/YOUR-USER/workspace/zojax


for your MacOS:
---------------

In Finder, go to: `Go → Connect to Server...` and, in the **Server Address box**, enter:

    nfs://192.168.33.10/home/vagrant/zojax


or use nfs manager

    192.168.33.10:/home/vagrant on /Users/USER/workspace/zojax/files (nfs, nodev, nosuid, automounted, noowners)


Copy your ssh Key
=================


Assuming you have SSH keys on your host machine, you should be able to copy them to the VM with

    $ scp ~/.ssh/id_rsa vagrant@192.168.33.10:~/.ssh/id_rsa

*password: vagrant*


git
===


Set up your email in Git:

    (box) $ git config --global user.name "Your Name" # Set your name

    (box) $ git config --global user.email "your-mail@gmail.com" # Set an email


Verify:
-------

    (box) $ git config --global user.email

     your-mail@gmail.com

    (box) $ git config --global user.name

     Your Name


Vagrant
=======


Stop VM:
--------

    $ vagrant halt

    [default] Attempting graceful shutdown of linux...


Start VM again:
---------------

    $ vagrant up


Delete VM:
----------

    $ vagrant destroy
