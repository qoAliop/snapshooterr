# Snapshooterr

**Snapshooterr** is a lightweight terminal documentation tool made for pentesting.

The idea is simple: instead of manually copying commands, output, and timestamps into notes while working, Snapshooterr records your terminal session in the background and lets you save your most recent commands whenever you want.

For example:

```text
❯ nmap 192.168.1.1
...

❯ whoami
aliow

❯ pwd
/home/aliow

❯ snapshooterr
How many last inputs you wanna record? 3
```

Snapshooterr then creates or updates a text file containing the selected commands, their output, and the time they were actually executed.

---

## What it does

* Records terminal commands and their output.
* Keeps track of when each command was actually run.
* Lets you choose how many recent commands to save.
* Remembers the snapshot name for the current terminal session.
* Appends new snapshots instead of overwriting previous ones.
* Doesn't record `snapshooterr` itself.
* Handles interactive commands such as `nano`, `vim`, and `nvim` without dumping their terminal interface into your notes.
* Gives each terminal its own recording session.
* Automatically starts with Fish after installation.

The goal is to make documentation part of the normal terminal workflow instead of something you constantly have to stop and do manually.

---

## Example output

A snapshot will look roughly like this:

```text
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
```

The resulting file is plain text, so it's easy to read, search, copy, or use later when writing a pentest report.

---

## Installation

Clone the repository:

```bash
git clone https://github.com/qoAliop/snapshooterr.git
cd snapshooterr
```

Make the installer executable:

```bash
chmod +x install.sh
```

Run it:

```bash
./install.sh
```

The installer installs the Snapshooterr scripts into:

```text
~/.local/bin/
```

and automatically adds the Snapshooterr startup code to:

```text
~/.config/fish/config.fish
```

After installation, restart your terminal.

You can verify that it was installed by running:

```bash
snapshooterr
```

> **Note:** Snapshooterr currently uses Fish for its automatic terminal-session setup.

---

## How to use it

Once installed, just use your terminal normally.

For example:

```bash
echo "hello"
ls
whoami
pwd
nmap 192.168.1.1
```

You don't need to manually start the recorder.

When you want to save some of your recent work, run:

```bash
snapshooterr
```

The first time you run it in a terminal session, you'll be asked for a snapshot name:

```text
Name this snapshot: pentest
```

Then you'll be asked how many recent commands you want to record:

```text
How many last inputs you wanna record? 5
```

The snapshot will be saved under:

```text
~/Documents/snapshooterr/
```

For example:

```text
~/Documents/snapshooterr/pentest.txt
```

Running `snapshooterr` again in the same terminal keeps the same snapshot name and only asks how many recent commands you want to save.

---

## Saving multiple snapshots

Snapshooterr **appends** new snapshots instead of overwriting the existing file.

For example, you could save your initial enumeration:

```text
snapshooterr
→ 5 commands
```

Continue working for a while, then save another batch:

```text
snapshooterr
→ 10 commands
```

The new snapshot is added to the existing file.

This lets you gradually build a record of your work without having to manually maintain a notes file.

---

## Project structure

The project currently contains:

```text
snapshooterr/
├── LICENSE
├── README.md
├── install.sh
├── requirements.md
├── snapshooterr
└── snapshooterr-session
```

### `snapshooterr`

The main command.

It reads the current terminal recording, extracts the commands and output, adds timestamps, and writes the selected commands to the snapshot file.

### `snapshooterr-session`

This starts the terminal recording session and creates the session-specific recording and timing files.

You normally **don't need to run this manually**. It is automatically handled by the Fish configuration installed by `install.sh`.

### `install.sh`

The installation script.

It installs the Snapshooterr scripts and configures Fish so that a recording session starts automatically for new terminals.

The installer is designed to be safe to run again when updating the project.

### `requirements.md`

Contains the requirements and dependencies needed by Snapshooterr.

### `LICENSE`

Snapshooterr is released under the MIT License.

---

## Where the data goes

Temporary session data is stored in:

```text
~/.local/state/snapshooterr/
```

Your actual snapshots are stored in:

```text
~/Documents/snapshooterr/
```

You don't need to create these directories yourself. Snapshooterr creates them when needed.

---

## Why I made it

When doing pentesting, I don't really want to stop every few minutes to document:

```text
command → output → timestamp
```

Especially when running a bunch of enumeration commands, manually keeping notes can get annoying pretty quickly.

I wanted something closer to a normal terminal workflow:

```text
do the work
     ↓
keep working
     ↓
snapshooterr
     ↓
notes
```

So that's basically what Snapshooterr is:

**a lightweight terminal session logger made specifically for keeping pentesting notes without constantly interrupting your workflow.**

---

## License

Snapshooterr is licensed under the **MIT License**.

See [`LICENSE`](LICENSE) for the full license text.
