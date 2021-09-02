# UOG ML Bioinformatics Course 2021

## Command Reference

### Most Linux tools/programs are documented with man pages:
```
man		# display manual for a command
		man program
		q	quits te manual page
		/	allows searching manual page for patterns
		n	moves to the next hit of the pattern search
		p	moves to the previous hit of the pattern search
```

### Basic commands to navigate the file system:
```
pwd		# display the path name of the current working directory

cd		# change a current directory to a new directory
		.  (dot)	 	current directory
		.. (dot dot) 	parent diretory
		~ 			home directory
      
ls		# list names of directories and files
		-a	list hidden files
		-l 	list detailed info about directory and file
		-h 	display size of files in human readable format
		-r	reverse order while sorting
		-S	sort by file size, largest first
		-t	sort by modification time, newest first
       
mkdir		# create a directory
		-p	create parent directories, as necessary
	
rm		# remove a file
		-r	recursive, wll delete directories and their contents
		-v	verbose output

cp		# copy a file to another
		-r	(recursive) to copy a directory and its subdirectory to another
		-v verbose output
      
mv 		# move or rename files (and directories)

```

### Archived and Compressed Files

You will encounter various forms of archives, compressed and uncompressed, when working in the shell. Below are examples of how to uncompress files with the extensions .tar, .tar.gz, and .tar.bz2. It is easy to create a tar archive (a tarball) and examples are given. For gzip and zip archives I only outlined how to uncompress them.


#### tar archives
```bash
tar xvf foo.tar
## unpacks the archive foo.tar
tar xvfz foo.tar.gz
## unpacks and uncompresses the compressed archive foo.tar.gz
tar cvzf foo.tar.gz foo1.txt foo2.txt
## compresses and archives the files foo1.txt and foo2.txt into foo.tar.gz
tar cvzf foo.tar.gz dir1 dir2
## same as above but applied to the directories dir1 and dir2
tar xvfj foo.tar.bz2
## sometimes tar archives come compressed using bzip2
## this is how you uncompress these archives
```

You may sometimes see a tar archive with a .tgz extension. This is equivalent to a tar.gz extension and should be treated identically.

To look at the files in a tar archive without uncompressing use:

```bash
tar -tf yourfile.tar
```

#### gzip Archives

```bash
gunzip foo.gz
## uncompresses the gzip archive foo.gz
gzip foo.tar
## compress foo.tar -- results in foo.tar.gz
```

#### zip Archives

```bash
unzip foo.zip
## uncompresses foo.zip
```

### Working on Remote Machines

#### SSH - secure shell

Steve and Casey's book "Practical Computing for Biologists" has a whole chapter dedicated to working on remote servers. Below are some useful/essential things.

First of all we need to get to the remote server. For this we'll generally use secure shell (ssh), which is installed on pretty much all Unix and Unix-like systems. SSH let's you establish an encrypted connection to a remote machine through which you can securely transmit data.

In its most basic form you log into a remote machine as follows:

```bash
ssh user@server
```

Here, server can be a domain name (e.g., uog.edu or a straight IP address). You can set the -v flag for ssh which turns on the verbose mode. Even though you don't have to set it, it'll allow you trouble-shooting your connection in case you cannot connect. user@server is simply your authorized user name at the remote machine and the IP, public DNS, or other webaddress of the server you want to connect to.

There are many more possibilities of what can be done with ssh and the example above is the most basic usage for ssh.

#### SCP - secure copy

scp allows you to copy data from and to remote servers to your local computer. It uses the same authentication as ssh and the ssh protocol. So your data gets encrypted and safely transmitted through the network. It's operation is very similar to ssh.

Here are three examples of things that you may want to do frequently:

1) Copy a file from your local computer to some path on a remote computer.

```bash
scp /some/path/to.file user@server:/path/
```

2) Copy a file from a remote server to your local computer.

```bash
scp user@server:/some/path/to.file /path/
```

3) Copy a whole directory and its contents from your local computer to the remote machine.

```bash
scp -r /some/path/with/files/in/it user@server:/path/
```

In the last example the -r flag stands for recursion which means that scp (in the same manner as cp) will recurse into te directory and copy all subfolders and files contained in the folder. To get a folder from the remote machine to your local computer just use the syntax of example 2 and add the -r flag.

Rsync has many advantages over scp for copying files across networks. In particular, rsync will pick up your file transfer where you left off should the network connection get disrupted; scp does not do this! Rsync's real power lies in enabling synchronization of directories across networks for recurring backups. For now read the manual on rsync and check the web for your particular need. Beware that scp does not seem to care much about whether or not there is a trailing / in teh command. Rsync does create the directory in question when the path is followed by / but doesn't create it when you omit the /.

#### WGET - downloading files from ftp and http directly from the shell/terminal

Wget allows you to download files and folders from ftp and http sites from the terminal. This is particularly useful when you are working on a remote server and don't have access to any of your GUI tools.

You can simply download a file from an anonymous ftp site or http site by typing the following:

```bash
wget ftp://server/path/to.file
 
wget http://server/path/to.file
``` 

In case an ftp site requires you to log in using user and password:

```bash
wget ftp://user:password@server/path/to.file
```

If you're after a whole directory from an ftp site you have two options. The first one is to use ftp -r which sets wget to use recursion similar to scp and cp. The recursions depths is only 5 directories deep, however. If the directory tree you're trying to download has more than 5 nodes you could use the -m (mirror) flag.

```bash
wget -r ftp://user:password@server/some/path/
  
wget -m ftp://user:password@server/some/path/
```

Some websites like SourceForge redirect your request (e.g., in a browser a new tab or window with your download will pop up). In such cases wget will not be able to download your file. Curl, however, can if you tell it to follow the link with the -O flag. Note that curl is not part of the Bourne Again Shell (Bash, which is the default shell on most systems these days). So you may have to install it if you need it.

```bash
curl -O http:/server/path/to/file
```
