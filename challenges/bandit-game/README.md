# Bandit game level answers

# Bandit Walkthrough

## Bandit level 1 -> 2
- Typed `ls` and saw 'readme' file
- `cat readme` to read the file
- Password is `ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If`

## Bandit level 2 -> 3
- Typed `ls` and saw '-' file
- `cat < -` to read the file
- Password is `263JGJPfgU6LtdEvgfWU1XP5yac29mFx`

## Bandit level 3 -> 4
- Typed `ls` and saw 'spaces in this filename' file
- `cat 'spaces in this filename'` to read the file
- Password is `MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx`

## Bandit level 4 -> 5
- `ls` showed another directory 'inhere'
- `cd inhere` to enter that directory
- `ls -a` shows all files in the directory and revealed the hidden file '...Hiding-From-You'
- `cat Hiding-From-You` to open the file
- Password is `2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ`

## Bandit level 5 -> 6
- `ls inhere` to enter the directory
- `file ./*` to show all the files, file07 listed as ASCII text and the rest data
- `cat ./-file07` to show the contents
- Password is `4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw`

## Bandit level 6 -> 7
- `cd inhere` to enter the directory
- `ls` showed many directories
- `find -size 1033c` (c for bytes) returned the file location /maybehere07/.file2
- `cat .file2` to read the file
- Password is `HWasnPhtq9AVKe0dmk45nxy20cvUa6EG`

## Bandit level 7 -> 8
- `ls` did not show anything
- Started with `find / type -f size 33c` which returned a lot of permission denied errors
- Added `find /-type f -size 33c -user bandit7 -group bandit6` which also produced similar output
- Added `2>/dev/null` to the end of the command which will hide any error messages 
- Returned `/var/lib/dpkg/info/bandit7.password`
- `cat /var/lib/dpkg/info/bandit7.password` to read the file
- Password is `morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj`

## Bandit level 8 -> 9
- `ls` and `cat data.txt` revealed a big txt file with words and a password-like string on each line
- `grep millionth` would give me the line but needs to be done along with `cat data.txt`
- `cat data.txt | grep millionth` returns the line
- Password is `dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc`

## Bandit level 9 -> 10
- Used `sort data.txt` to sort the file and then piped into `uniq -u` to get the unique line that only appears once
- Password is `4CKMh1JI91bUIZZPXDqGanal4xvAg0JM`

## Bandit level 10 -> 11
- Used `strings` command to find the human-readable strings in the file
- Since it is preceded by '=' characters, `grep` is needed to filter the results
- `strings data.txt | grep ==` returns a few lines including the password
- Password is `FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey`

## Bandit level 11 -> 12
- `cat data.txt` shows the contents of the file which is encoded in base64
- `base64` command lets you encode and decode in base64
- Adding a -d to the command will signal to decode
- `base64 -d data.txt` decodes the file and shows the password
- Password is `dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr`

## Bandit level 12 -> 13
- A ROT13 cipher is used on the contents on data.txt, so we can use `tr` to substitute letters
- ROT13 maps A->N, B->O, … etc until Z->M
- `cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'` will decode it
- Password is `7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4`

## Bandit level 13 -> 14
- Use `mktemp -d` to create a temporary directory to manipulate a copy of the data.txt file
- `mv data.txt hexdump_data` to rename the copy of the file in the temp directory
- `xxd -r hexdump_data compressed_data` to create a new copy of the file with reverted hexdump
- `cat hexdump_data` shows that the first bytes of the file are '1f8b 08' which says the file is gzip compressed
- `mv compressed_data compressed_data.gz` adds the correct file ending
- `gzip -d compressed_data.gz` decompresses the file
- The file is still not fully decompressed, reading the file again shows the first bytes are '425a 68' which is bzip2
- Same steps to decompress as before but with the file ending .bz2 and the `bzip2 -d` command
- xxd shows it is still compressed but with gzip again, so the same steps to decompress
- Reading the file again shows it has a string 'data5.bin' suggesting an archive
- Same steps to extract as before except with .tar filename and `tar -xf` command
- A new file 'data5.bin' is extracted, which is another archive we can use `tar -xf` on
- Gives a new 'data6.bin' file which is bzip2 compressed
- After decompressing, it is another archive which needs `tar -xf`
- Extracting gives 'data8.bin' which is gzip compressed
- After another `gzip -d data8.gz` the file is decompressed
- Password is `FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn`

## Bandit level 14 -> 15
- ls shows the sshkey.private file
- Using command `ssh -i sshkey.private bandit14@localhost -p 2220` lets us login to bandit14
- `cat /etc/bandit_pass/bandit14` shows the password
- Password is `MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS`

## Bandit level 15 -> 16
- Use `nc localhost 30000` to connect
- Paste previous password in
- Success message appears along with the next password
- Password is `8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo`

## Bandit level 16 -> 17
- Used command `ncat -ssl localhost 30001`
- Submitted previous password
- 'Correct!' message appears with the next password
- Password is `kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx`

## Bandit level 17 -> 18
- Using the command `nmap localhost -p 31000-32000` will return a list of all ports with a server listening
- Returns 5 ports, using `ncat --ssl localhost *PORT NUMBER*` on each port will allow me to check each one
- The correct one was the port 31790, which after pasting in the previous password returns an RSA private key which can be used to login to the next level
- Saved the RSA key to a file called 'pvt.key' and used it to login to the next level
- Password is `EReVavePLFHtFlFsjn3hyzMlvSuSAcRD`

## Bandit level 18 -> 19
- `ls` shows passwords.new and passwords.old files
- We can use `diff` command to get the differences
- It returned 2 different potential passwords:
  ```
  < x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
  ---
  > ktfgBvpMzWKR5ENj26IbLGSblgUG9CzB
  ```
- The first password worked, but kicked me out with a 'Byebye!' message
- Password is `x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO`

## Bandit level 19 -> 20
- Since the machine boots you out when you try and log in, we need to execute commands through ssh instead of trying to log in
- `ssh bandit18@bandit.labs.overthewire.org -p 2220 ls` shows a file called readme
- We repeat the same command but instead of ls we add `cat readme`
- Password is `cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8`

## Bandit level 20 -> 21
- `./bandit20-do` explains that you can use it to execute a command as another user, namely bandit20
- We need to access the /etc/bandit_pass file for bandit20 but since that will only be accessible for bandit20 and above, we cannot read the pass without already being bandit20
- Using bandit20-do we run the command `./bandit20-do cat /etc/bandit_pass/bandit20` to gain the contents of the file
- Password is `0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO` 
