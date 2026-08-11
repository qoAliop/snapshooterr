**Snapshooterr**

Snapshooterr is a small terminal documentation tool I made for pentesting.

The idea is: instead of manually copying commands and their output into notes while working, Snapshooterr records the terminal session and lets you save the last few commands whenever you want.

For example:

❯ nmap 192.168.1.1
...
❯ whoami
aliow
❯ pwd
/home/aliow

❯ snapshooterr
How many last inputs you wanna record? 3

It then creates/updates a text file containing the commands and their output.

_______________


**What it does**

1- Records terminal commands and their output.

2- Keeps track of when each command was actually run.

3- Lets you choose how many recent commands to save.

4- Remembers the snapshot name for the current terminal session.

5- Appends new snapshots instead of overwriting the previous ones.

6- Doesn't record snapshooterr itself.

7- Commands such as nano, vim, and nvim are saved as the command only, without dumping their terminal interface into the notes.

8- Each terminal gets its own recording session.

9- Works automatically with Fish after installation.

______________


**The output looks roughly like:**

======================================================================
SNAPSHOOTERR: pentest
SESSION: 44406-1786432927274407313
GENERATED: 2026-08-11 10:22:31
======================================================================

[2026-08-11 10:22:01] $ nmap 192.168.1.1
Starting Nmap 7.99...
...
Nmap done: 1 IP address (1 host up) scanned in 5.79 seconds

[2026-08-11 10:22:12] $ whoami
kali

[2026-08-11 10:22:20] $ nano /tmp/test.txt

__________


**Installation**

Clone the repository:

git clone <YOUR-REPOSITORY-URL>
cd snapshooterr

Run the installer:

chmod +x install.sh
./install.sh

The installer puts the two scripts in:

~/.local/bin/

and automatically adds the Snapshooterr startup code to:

~/.config/fish/config.fish

After installing, restart your terminal.

You can check that it was installed with:

snapshooterr

_____________


**How to use it**

Once installed, just use your terminal normally.

For example:

echo "hello"
ls
whoami
pwd
nmap 192.168.1.1

When you want to save some of your recent work:

snapshooterr

The first time in that terminal you'll be asked:

Name this snapshot: pentest

Then:

How many last inputs you wanna record? 5

The snapshot will be saved under:

~/Documents/snapshooterr/

For example:

~/Documents/snapshooterr/pentest.txt

Running snapshooterr again in the same terminal keeps the same snapshot name and only asks how many commands you want to record.

____________

**Files**

The project is currently just three files:

snapshooterr/
├── snapshooterr
├── snapshooterr-session
└── install.sh

______________

*snapshooterr*

This is the main command. It reads the current terminal recording, extracts the commands and output, adds timestamps, and writes the snapshot.

*snapshooterr-session*

This starts the terminal recording session and creates the session-specific recording and timing files. (but you wont need to use it because its already automated by the system)

*install.sh*

This installs both scripts and sets up the Fish configuration automatically.

It's safe to run the installer again when updating the project.

Where the data goes

Temporary session data is stored in:

~/.local/state/snapshooterr/

Your actual snapshots are stored in:

~/Documents/snapshooterr/

You don't need to create these directories yourself.

Why I made it

When doing pentesting, I don't really want to stop every few minutes to document:

command → output → timestamp

especially when running a bunch of enumeration commands.

I wanted something closer to a normal terminal command where I could just do:

snapshooterr

and have the recent work turned into notes automatically.

It's basically a lightweight terminal session logger made specifically for keeping pentesting notes.
