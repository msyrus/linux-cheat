#!/usr/bin/env bash

##about

    #this file is being cut up into smaller files

    #distribution specific installation procedures are put outside of this section

    #for a summary of up to level 2 header: `grep -E '^[[:space:]]{0,4}##' %`

##sources

    #- http://linux.die.net/

        #linux man pages

        #also contains dive into python and advanced bash scripting,
        #so is a major site

    #almost official pages:

        #- http://www.kernel.org/

        #- http://git.kernel.org/

    #- http://www.tldp.org/

        #many tutorials

    #- the geek stuff

        #http://www.thegeekstuff.com

        #short tutorials with lots of examples

    #- tuxfiles

        #<http://www.tuxfiles.org/linuxhelp/fstab.html>

        #some good tuts

    #- man pages

        #check [man[]

        #not many examples, but full function list, and you often can guess what they mean!

    #- linux from scratch

        #teaches how to build a minimal linux distro

##man

    #the manuals

    #posix 7 specifies the single option `-k` and nothing about pages

    ##search

        man intro
            #exact search on title
            #shows only first match
        man -a intro
            #shows each match in succession
            #asks if you want to continue on each quit
        man -k password
            #search for commands with password word on summary
        man -K password
            #search on all of manual pages
            #may take some time

        ##--regex

            #whatever you were searching
            #search with ERE now

            man --regex 'a.c'
                #regex on title
            man --regex -K 'a.c'
                #regex on entire manual

        apropos password
            #same
        man -k .
            #list all manual pages
            #pages whose summaries match '.' reges: anychar)
        man -k . | grep '(8)'
            #list manual section

    ##show

        ##sections

            man 2 intro
                #read intro about section 2
            #1: commands (executables in path)
                #is the default section
                man 1 passwd
            #2: system calls (c interface)
                man 2 write
                    #write system call
                man 1 write
                    #write command
            #3: library. system call wrappers.
            #4: special files
                man 4 mouse
            #5: file formats
                man 5 passwd
                    #/etc/passwd file syntax
                man 5 elf
                    #elf executable format
            #6: games
            #8: system administration
                man 8 adduser
                    #commands that mostly only root can to

    ##whatis

        #non posix

        whatis ls
            #show short description of ls

    ##manpath

        #man search path

        #non posix

        manpath
            #/usr/local/man:/usr/local/share/man:/usr/share/man
        ls /usr/share/man
            #languages
            #man\d
        ls /usr/share/man/man1 | less
            #section 1 pages in english

##info

    #gnu, not posix

    #each page contains lots of info, more than man pages
    #may even contain, *gasp*, examples!

    #the keybindings are very tree/node based. To get started:

        #?: help
        #x: close help

        ##page

            #<space>:   down one page. May change nodes.
            #<backspace>: up one page. May change nodes.
            #b, e: beginning/end of current node.
            #s, /: search string
            #{, }: repeat search back/forward

        ##menu

            #<arrows>: move cursor
            #<enter>: go to link under cursor
            #<tab>: go to next link
            #1-9: go to menu item nb.
            #m: select menu item in current page by name.
                #can tab complete.
                #even without tab complete, goes to first match on enter.

        ##node

            #u: parent node
            #t: top node
            #[, ]: next previous node. May     change node level.
            #n, p:                         not
            #l: go to last viewed node. can be used several times.
            #g: like m, but search all nodes

        ##search

            #/: regex
            #{: next      match of previous search
            #}: previous

    info
    info rm

##configuration

    ##ubuntu

        #TODO: explain or remove

            #sudo aptitude install -y myunity

        #additional drivers : non free vendors

            jockey-text --list
            #list

            jockey-text --enable=$DRIVER
            #enable from list. ex: xorg:fglrx_updates

    #TODO explain or remove:

        sudo aptitude install -y dconf-tools

    ##gnome tweak tool

        #gui to configure lots of desktop things.

    sudo aptitude install -y gconf-editor

    ##gsettings

        #set vaules

            #applies instantly
            gsettings set com.canonical.desktop.interface scrollbar-mode normal
                #normal not hidden scroll bars

            gsettings set com.canonical.indicator.session show-real-name-on-panel true
                #show username on panel

            gsettings reset com.canonical.desktop.interface scrollbar-mode
                #return to default value

    #TODO explain or remove:

        sudo aptitude install -y compiz compizconfig-settings-manager compiz-plugins-extra

##desktop

    unity --restart
        #restarts the unity shell only
        #less effective and drastic than restarting lightdm

    #gnome shell

    #desktop/windows control

        gnome-open "$FILE"
            #opens with the deafult application. works in Ubuntu Unity 12.04

    #key logging

        #writes all keypresses to a file

        sudo logkeys -s
            #start

        sudo logkeys -k
            #end

    #ibus input methods

        #for chinese, japanes, etc input

        #how have I looked for this, but no one told me: ibus for qt apps!!!!

    ##alarm clock applet

        #notifies you with sounds when a certain time passed

    ##weather indicator

##compresssion

    #the performance parameters are:
        #- compression ratio
        #- compression time
        #- can see and extracting single files
        #- support across OS
        #- ability to break into chunks
        #- keep file metadata such as permissions, hidden (windows), etc.

    ##zip

        #most widely supported
        #not so high compression
            #compresses dir one file by one it seems
        #easy to view and extract single files

        #zip file or directory

            zip -r "$F".zip "$F"

        #-r : add dir recursivelly. otherwise, adds only the top dir!

        #-e : encrypt:

            zip -er "$F".zip "$F"

        #you can still see filenames!! but not extract them

        #list all files in zip file

            unzip -l "$F".zip

        #extract files from zip:

            unzip "$F".zip

        #if has password, asks for it

        #to a dir

            unzip "$F".zip -d out

        for F in *; do echo "$F"; echo "$F".zip; zip "$F".zip "$F"; done
        #zip every file in cur dir to file.zip

    ##tar tar.gz tgz tar.bz2 tb2

        #tar only turns dir into file, but no compression
        #this is why it is often coupled with gz and bz2: those are files compressers
        #gz gives similar compression to .zip
        #gz2 is smaller than gz (30% for roms), but MUCH slower to make, and you can't extract individual files easily
        #tgz == tar.gz
        #txz == tar.xz
        #tb2 == tbz == tar.bz2

        #create
            tar vcf "$F".tar "$F"
            tar vczf "$F".tgz "$F"
            tar vcjf "$F".tbz "$F"
            tar vcJf "$F".txz "$F"
            #c: create
            #f: to file given as next arg, not to stdout
            #z: gzip
            #j: bzip2
            #v: verbose

        #extract
            tar vxf "$F".tar
            tar vxzf "$F".tgz
            tar vxjf "$F".tbz
            #f: from file given as next arg, not stdin

    ##rar

        #proprietary Roshal ARchive
        #can do split archive
            #split archive extensions:
                #.part\d+.rar
                #.r\d+

        unrar x a.rar
        #extract contents of a.rar to ./
        #
        #a.rar
        #  /dir1/
        #  /dir1/f1
        #  /dir1/f2
        #
        #===============
        #
        #a.rar
        #dir1/f1
        #dir1/f2

        unrar x a.rar out
        #out to ./out/, creates this folders if necessary

        unrar x a.r00
        unrar x a.part1.rar
        #extract multipart rar

        unrar e a.rar
        #recursivelly finds all files in a.rar, and outputs them to current dir
        #with old basename possible name conflicts
        #
        #a.rar
        #  /dir1/
        #  /dir1/f1
        #  /dir1/f2
        #
        #===============
        #
        #a.rar
        #f1
        #f2

    #7zip
        #microsoft proprietary program
        #can do lots of formats:
            #7z format
            #rar with p7zip-rar installed
            #zip
        #but *use only for 7z*, which it was made for
        #with 7zip, you can open .exe files to extract their inner data

    ##file roller

        #very good gui app to view inside archives and extrac them

##dictionnary

    ##dictionnary formats

        ##stardict
        #<http://goldendict.org/dictionaries.php>

        #for dicts, go: <www.stardict.org/download.php>

        ##bgl
        #babylon
        #windows oriented: exes on site!
        #can open .exe with 7zip to extract data content
        #now most exes are downloader without blgs, probably vendor lockin
        #I found some that actually contained the blg here:
        #  http://www.babylon.com/dictionaries-glossaries

    ##goldendict

        #fork of stardict

        #select text can make popup windows!

        #supported formats: stardict, blg,

    ##sdcv

        #command line stardict

        #supported formats: stardict only

        #to install dict place it under:

            /usr/share/stardict/dic
            $(HOME)/.stardict/dic

        #list available dicts:

            sdcv -l

    ##spell checking

        ##aspell

            ##features

                #can add words to dict

                #understands some predefined formats!

            #interactively checks files for spelling errors:

                aspell -c f

            #if modified, change inline but create `.bak` file

            #french:

                aspell -l fr -c f

            #must first install wordlist

            #same but ignore language constructs (modes):

                aspell --mode=tex -c f
                aspell --mode=html -c f

            #modes can be added/removed. They are called `filters`

                sudo aspell --add-filter=$f
                sudo aspell --remove-filter=$f

#codecs #ERROR: mpg123libjpeg-progs cannot locate

    #use TAB to navigate msfonts

    #TODO explain or remove:

            sudo aptitude install -y mencoder totem-mozilla icedax tagtool libmad0 mpg321 mpg123libjpeg-progs

##chat messaging voice video

    ##skype

        sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
        sudo aptitude update
        sudo aptitude install -y skype

    ##google talk

        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
        sudo aptitude update
        sudo aptitude install -y google-talkplugin

    sudo aptitude install -y pidgin

    ##mseg write wall

        #write messages to other users on the system

        ##mseg

            #enable/disable messages
                mseg n
                mseg
                    #n
                mseg y
                mseg
                    #y

        ##write

            #write to a user in a tty

                u=
                write $u tty3
                    #type you message
                    #type enter, and it is sent
                    #ctrl+d ends

                u=
                h=
                sudo write $h@$u tty2
                    #with sudo, you can write even is mseg n

        ##wall

            #write to all

                wall
                    #type you message
                    #message is only sent after you ctrl+d
                sudo wall
                    #sends to all even if disabled

        #play with it:
            #go to tty3. on ubuntu: ctrl+alt+f3
            #login as user u
            mesg y
            #go to tty7 (xserver). on ubuntu: ctrl+alt+f7
            sudo write u tty3
            #write
            #go to tty3
            #your message is there!

    ##talk

        #commandline chat program

        #posix

        sudo aptitude install -y talk

        #TODO use it. lazy now.

    ##irc

        #internet relay chat

        #servers have channels

        #log into a server, join a channel

        #messages can be seen

            #- by all people on channel
            #- certain people you write to only

        #you cannot see read old messages
        #sent when you were not logged in!!

        #it is also possible to send files to people

        ##commands

            #intro: <http://www.irchelp.org/irchelp/irctutorial.html>

            #full list: <http://en.wikipedia.org/wiki/List_of_Internet_Relay_Chat_commands>

            #/connect <server>

            ##ubuntu channel

                    ##register

                        xdotool type "/msg nickserv register $password $email"

                    ##verify registration

                        #go to your email and get the registration code

                        regcode=
                        xdotool type "/msg nickserv verify register $uname $regcode"

        ##clients

            ##pidgin

                #good because integrates with other ims

                ##create account

                    #irc server + username on that server == a pidgin account

                    #add account > irc

                    #enter server username and pass

                ##join/create channel:

                    #an irc channel == a pidgin chat

                    #chats appear on the buddy list like buddies

                    #buddies > join a chat > choose server, enter a #channel_name

                    #if you don't know the name and want to list the available channels,
                    #enter any #name, and then /list there

                    #a chat window appear, mapping to the chosen channel on chosen sever

                    #if you close the chat window, it will not be on your buddy list anymore

                ##add channel to buddy list permanently:

                    #buddies > add a group. name it "irc".

                    #buddies > show > empty groups

                    #buddies > add a chat. choose type irc, server, channel.

        ##irssi

            #ncurses

    ##mail

        #TODO
            #get any of this to work =)

        #MTA mail transfer agent
            #examples:
                #sendmail
                #postfix

        #mail

            #sudo aptitude install -y sendmail
            #sudo aptitude install -y mailutils

            echo -e "the message\n\nend of it" | mail -s "subject" -r "from@gmail.com" "to@gmail.com"
            mail -s "subject" -r "from@gmail.com" "to@gmail.com"
                #you type
                #mail ends in line with '.' only or ctrl+d

        #mutt

            #mail with attachment

            #curses inteface

            sudo aptitude install -y mutt


##file sharing

    ##torrent

        ##deluge

            sudo add-apt-repository -y ppa:deluge-team/ppa
            sudo aptitude update
            sudo aptitude install -y deluge

    ##dropbox

        sudo aptitude install -y nautilus-dropbox

        firefox https://www.dropbox.com/home
            #see your home files on browser

        dropbox filestatus
        dropbox filestatus "$F" "$G"
                #a: up to date
                #b: unwatched

        dropbox status
            #idle

        dropbox ls
            #ls on current dir
            #green: synced

        dropbox puburl "$F"
        echo "wget `dropbox puburl "$F"`" > xsel
            #get public url of F
            #must be inside Public folder

        dropbox autostart y
            #autostart dropbox

        #ubuntu one
            #shows sync status on task bar
            sudo add-apt-repository -y ppa:noobslab/initialtesting
            sudo apt-get update
            sudo apt-get install indicator-ubuntuone

    ##ubuntu one

        #open source cross platform canonical dropbox like program

        #web interface:

            firefox https://one.ubuntu.com/dashboard/

        #check deamon status:

            u1sdtool -s

        #publish a file:

            u1sdtool --publish-file a

        #get file public url to the clipboard:

            u1sdtool --publish-file a | perl -ple 's/.+\s//' | xsel -b

    ##nicotine+

        #soulseek client

            sudo aptitude install -y nicotine+

        #behind a proxy router
        #go to the router admin panel, port forwarding part
        #  (http://192.168.0.1/RgForwarding.asp on dlink for example, default login:admin pass:motorola)
        #open ports 2234 to 2239 on local ip found at
        #  ifconfig eth0 | grep "inet addr:"
        #
        #now either put your files in another partition at the root, or symlink
        #your share and download dirs to somewhere above user so that people cannot
        #see your username

##programming

    ##pkg-config

        #info is contained in "$PKG_NAME.pc" files located mainly under:

            #/usr/share/pkgconfig/
            #/usr/lib/i386-linux-gnu/pkgconfig/

        #a part of program installation may be to put files there

        #usage in in a makefile:

            CFLAGS=$(shell pkg-config --cflags pkgname)
            LIBS=$(shell pkg-config --libs pkgname)

    ##editors ides

        ##eclipse

            #sudo aptitude install -y eclipse
                #problems with cdt tools

            #MANUAL: install plugins.

            #must be root for those operations so
            gksudo eclipse

            #Help > Install new software > Availabe software sources > Check every single case there!
            #Help > Install new software > New sources

            #add vim like editing to eclipse
            #http://vrapper.sourceforge.net/update-site/stable

            #add eclipe functionality to vim
            #http://vrapper.sourceforge.net/update-site/stable

            #color themes

            #http://eclipse-color-theme.github.com/update
            #	mine: http://www.eclipsecolorthemes.org/?view=theme&id=7915
            #to install: File > Import > Preferences > Select *.epf (Eclipse menus are SO unintuitive...)

            #c and c++
            #http://download.eclipse.org/tools/cdt/releases/indigo/

            #python
            #http://pydev.org/updates

            #html, javascript, php
            #http://download.eclipse.org/webtools/repository/indigo/

            #latex
            #http://texlipse.sourceforge.net
            #forward search to okular:
            #
            #
            #inverse search from okular: Settings > Configure Okular > Editor
            #  Editor: custom text editor,
            #  Command: gvim --remote +%l %f

        ##vim

            #gvim, runs in gtk outside command line
            #and thus gets around many command line limitations such as reserved shortcuts

                gvim

    ##diff

        ##diff

            #compare files *and* directory contents

            #files:

                echo -e "0\na\n1\n2\n3\n4\n5" > a
                echo -e "0\n1\n2\nb\n3\n5" > b
                nl a
                nl b

                diff a b

                diff -u a b
                #gitlike diff (unified format)

            #directories:

                mkdir a
                touch a/a
                touch a/c
                mkdir b
                touch b/b
                touch b/c
                diff a b

        ##comm

            #ultra simple diff

            #useless

            #posix 7

            cd "`mktemp -d`"
            echo -e "a\nc" > a
            echo -e "b\nc" > b
            comm a b
                #a
                #    b
                #        c

                #3 cols:
                    #lines only in a
                    #           in b
                    #      in both

                #tab separated columns
                    #long lines look horrible

        ##patch

        ##wdiff

            #word oriented diff

            sudo aptitude install -y wdiff

            wdiff a b

        #kiff3
            #kde diff tool
            sudo aptitude install -y kdiff3

            kdiff3 f1 f2 -o fout

    ##ack

        #finds and greps
        #nice filename/line/match highlight output
        #ignores .git .svn, backup, swap files
        #can detect and filter by filetype via extension and shebangs

        ##install

                sudo aptitude install -y ack-grep
            #`ack` package was already taken by a kanji converter!

            #this begs for an alias:
                alias ack="ack-grep"

        ##

        ack --py perl_regex
            #recursive find grep for perl_regex in python files only, detects shebangs

        ack -f --py --print0 | xargs -0 -I '{}' git add '{}'
        #adds all python files git. shebang aware.

        ack --cc '#include\s+<(.*)>' --output '$1'
        #prints only include names in cpp files
        #--sh for bash

        ##-f

            #list all filenames of known types:

                ack -f

        ##-g

            #list files of known types that match regex:

                ack -g '\.py$'

        ack --thpppt
        #bill the cat

        ##combos

            #find lines in files:
                ack -f | xargs grep 'find'

            #dry run replace in files with regex::
                ack -f | xargs -lne 'print if s/a/A/g'
            #only prints modified lines

            #non-dry run replace in files:
                ack -f | xargs perl -pie 's/z/Z/g'
            #prints nothing

    ##exuberant-ctags

        #generate tags for given file

        #this makes it possible for external applications to find symbols defined in this file
        #such as functions, variables, macros, etc

        #supports 55 languages

        sudo aptitude install -y exuberant-ctags

        exuberant-ctags a.c
        less tags

    ##source-highlight

        #takes in source files and produces highlighted output in one of the formats:

        #- html
        #- ansi terminal escape sequences
        #- pdf

        #list all languages supported:

            source-highlight --lang-list

        #generate an `a.html` highlighted version of `a.py`:

            source-highlight a.py

    ##pygments

        #python package for multi language syntax coloring.

        #take python source, output colored html:

            pygmentize -O full -o test.html test.py
            firefox test.html &

        #-O: options.
            #full is required here, otherwise there would be no header,
            #and the style info would not be put in the html

        #input and output formats here were inferred from extension,
        #but can be explicitly set too.

##file management

    ##krusader

        #great file manager

        #features:

        #- useractions:
            #Execute shell scripts wich access to things like current directory or selected files

        #- give shortcuts to useractions
            #you can give shortcuts to anything, including user actions!

        #- ftp. Just enter an ftp url on the address bar and it all works.

            #filezilla is still better at this I think.

        sudo aptitude install -y krusader
        sudo aptitude install -y konqueror          #needs to manage bookmarks. (otherwise, button does nothing)
        sudo aptitude install -y konsole            #needs to terminal emulator. (otherwise, button does nothing)
        sudo aptitude install -y  khelpcenter4      #help
        sudo aptitude install -y  kwalletmanager    #password manager

##time date

    ##cal

        #cout a calendar!!!

        cal

    ##date

        #get system date:

            sudo date

                    TODO get working

                        pmidi -l
                        vim ~/.dosbox/dosbox-*.conf

                    put the port in:

                        [midi]
                        midiconfig=14:0

        #set system date:

            sudo date -s "1 JUN 2012 09:30:00"

        #format current time and output it:

            TIMESTAMP=`date +%Y-%m-%d-%H-%M-%S`

    ##hwclock

        #see hardware clock time:

            sudo hwclock --show

        #sync hardware clock to system clock

            sudo hwclock --systohc

    ##set you time zone

        #on dual boot with windows there are conflicts because Windows uses local time, and Linux UTC (more logical...). you must either tell Linux to use local, or better, Windows to use UTC

            $TIMEZONE_LOCATION=/usr/share/zoneinfo
            cd $TIMEZONE_LOCATION
            ls
            $TIMEZONE_NAME=
            cp $TIMEZONE_LOCATION/$TIMEZONE_NAME /etc/localtime

##libreoffice

    #wysiwyg text editor, tables, image editor:

        sudo aptitude install -y libreoffice

    #database management:

        sudo aptitude install -y libreoffice-base

##text

    ##echo

        #posix 7

        #print to stdout:

            assert [ "`echo a`" = $'a' ]

        #appends newline

        #-n: no final newline:

            echo -n a

        #prints all given arguments, space separated:

            assert [ "`echo a b c`" = "a b c" ]

        #does not interpret \ escaped chars:

            assert [ "`echo 'a\nb'`" = $'a\\nb' ]

        #-e: interprets \ escaped chars:

            assert [ "`echo -e 'a\nb'`" = $'a\nb' ]

        #print the `-n` string:

        #IMPOSSIBLE! not even gnu echo supports `--`. =) use `printf`.

    ##printf

        #posix 7

        #removes echo quicks

        #supports c format strings:

            assert [ "`printf "%1.2d" 1`"       == "01" ]
            assert [ "`printf "%1.2f" 1.23`"    == "1.23" ]

        #print the `-n` string:

            assert [ "`printf "%s" "-n"`" == "-n" ]

    ##grep

        #posix 7

        #select lines from stdin or files

        #dont use egrep and fgrep variations,
        #which are useless and deprecated

        echo $'a\nb' | grep a
        echo $'a\nb' > f
        grep a f
            #a

        echo $'A\nB' | grep -i a
            #A
            #-i: case insensitive

        ##invert

            echo $'ab\ncd' | grep -v a
                #cd
                #-v: invert. print lines that don't match.

            ##application

                #remove line from file

                f=
                l="^$"
                tmp="`mktemp`"
                grep -v "$l" "$f" > "$tmp"
                mv "$tmp" "$f"

        ##exit status

            echo a | grep -q b && assert false
            echo a | grep -q a || assert false
                #-q: suppress stdout
                    #useful if you only want the exit status

            ##application

                #append line to file
                #if it is not there already

                    f=""
                    l=""
                    grep -q "^$l$" "$f" || echo "$l" >> "$f"

                #very useful for files that have unordered
                #sets of things separated by newlines

        echo $'a\na' | grep -c a
            #2
            #-c: count lines that match

        ##or

            echo $'a\nb' | grep -e 'a' -e 'b'
                #-e: multiple criteria or
                #patters are BRE
            echo $'a\nb' | grep -E -e 'a' -e 'b'
                #patters are ERE
            echo $'a\nb' | grep -F $'a\nb'
                #multiple searche, separated by newline
                #or
                #literal match

        ##regexp

            #grep can use POSIX BRE and POSIX ERE

            #don't forget: BRE is deprecated

            #perl regexp is non POSIX

            #see: <#extended regex>

            echo $'a\nb' | grep -E '(a|b)'

        ##-n

            #show matching line Numbers

        #-v

            #inVert selection: select non matching

        ##gnu grep

            #non posix, so be warned

            ##-r

                #recurse, print filenames. *VERY* tempting... no more `find . -type f | xargs` !!

                    grep -r 'a'

            ##-A

                #also print n lines following the match

                #example:
                    assert [ "`echo $'a\nb' | grep -A1 a`" = $'a\nb' ]

                ##application

                    #get the nth line after matching line:
                        assert [ "`echo $'a\nb' | grep -A1 a | tail -n1`" = $'b' ]

                ##-B

                    #before

                    assert [ "`echo $'a\nb' | grep -B1 b`" = $'a\nb' ]

    ##cat

        #concatenate files to stdout

        echo asdf > a
        echo qwer > b

        cat a
            #asdf

        cat a b
            #asdf
            #qwer

    ##tac

        #cat reversed linewise

            assert [ "`echo $'a\nb' | tac`" = $'b\na' ]

    ##rev

        #reverse bytewise

            assert [ "`echo $'ab' | rev`" = $'ba' ]

    ##dd

        #POSIX

        #menemonic: Duplicate Data TODO check

        #funny mnemonic: Data Destroyer ( because of danger of common usage with sda devices to copy hard disks quickly )

        #advantages:

        #- gives more control than simpler utilities such as `cat`
        #- supports the concept of `blocks`

        #if = input file. If not given, stdin.

        #of = output file. If not given, stdout.

        #echo a | cat:

            echo a | dd

        #cat a:

            echo a > a
            dd if=a

        #cp a b:

            dd if=a of=b

        #stop printing status lines:

            echo a | dd status=none

        ##bs

            #how many input and output bytes to read/write at once.

            #also defines the block size for count, skip and seek.

            #obs and ibs for output and input seprately:

        #count: copy up to count blocks (defined by bs):

            assert [ `echo -n 1234 | dd status=none bs=2 count=1` = 12 ]
            assert [ `echo -n 1234 | dd status=none bs=1 count=3` = 123 ]

        #size suffixes:

        #-c: 1 (char)
        #-w: 2 (word)
        #-kB: 1000
        #-K: 1024
        #-MB: 1000*1000
        #-M: 1024*1024

        #and so on for G, T, P, E, Z and Y!

            assert [ `echo -n 123 | dd status=none bs=1c count=1` = 1 ]
            assert [ `echo -n 123 | dd status=none bs=1w count=1` = 12 ]

        #skip: skip first n input blocks (defined by bs or ibs):

            assert [ `echo -n 123 | dd status=none bs=1 skip=1` = 23 ]

        #seek: skip first n output blocks (defined by bs or obs):

            #TODO minimal exmaple

        ##conv

            #do serveral data conversions on copy

            #ucase: uppercase

                assert [ `echo -n abc | dd status=none conv=ucase` = ABC ]

        ##iflag oflag

            #TODO

    ##pagers

        ##less

            #file pager (viewer)
            #loads faster than vim
            #vimlike commands

            #/ : search forward
            #n : repeat last search
            #d : down one page
            #u : up one page
            #g : top of document
            #G : bottom of document
            #g : top of document
            #<ENTER> : down one line

            less "$f"
            echo $'ab\ncd' | less

        ##more

            #worse than less

            echo a | more

        ##pg

            #worse than more

            echo a | pg

        ##pr

            #break file into pages with a certain number of lines
            #and print to stdout

            ( for i in `seq 200`; do echo a; done ) | pr

    ##sort

        #sort linewise

        #uses External R-Way merge
        #this algorithm allows to sort files that are larger than memory

        sort f1 f2
            # sort f1, f2 together linewise
            # -r : reverse order
            # -n : numbers
            # -u : uniq. remove dupesls -lh | sort -k5hr
            # -t: : set field separator to ':'
            # -k5 : sort by field N
                # -k 2,2n -k 4,4hr : sort by columns. from 2 to 2, numeric, then from 4 to 4, human and reverse
            # -R : randomize
            # -h : sort by human readable filesizes: 1k, 2M, 3G
            # -f : ignore case. random lower/upper order
            # -fs : ignore case and put always upper before lower
            # -b : ignore leading blanks
            # -uf : remove dupes, cas insensitive (A and a are dupes)
            # -m : supposesing f1 and f2 are already sorted, making merge faster
            # -c : check if is sorted

    ##tsort

        #topological sorting
        #<http://en.wikipedia.org/wiki/Tsort_%28Unix%29>

        echo $'1 2\n2 3' | tsort
            #1
            #2
            #3

        echo $'1 2\n2 1' | tsort
            #contains loop
        echo $?
            #1

    ##factor

        #coreutils

        #factor a number into prime constituents

        assert [ "`factor 30`" = "30: 2 3 5" ]

    ##uniq

        #POSIX 7

        #ajacent dupe line operations

        echo $'a\nb' | uniq
            #a
            #b

        echo $'a\na' | uniq
            #a

        echo $'a\nb\na' | uniq
        #a
        #b
        #a
        #not adjacent

        #sort combo detected

            echo $'a\nb\na' | sort | uniq
            #a
            #b

        echo $'a\na' > a
        uniq a
            #a

        # -u : only show lines that have no dupe
        # -d : dupe lines only
        # -c : counts how many dupes

    ##read

        #-p print message

            read -p "enter string: " s
            echo "you entered $s"

        #read from file descriptor linewise and assign to variable

            ##applications

                #read file linewise:

                    while read l; do
                        echo "$l";
                    done < "$f"

                #read stdout linewise:

                    while read l; do
                        echo "$l"
                    done < <( echo -e "a\nb\na b" )

                #split into fields:

                    IFS_OLD="$IFS"
                    while IFS=' : ' read f1 f2
                    do
                        echo "$f1 $f2"
                    done < <( echo -e "a : b\nc : d" )
                    IFS="$IFS_OLD"

    ##tee

        #POSIX 7

        ls | tee file
            #ls to stdou and file
        ls | tee file 1>&2
            #ls to
        ls -l | tee file | sort
            #ls to file and sort
        ls | tee –a file
            #ls append to file
        ls | tee f1 f2 f3
            #ls to multple files

        #tee to multiple processes:
            echo a | tee >(seqn 2) tee >(seqn 2) | tr a b
        #note how process are run in parallel and output order is not variable.

    ##tr

        #POSIX 7

        #charwise text operations

        #replaces a by A and b by B and c by C:

            assert [ `echo -n cab | tr abc ABC` =  CAB ]

        #ranges are understood. Convert to uppercase:

            assert [ `echo -n cab | tr a-z A-Z` =  CAB ]

        #posix character classes are understood. Remove non alphtnum chras:

            assert [ `echo -n 'ab_@' | tr -cd "[:alpha:]"` = ab ]

        #-c : complement and replace. replaces all non abc chars by d

            assert [ `echo -n dcba | tr -c abc 0` =  0cba ]

        #-d: deletes abc chars:

            assert [ `echo -n dcba | tr -d abc` =  d ]

        #-s: replaces multiple consecutive 'a's and 'b's by isngle a

            assert [ `echo -n aabbaac | tr -s ab` =  abac ]

    ##cut

        #get columns from text databases

        #for more complex ops, consider <#awk>

        echo $'a\tb\nc\td' | cut -f1
            #$'a\nc'
            #-f: field. what column to print.

        echo $'a:b\nc:d' | cut -d: -f1
            #$'a\nc'
            #-d: delimier

        echo $'a' | cut -d: -f2
            #$'a'
            #gets last if larger

        echo $'a:b:c\nd:e:f' | cut -d: -f1,3
            #$'a:c\nd:f'
            #first and columns

        echo $'a:b:c:d\ne:f:g:h' | cut -d: -f1-3
            #$'a:b:c\ne:f:g'
            #first to third columns

    ##wc

        #POSIX 7

        #count things

        #mnemonic: Word Count.

        echo -n $'a\nb c' | wc
            #1 3 5
            #^ ^ ^

        #newline, word, byte

            #-c bytes only
            #-m chars only
            #-l newlines only
            #-L max line lenght only
            #-w words only

    ##head

        #POSIX 7

        #filter 10 first lines:

            seq 20 | head

        #filter 3 first lines:

            seq 20 | head -n3

        #2 first bytes:

            assert [ "`echo -en 'abc' | head -c 2`" = "ab" ]

        ##gnu coreutils

            #remove last two bytes:

                assert [ "`echo -en 'abc' | head -c -2`" = "a" ]

    ##tail

        #POSIX 7

        #show last 10 lines of f:

            tail "$f"

        #show last 3 lines of f:

            tail -n3 "$f"

    ##truncate

        #sets file to given size

        #if greater, pads with 0s

        #if smaller, data loss

        echo ab > f
        truncate -s 1 f
        assert [ `cat f` = a ]

        truncate -s 2 f
        hexdump
        assert [ `cat f` = $'a\0' ]

    ##split

        #corutils package

        #split files into new smaller files of same size

            echo -n abc > f

            split -db1 f p
            split -dn3 f p

            assert [ `cat p00` = a ]
            assert [ `cat p01` = b ]
            assert [ `cat p02` = c ]

        #existing files are overwritten:

        #-d: uses number suffixes, otherwise, uses letters aa, ab, ac, ...
        #-b: bytes per file
        #-n: number of files

    ##csplit

        #corutils package

        #split files into new smaller files at lines that match given EREs

        #matching lines are kept

        echo $'0\naa\n1\naa\n2' > f
        csplit f '/^a/' '{*}'
        assert [ `cat xx00` = 0 ]
        assert [ `cat xx01` = $'aa\n1' ]
        assert [ `cat xx02` = $'aa\n2' ]

    ##nl

        #number lines

        #posix 7

        #corutils package

        nl "$f"
            #cat lines, number non-empty ones

    ##fold

        #wrap lines

        #posix 7

        echo -e "aaaa\nbb" | fold -w 3
            #aaa
            #a
            #bb

        #-s: only break at spaces:

            assert [ "`echo -e "12345 6" | fold -s -w 3`" = $'123\n45\n6' ]

    ##fmt

        #coreutils

        #wrap lines, but don't cut words

        assert [ `echo "a bcd" | fold -w 2` = $'a\nbcd' ]

    ##hexdump

        #view bytes in hexa

            echo -n abc | hexdump -C

        #-C : see bytes in hexadecimal
        #-n32 : only 32 bytes
        #-s32 : start at byte 32
        #-v: show duplicate lines
        #-e '1/1 " %02X"': format string

    ##od

        #posix 7

        #view bytes in octal

            od "$f"

    ##paste

        #useless

        #posix 7

        echo -e "a a a a a a a a a a a a a a\na" > a
        echo -e "b b\nb b"                       > b
        echo -e "c c\nc c\nc"                    > c
        paste a b c
            #shows files side by side line by line
            #default separator: tab
            #long lines will make this unreadable

    ##expand

        #useless

        #posix 7

        #expand tabs to spaces

        echo -e "a\tb" | expand

        ##unexpand

            #contrary

    ##seq

        seq 1
        seq 1 3
            #1
            #2
            #3

        seq 1 2 5
            #1
            #3
            #5

        #-s : separator
        #-w : equal width

        ##non-application

            #you could use this for loops:

            for i in `seq 10`; do echo $i; done

            #but don't

            #use brace expansion instead which is a bash built-in,
            #and thus potentially faster (possibly no new process spawned):

            for i in {1..10}; do echo $i; done

            #use this only if you really need to control
            #the output with the options

    ##path operations

        ##basename

            basename /usr/a.txt
                #a.txt

            basename /usr/a.txt .txt
                #a

        ##dirname

            #get the parent dir of a path, not / terminated except for /, no error checking
            dirname /path/to/dir/or/file
                #/path/to/dir/or
            dirname /
                #outputs /

    ##strings

        #search for printable strings in file

        #prints sequences of at least 4 printable chars by default

        #useful to extract information from non textual formats,
        #which contain some textual data

        gcc c.c
        strings a.out

    ##sed

        ##sources

            #beginner to pro tutorial: <http://www.grymoire.com/Unix/Sed.html>

        #Stream EDitor

        #posix 7

        #modifies files non-interactively

        ##learning suggestion

            #consider using <#perl> instead of this

            #sed has only slightly better golfing than perl

        ##s command

            #substitute

            assert [ "`echo $'aba\ncd' | sed 's/a/b/'`" = $'bba\ncd' ]

            ##g modifier

                assert [ "`echo 'aba' | sed 's/a/b/g'`" = $'bbb' ]

            ##patterns are BREs

                assert [ "`echo 'aa' | sed 's/[[:alpha:]]/b/'`" = 'ba' ]
                assert [ "`echo 'aa' | sed 's/.+/b/'`" = 'ab' ]
                    #+ is ordinary, thus BRE, and no match

                ##EREs with -r

                    #therefore always use -r for regexes

                        assert [ "echo 'aa' | `sed -r 's/.+/b/'`" = 'b' ]

            ##replace references

                    assert [ "`echo a1 | sed -r 's/a(.)/b\1/'`" = 'b1' ]
                    assert [ "`echo a1 | sed -r 's/a(.)/b\\1/'`" = 'b\1' ]
                    assert [ "`echo a1 | sed -r 's/a(.)/\0&/'`" = 'a1a1' ]
                        #\0 and & both refer to the entire match
                    assert [ "`echo a1 | sed -r 's/a(.)/\&/'`" = '&' ]

                    #no non-greedy *? operator. use [^]* combo instead

            ##flags

                ##g

                    #replace as many times as possible in string

                ##p

                    #is can also be a flag, besides being the print command

                ##w

                    #write lines to file:
                        echo $'a\nb\na' | sed -n 's/a/A/w f'
                        assert [ "`cat a`" = $'A\nA' ]

        ##/

            #only exec next command if match

            assert [ "`echo $'a\nb' | sed -n '/a/p'`" = $'a' ]

        ##restrict lines

            #line number:
                assert [ "`echo $'a\nb' | sed -n '1 p'`" = $'a' ]

            #last line:
                assert [ "`echo $'a\nb' | sed -n '$ p'`" = $'b' ]

            #before last line:
                assert [ "`echo $'a\nb' | sed -n '$-1 p'`" = $'a' ]

            #line matches pattern:
                assert [ "`echo $'a\nb' | sed '/a/ s/./c/'`" = $'c\nb' ]

            #line range:
                assert [ "`echo $'a\nb\nc\nd' | sed '1,3 s/./e/'`" = $'e\ne\ne\nd' ]

            ##pattern range

                assert [ "`echo $'a\nb\nc\nd' | sed '/a/,/c/ s/./0/'`" = $'0\n0\n0\nd' ]

                #non-greedy:
                    assert [ "`echo $'a\nb\n0\n0\na\nb' | sed '/a/,/b/ s/./A/'`" = $'A\nA\n0\n0\nA\nA' ]

            ##multiple commands per restriction

                assert [ "`echo $'a\nb' | sed '1 {s/./c/; s/c/d/}'`" = $'d\nb' ]

            ##!

                #negation

                #act on non matching

                    assert [ "`echo $'a\nb' | sed -n '1! p'`" = $'b' ]
                    assert [ "`echo $'a\nb' | sed -n '/a/! p'`" = $'b' ]

        ##multiple commands

            #concatenate with ; or newlines

            assert [ "`echo $'a\nb' | sed '/a/ s/./B/; /B/ {s/B/C/; s/C/D/}'`" = $'D\nb' ]

        ##q

            #quit

            assert [ "`echo $'a\nb' | sed 's/./c/; q'`" = $'c' ]

        ##d

            #delete

            assert [ "`echo $'a\nb' | sed '/a/ d'`" = $'b' ]

        ##a, i, c

            #append (after), insert (before), change

            assert [ "`echo $'a\nb' | sed '1 i 0'`" = $'a\n0\nb' ]
            assert [ "`echo $'a\nb' | sed '1 i 0'`" = $'0\na\nb' ]
            assert [ "`echo $'a\nb' | sed '1 c 0'`" = $'0\nb' ]

            ##newlines and spaces

                assert [ "`echo $'a\nb' | sed '1 c 0 1\n2 3'`" = $'0 1\n2 3\nb' ]

        ##line number

            #=

            assert [ "`echo $'a\nb\na' | sed -n '/a/ ='`" = $'1\n3' ]

        ##replace chars

            #y

            assert [ "`echo $'a\nb' | sed -n 'y/ab/01'`" = $'0\n1' ]
            assert [ "`echo $'a\nb' | sed -n 'y/ab/AB'`" = $'A\nB' ]

        ##multiline

            #- pattern space: buffer that holds each line.

                #`s//` modifies pattern space

            #- n: empty pattern space, put next line into it. default action at end.

                #print first line after matching `/a/`:
                    assert [ "`echo $'a\nb' | sed -n '/a/ {n;p}'`" = $'b' ]

                #print second line after matching `/a/`:
                    assert [ "`echo $'a\nb\nc' | sed -n '/a/ {n;n;p}'`" = $'c' ]

            #- N: append next line to pattern space. Next line is not read again.

                    assert [ "`echo $'a\nb' | sed -n '/a/ {N;p};'`" = $'a\nb' ]
                    assert [ "`echo $'a\nb' | sed -n '/b/ p; /a/ {N;p};'`" = $'a\nb' ]

            #- p: print entire pattern space. default action at end if no `-n`.

            #- P: print up to first newline.

                    assert [ "`echo $'a\nb' | sed -n '/a/ N'`" = $'b' ]

            #- d: delete pattern space. go to next line. *Is a loop continue*

            #- D: delete first line of pattern space. go to next line.

        ##hold buffer

            #there is an storage area called **hold buffer** in addition to the pattern buffer

            #it can contain the strings

            ##h

                #put pattern buffer into storage

            ##x

                #exchange storage and pattern

                #print old/new newline pairs after substitution
                    assert [ "`echo $'a\nb' | sed -n 'h; /a/ {s/a/c/; s/$/\n/; x;p;x;p}'`" = $'a\nc\n' ]

                #print first line before matching `/b/`:
                    assert [ "`echo $'a\nb' | sed -n '/b/ {x;p;d}; h'`" = $'a' ]

            ##g

                #pattern space = hold space

                    assert [ "`echo $'a\nb' | sed -n 'h; /a/ {s/a/c/;x;p;g;p}'`" = $'a\nc' ]

            ##G

                #pattern space += hold space

                assert [ "`echo $'a\nb' | sed -n 'h; /a/ {s/a/c/;x;G;p}'`" = $'a\nc' ]

        ##goto

            ##label

                #:label

                #may be on same line as command, ex: `:l s/a/b/` is the same as `:l; s/a/b`

            ##b

                #unconditional

                assert [ "`echo $'a\nb' | sed '/a/ b c; s/./c/; :c'`" = $'a\nc' ]
                assert [ "`echo $'a\nb' | sed '/a/ b c; s/./c/; :c s/c/d'`" = $'a\nd' ]

            ##t

                #jump if last s changed pattern space

                #remove spaces after a:
                assert [ "`echo $'a  b  c' | sed ':a s/a /a/; t a'`" = $'ab  c' ]

                #remove everything between a and c
                assert [ "`echo $'a  b  c' | sed ':a s/a[^c]/a/; t a'`" = $'ac' ]

        ##command line arguments

            ##-n

                #-n: don't print all lines (default)

                sed -n 's/find/repl/gp'
                    #/p: print if match
                    #prints only lines that match find
                    #does not change f

                sed -n '/find/p'
                    #same as grep

            ##-i

                f=f
                echo $'a\nb' > "$f"
                sed -i 's/a/A/' "$f"
                assert [ "`cat "$f"`" = $'A\nb' ]

                sed -i.bak 's/A/a/' "$f"
                    #baks up old file with .bak suffix
                assert [ "`cat "$f"`" = $'a\nb' ]
                assert [ "`cat "$f".bak`" = $'A\nb' ]
                assert [ `ls | wc -l` = 2 ]

                    #-i: in place

                    #whatever it would print to stdout, writes to the input file instead

                    #cannot be used with stdin input!

            ##-e

                #execute

                #give multiple commands

                #execute in each line in given order

                #same as ; concatenating commands

                assert [ "`echo $'a\nb' | sed -e 's/a/b/' -e 's/b/c/'`" = $'c\nc' ]

            ##-f

                #read commands from given file

                #one command per line

                ##shebang

                    #can exec sed script with following shebang:

                    #!/bin/sed -f

        ##combos

            #if modified, print line number, old line, new line
            #
            #Ex:
            #
            #input:
            #
            #a
            #b
            #a
            #b
            #
            #regex: s/a/c/
            #
            #output:
            #
            #1
            #a
            #c
            #
            #3
            #a
            #c

            assert [ "`echo $'a\nb\na\nb' | sed -n 'h; s/a/c/; t p; d; :p {=;x;G;s/$/\n/;p}'`" = $'1\na\nc\n\n3\na\nc\n' ]

    ##awk

        #use only for text table field manipulation

        #consider not to learn this and just learn pearl one liners instead
        #since pearl is more flexible, powerful, good for golfing and has similar syntax

        #awk only gets slightly better golfing on a very limited problem set

        #for more complex tasks, use python or real databases

        #variables

            #same as c

            #initialized to 0.

            #$0: entire record
            #$\n: fields
            #last field: $(NF-1)

            ##FS
                #field (column) separator
                #FS=':' FS=/[[:space:]]/ -F'/[[:space:]]/'
            #OFS: output field separator
            #RS: record (line) separator
            #ORS: output ""
            #NF: number of fields
            #NR: number of current record
            #FNR: total number of records in cur file

        #arithmetic: same as c
        #string comp: ~, !~
        #posix ERE regex: ~// !~// (inner match ok)
        #if else for while: like c

        echo $'1 2\n3 4' | awk 'BEGIN{print "b"}1<2{print "l"}1<2{print "l2"; print "l3"}1>2{print "l4"}END{print "e"}'
            #$'b\nl\nl2\nl3\nl\nl2\nl3\ne

        echo '0.5 0.5' | awk '{print $1+$2}'
            #1

        ##string num conversion

            awk 'BEGIN{print "1"+1}'
            awk 'BEGIN{print " 1"+1}'
                #2

        ##print

            awk 'BEGIN{print "a", 1}'
                #'a 1'
                    #by default, print does space separation
            awk 'BEGIN{print "a"."b"}'
                #'ab'
                    #string concat
            awk '{print}'
                #cat

    ##m4

        #macro language

        sudo aptitude install -y m4

        #TODO

##moreutils

    #extra base linux utils

        sudo aptitude install moreutils

    ##sponge

        #solves the input to output problem problem

        #setup:

            echo $'0\n1' > a

        #fails:

            grep 0 a | cat > a
            assert [ "`cat a`" = '' ]

        #works:

            grep 0 a | sponge a
            assert [ "`cat a`" = '0' ]

    ##vipe

        #use editor (aka vim =)) in the middle of a pipe

            EDITOR=vim
            seq 10 | vipe | less

            a="`seq 10 | vipe`"
            echo "$a"

        #uses editor environment variable to determine editor

        #in ubuntu, this is set by default to vim in bashrc.

        #this is my preferred way to get user
        #input that might be large (git commit messages...)

            a="`echo -e "\n#lines starting with '#' will be ignored" | vipe | grep -Ev '^#' `"
            echo "$a"

##character encodings

    ##chinese

        #- Guobiao is mainly used in Mainland China and Singapore. Named as `GB\d+`
        #- Big5, used in Taiwan, Hong Kong and Macau

        #`file` does not work properly for chinese

    ##dos2unix

        #CR LF to CR

        #in place:

            echo -e 'a\r\nb\r\n' > a.txt
            dos2unix a.txt
            assert [ "`cat a.txt`" = $'a\nb\n' ]

    ##enca

        #detect and convert international encodings

        #guess encoding:

            enca a.txt

        #this may not work if you don't give the expected language as input.

        #view available languages:

            enca --list languages

        #tell enca that the file is in chinese:

            enca -L zh a.txt

        #you give languages as locales
        #(i think as 2 letter iso 639-1 codes <http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes> since only `zh` worked for chinese)

    ##iconv

        #convet character encodings

        #major encodings
            #ASCII
            #UTF-8
            #UTF-16
            #chinese only:
                #GB18030: Guobiao Mainland China and Singapore. prefixed by GB, latest version GB18030
                #BIG-5: Taiwan, Hong Kong and Macau, is a one or two byte encoding.

        iconv -l
            #list available encodings

        iconv -f BIG-FIVE -t UTF-8 "$F"
            #convert contents of F from BIG-FIVE to UTF-8
            #no changes made: only outputs to stdout

    ##convmv

        #mv converting encodings

            sudo aptitude install convmv

##cron

    #you can't launch graphical applications!

    crontab -e
    #edit user cron jobs in vim
    #1 2 3 4 5 /path/to/cmd.sh arg1 arg2 >/dev/null 2>&1
        #1: Minute (0-59)
        #2: Hours (0-23)
        #3: Day (0-31)
        #4: Month (0-12 [12 == December])
        #5: Day of the week(0-7 [7 or 0 == sunday])
        #/path/to/command - Script or command name to schedule#
        #
        #* : every
        #*/5 : every five
        #1,3,6 : several
        #1-5 : ranges
        #
        #>/dev/null 2>&1 to avoid recieving emails
        #
        #otherwise:
        #MAILTO="vivek@nixcraft.in"
        #1 2 3 ...

        crontab -l
            #list all cronjobs
        crontab -u user -l
            #for a given user
        crontab -r
            #erase all crontabs
        crontab -r -u username
            #for a given user only

        #@reboot	Run once, at startup.
        #@yearly	Run once a year, "0 0 1 1 *".
        #@annually	(same as @yearly)
        #@monthly	Run once a month, "0 0 1 * *".
        #@weekly	Run once a week, "0 0 * * 0".
        #@daily	Run once a day, "0 0 * * *".
        #@midnight	(same as @daily)
        #@hourly	Run once an hour, "0 * * * *".
        #
        #can use instead of the 5 fields

    ##at

        #schedule job at a single specified time

        #not for a periodic job!

        cd "`mktemp -d`"
        echo "touch a" | at now + 1 minutes
            #in one minute `test -f a`
        echo "echo a" | at now + 1 minutes
            #nothing happens!
            #of course, job does not run in current shell
        echo "xeyes" | at now + 1 minutes
            #nothing happens

        atq
            #list jobs

        atrm 1
            #remove job with id 1
            #id can be found on atq output

        #inner workings

            echo "touch a" | at now + 10 minutes
            d=/var/spool/cron/atjobs
            sudo cat "$d/$(sudo ls "$d" | head -n 1)"
                #note how the entire environment
                #and current dir are saved and restored

            sudo cat /usr/lib/cron/at.allow
                #if exists, only listed users can `at`
            sudo cat /usr/lib/cron/at.deny
                #if allow exists, this is ignored!
                #if not, denies only to listed users

    ##batch

        #posix 7

        #superset of `at`

        #execute only when system load average goes below 1.5
        #starting from now!

        cd "`mktemp -d`"
        echo "touch a" | batch

        echo "touch a" | at -q b now
            #same, but with at you can change to any time

##hd

    #hard disk, mount partitions and filesystem

    ##du

        du -sh * | sort -hr
            #disk usage per file/dir
                #s: summarize: only for dirs in *
                #h: human readable: G, M, b

    ##paritions

        #you should unmount partitions before making change to them!

        ##df

            #show partitions, total and free space of each

            df -h
                #h: like `du -h`
            df -h | sort -hrk2
                #sort by total size

        ##parition devices

            #each hd gets a device

            #each partition gets a device

            #you can only have 4 primary partitions

            #each one can be divided into logical partitions

            #primary partitions get numbers from 1 to 4

            #logical partitions get numbers starting from 5

            ls -l /dev | grep -E ' (sd|hd)..?$'
                #hda
                #hda1
                #hda2
                #hda5
                #sdb
                #sdb1
                #sdb2
                #sdb3
                #hdc
                #hdc1
                #^^^^
                #1 23
                #1: partition type. hd: IDE (older). sb: SCSI (newer)
                #2: hard disk identifier.
                #3: parition number inside hard disk.
                #
                #example above:
                #3 hds: had, sdb and hdc
                    #1 and 3 are hd
                    #2 is sd
                #1 has 3 partitions
                #...

        ##label

            #an ext concept

            #determines the mount name for the partition

            #should be unique, but not sure this is enforced.

            ##e2label

                #get/set ext[234] label info

                sudo e2label /dev/sda7
                sudo e2label /dev/sda new_label
                    #sets new label for partition

                #each partition may have a label up to 16 chars length.
                #if it does, th partition will get that name when mounted.

            ##list all labels:

                sudo blkid

        ##filesystem type

            ##ext[234]: linux today
                #on ext4, only one dir is created: lost+found
            ##ntfs: windows today
            ##nfat: dos

            #to find out types see: <#blkid> or <#lsblk>

        ##uuid

            #given when you create of format a partition

            #to view them, see <#blkid> or <#lsblk> or <#gparted>

        ##swap

            #used by os to store unused ram

            #should be as large as your ram more or less, or twice it.

            #can be shared by multiple os, since only one os can run at a time.

            sudo swapon /dev/sda7
                #tur swap on on partition /dev/sda7
            swapon -s
                #find the swap partition used on cur os

            sudo swapoff
                #disable swap partition

            sudo mkswap -U random /dev/sda7
                #make a swap partition on partition with random uuid
                #swap must be off

        ##blkid

            #get UUID, label and filesystem type for all partitions

            sudo blkid

        ##lsblk

            #list block devices (such as partitions)

            sudo lsblk -f
                #show filesystems (partitions) only
                #shows type, label and mountpoint
            sudo lsblk
                #lis all block devices.
                #to me, also lists `/dev/sr0`, my dvd.
            sudo lsblk -no UUID /dev/sda1
                #get UUID only

        ##/dev/disk

            #symliks to partition identifiers

            #allows you to get identifier info

            #if id no present, link not there

            cd /dev/disk/
            ls -l
                #by-id
                #by-label
                #by-path
                #by-uuid

            ls -l by-id

        ##fdisk

            #format disk

            #better use <#gparted> if you have X11

            #edit partition table. does not create filesystems. for that see: <#mke2fs>

            #to view/edit partitions with interactive cli prompt interface

            #does not show labels and where partitions are mounted

            sudo fdisk -l /dev/sda
                #show partition table of hd
            sudo fdisk /dev/sda
                #view/edit partitions for hd sda

            #a primary parition that is split into logical paritions is called `extended`

            #logical partitions are limited to 16 scsi and 53 ide total.

            #interesting line:
                #255 heads, 63 sectors/track, 60801 cylinders, total 976773168 sectors
                #255 ^^^^^, 63 ^^^^^^^/^^^^^, 60801 ^^^^^^^^^, total 976773168 sectors
                #    1         2       3            4
                #
                #2: sector: smalles adressable memory in hd. you must get the whole sector at once.
                #4: defaults: rw, suid, dev, exec, auto, nouser, and async
                #
                #to understand, must see images:
                #
                #  <http://osr507doc.sco.com/en/HANDBOOK/hdi_dkinit.html>
                #  <http://en.wikipedia.org/wiki/Track_%28disk_drive%29>

        ##mke2fs

            #make ext[234] partitions

            #better use <#gparted> if you have X11

        ##gparted

            #gui to <#fdisk> + <#mke2fs>

            #really easy to use and informative

            sudo aptitude install -y gparted

            ##format an external hd
                #- erase partition table and create new one
                #- gpt seems to be a good choice of partition table type.
                #- create a partiion on the hd.
                #- ntfs seems to be best cross platform choice now.
                #- give a label. it will be mounted like that. I choose 300g for my 300 Gb hd.
                #- all ops are very quick!

    ##mount

        sudo mount /dev/sda1 /media/win/
            #mount /dev/sda1 on /media/win/

        ##bind

            #make one dir a copy of the other

            mkdir a
            mkdir b
            sudo mount --bind a b
            touch a/a
            touch b/b
            assert [ `ls a` = $'a\nb' ]
            assert [ `ls b` = $'a\nb' ]
            sudo umount b
            assert [ `ls a` = $'a\nb' ]
            assert [ -z `ls b` ]

    ##umount

        sudo umount /media/win/
            #unmount what is on this dir

    ##/etc/fstab

        #source
            firefox http://www.tuxfiles.org/linuxhelp/fstab.html
            firefox https://wiki.archlinux.org/index.php/Fstab
            man fstab
            man mount
                #options are here

        #list partitions that should mount up at startup
        #and where to mount them

        sudo cp /etc/fstab /etc/fstab.bak
        sudo vim /etc/fstab
        sudo mount -a
            #apply changes
            #only mounts `auto` option set.

        #syntax:

            #<file system> <mount point>   <type>  <options>       <dump>  <pass>
            #1             2               3       4               5       6
            #1: identifier to the file system.
                #Ex:
                    #- /dev/sda1
                    #- UUID=ABCD1234ABCD1234
                    #- LABEL=mylabel
            #2: where it will get mounted.
                #On ubuntu: make a subdir of /media like /media/windows
                #This dir must exist before mount
                #and preferably be used only for mounting a single filesystem.
                #I don't think fstab can auto create/remove the missing dirs.
            #3: type. ext[234], ntfs, etc.
            #see sources for others.

            ##windows
                #use:
                umask=111,dmask=000
                #this way, dirs will be 000 and files 666 (not executable)
                #see <#umask> to understand better

            ##dvd

                #mounting dvds/usbs is similar to mounting partitions:
                /dev/cdrom 	/media/dvd 	noauto 	ro 0 0
                #however if you use auto, you always get errors when the dvd is empty

                #it is best to use auto, because dvd can be of several formats.

    ##fuser

        fuser -m /dev/sdb1
            #which processes are keeping device busy

    ##fsck

        #check and repair linux filesystems

##system info

    ##uname

        #gets information on host computer

        #POSIX 7

        #print all info uname has to give:

            uname -a

        #this includes kernel version, user, ...

        #you can each isolated with other opts

    ##processor

        ##arch

            #architecture

            #subset of <#uname>

            arch
                #i686

        ##mpstat

            #processor related stats

            mpstat

        ##nproc

            #number of processing unites (= cores?)

            #coreutils

            nproc
                #4

    ##lsof

        #list all open files and pipes

        #COMMAND process name.
        #PID process ID
        #USER Username
        #FD file descriptor
        #TYPE node type of the file
        #DEVICE device number
        #SIZE file size
        #NODE node number
        #NAME full path of the file name.
        #
        #-u user : by given user

            lsof | less

    ##performance

        ##free

            #show RAM and swap memory in Megabytes

            #-t totals at bottom
            #-sN : repeat every N seconds

            free -m

        ##vmstat

            #memory, sway, io, cpu

            #run every 1s, 100 times

                vmstat 1 100

            #Vmstat procs Section

                    #r field: Total number of runnable process
                    #b field: Total number of blocked process

            #Memory section

                    #Swpd field: Used swap space
                    #Free field: Available free RAM
                    #Buff field: RAM used for buffers
                    #Cache field: RAM used for filesystem cache

            #Swap Section

                    #Si field: Amount of memory swapped from disk per second
                    #So field: Amount of memory swapped to disk per second

            #IO Section

                    #Bi field: Blocks received from disk
                    #Bo field: Blocks sent to disk.

            #System Section

                    #In field: Number of interrupts per second.
                        #move you mouse and see this go up!

                    #Cs field: Number of context switches per second.

            #CPU Section

                    #Us field: Time spend running user code. (non-kernel code)
                    #Sy field: Time spent running kernel code.
                    #Id field: Idle time.
                    #Wa field: Time spent waiting for the IO

        ##sar

            #long term performance statistics

            sudo aptitude install -y sysstat
            #crontab -e
            #
            #paste:
            #*/5 * * * * root /usr/lib/sa/sa1 1 1

            sar -u
                #cpu usage

            sar –d
                #disk io stats

            sar -n DEV | more
            sar -n SOCK |more
                #network stats

    ##hardware info

        ##bus

            ##usb

                #new: usb 3.0
                #old still existing: usb 2.0

                #current uses: mouse, keyboard, external hard disks, external cd, flash storage devices

                #several device classes

                #several connector types: Standard-A, Standard-B, Micro-B, Mini-B
                #<http://en.wikipedia.org/wiki/File:Usb_connectors.JPG>

                #3.0:

                    #full duplex
                    #8 pins
                    #voltage: 5 V
                    #power: max 0.9 A (5V)
                    #signaling rate: 5 Gbit/s (Super Speed mode)
                    #maximal cable length: 5 meters

                    ##differentiate from usb 2.0

                        #3.0 tipically blue while 2.0 black

                        #3.0 has 8 pins instead of 4

                        #ss for super spped may be written

                        #<http://www.usb3.com/usb3-info.html>

                ##libusb

                    #control usbs

                    sudo aptitude install -y libusb-dev
                    sudo aptitude install -y libusb++-dev

            ##firewire

            ##ethernet

                #

        cat /proc/cpuinfo
            #cpu info

        cat /proc/meminfo
            #mem info

        ##lspci

            sudo lspci

        ##hwinfo

            sudo aptitude install -y hwinfo

            hwinfo | less

##process

    ##bash

        #get cur pid:

            echo $$
            echo $pid

    ##pwd

        #print working directory of process

        #each program has a working directory set by the os

        #processes inherit working directory of calling process

        mkdir a
        chmod 777 a
        echo pwd > a/a
        chmod 777 a/a
        ./a/a
            #`pwd`
            #outside /a, the working directory of the caller (bash cwd)

    ##pwdx

        #print current working directory of given process

            pwdx $pid

    ##sleep

        #POSIX 7

        sleep 2
            #do nothing for 2 seconds

    ##wait

        #POSIX 7

        #wait for process with given pid to terminate

        #sets $! to the pid of the waited process

        #sleep 2 seconds and echo done:
            sleep 3 &
            wait $!
            echo $?

        #gets `$?` right even if process over already:
            false &
            sleep 2
            true
            wait $!
            assert [ "`echo $?`" = 1 ]

            true &
            sleep 2
            false
            wait $!
            assert [ "`echo $?`" = 0 ]

    ##ps

        #POSIX 7

        #list current executing processes and their info

        #psmisc package

        sleep 100
        sleep 100
        ps
            #see processes running on current tty
            #pid
                #unique identifier for all process on system
            #tty
                #from which tty it was launched
            #time
                #cpu time used for process
                #not real time
            #cmd
                #command that launched th process
                #without command line args

        ps -A
            #see all process on system

        ps -Am
            #shows thrads of each process

        ps -Al
            #shows lots of extra columns in addition to the 4 default:

        ps -A --sort cmd,-time,pid,-tty
            #sort output
            #cmd
            #time reversed (-)
            #pid
            #tty reversed (-)

        p=
        ps -p $p -o ppid=
            #get pid of parent of process with pid p

    ##kill

        #POSIX 7

        #send signals to a process

        #not necessarily kill signal

        #it is unfortunatelly named kill because most signals end killing process,
        #or also because the most used signal is SIGTERM generated by a C-C on the terminal.
        #which has the usual effect of killing a process.

        #list all signals available on the system:

            kill -l

        #lists numbers and descriptions

        #send TERM signal to process:

            ps -A
            ID=
            kill $ID

        #select by pid, found on ps for example

        #select by jobid found on jobs

            jobs
            ID=
            kill $ID

        #send stop signal to process:

            kill -STOP $ID

        #send continue signal to process:

            kill -CONT $ID

    ##env

        #POSIX 7

        #shows all environment variables and their values:

            env

        #change environment for a single command:

            a=b
            env a=c echo $a
            #c
            echo $a
            #b

        ##-i

            #exec in a clean environment:

                assert [ "`env -i a=b env`" = "a=b" ]

            ##start a subshell in the cleanest env possible

                #don't forget: subshells inherit all exported vars

                    env -i bash --noprofile --norc
                    env
                    #some default vars might still be there!
                    #I get: SHLVL, PWD
                    exit

    ##killall

        #kill all process by name

        #psmisc package

    ##top

        #ncurses constantly updated process list

        #h: help
        #f: field add/remove/sort
        #k: kill process
        #arrow keys: move view

        ##uptime

            #echo first line of <#top>

            #sample:
                #23:00:13 up 12:00,  3 users,  load average: 0.72, 0.66, 0.6
                #^^^^^^^^ up ^^^^^,  ^ users,  load average: ^^^^, ^^^^, ^^^
                #1           2       3                       4     5     6
                #
                #1: cur time
                #2: how long the system has been up for
                #3: how many users are logged
                #4: load average for past 1  minute
                #5:                       5  minute
                #6:                       15 minutes

            ##load average

                #0.75: 0.75  as many scheduled tasks as your cpu can run
                    #rule of thumb maximum good value
                #1   :       as many scheduled tasks as your cpu can run
                    #break even point
                    #risky, a littly more and you are behind schedule
                #5   : 5x
                    #system critically overloaded

                #does not take into account how many cores you have!
                #ex: for a dual core, breakeven at 2.0!

    ##nohup

        #POSIX 7

        ##application

            #make a process that continues to run if calling bash dies:

                nohup firefox >/dev/null &
                exit

            #firefox still lives! it would be killed if it were not for nohup

        ##explanation

            #program ignores HUP (hangup) signal (signal is a linux os concept)

            #this signal is sent when the calling shell of a program is killed

            #most signals if uncaught (the case of most programs), kill the program

            #consequense: killing calling bash kills the program

            #*unless*, you use nohup

            #consequences of `nohup`:

            #- if stdin came from terminal (not pipe for example),
                #sdtin comes from `/dev/null` (you have no stdin!) instead

            #- if stdout would go to terminal (not pipe for example)
                #it is *appended to* `./nohup.out`, and if not possible from `$HOME/nohup.out`
                #instead
                #
                #if no stdout is generated, `nohup.out` is not created
                #
                #you can also redirect stdout to any file you want via `nohup cmd > file`
                #for example `nohup cmd > /dev/null` to ignore output
            #- the program is still visible in `jobs`, and may be killed with `kill %+`
            #- if you don't use `&`, it runs on foreground, preventing you from using bash

            #how to test all this:

                nohup bash -c 'for i in {1..10}; do echo $i; sleep 1; done'

            #try:

            #append `> f` to command
            #append `&`   to command

                jobs
                cat nohup.out

    ##timeout

        #run command for at most n seconds, and kill it if it does not finish in time

        #coreutils

            assert [ `timeout 3 bash -c 'for i in {1..2}; do echo $i; sleep 1; done'` = $'1\n2\n' ]
            assert [ `timeout 1 bash -c 'for i in {1..2}; do echo $i; sleep 1; done'` = $'1\n' ]

    ##nice

        #- -20: highest priority
        #- 20: lowest  priority

        #mnemonic: the nicest you are, the more you let others run!

        #POSIX 7

        #therefore the concept of niceness is included in POSIX

        #view nice of all processes:

            ps axl

        #run program with a nice of 10:

            nice -10 ./cmd

        #-10:

            sudo nice --10 ./cmd

        #you need sudo to decrease nice

        #change priority of process by PID:

            renice 16 -p 13245

    ##flock

        #puts an advisory file lock on given file while a command executes

            touch a
            flock a sleep 5 &

    ##pstree

        #psmisc package, not POSIX

        #shows tree of which process invocates which

            pstree

        #this works because in POSIX new processes are created exclusively
        #by forking from other processes, and parent information is stored
        #on each process, which dies if the parent dies

        #this is a very insightfull program to understand what happened after
        #the `init` process, first process on the system and common ancestor of all, started

        #particularaly interesting if you are on a graphical interface,
        #to understand where each process comes from

        #quotint `man pstree`, multiple processes with same name and parent are wrttin in short notation:

            #init-+-getty
            #     |-getty
            #     |-getty
            #     `-getty

        #becomes:

            #init---4*[getty]

        #threads (run parallel, but on same data, and cannot fork) are indicated by brackets:

            #icecast2---13*[{icecast2}]

        #means that `icecast2` has 13 threads.

    ##prtstat

        #TODO

    ##peekfd

        #TODO

    ##ipcs

        #list info on inter process communication facilities:

            ipcs

        #shows:

        #- shared mem
        #- semaphores
        #- message queues

        ##ipcrm

            #remove ipc facility

    ##chroot

        #execute single command with new root

        ##application

            #you mounted another linux system

            #you want to try it out from bash, without rebooting

            sudo chroot /media/other_linux /bin/env -i \
                    HOME=/root                  \
                    TERM="$TERM"                \
                    PS1='\u:\w\$ '              \
                    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
                ##1

                    #- -: regular file
                    #- d: dir
                    #- l: symlink (not for hardlink)
                    #- p: named pipe (fifo)
                    #- s: unix socket
                    #- c: character file
                    #- d: block device file

                    /bin/bash --login

            #`/bin/env` and `/bin/bash` must exist relavive to `/media/other_linux`

            #TODO check this and get asserts working =)

##files

    ##ls
        #POSIX

        #list files in dirs

        #posix 7

        ##-l

        #show lots of information:

            ls -l

        #sample output:

            #-rw-rw-r-- 1 ciro ciro    4 Feb 25 11:53 a
            #1          2 3    4       5 6            7

        #1) file permissions. See <#permissions>
        #2) for files, number of hardlinks. For dirs number of subdirs + parent + self (min is 2 therefore)
        #3) owner
        #4) group
        #5) size in bytes
        #6) last modified
        #7) filename

        #ls is aware if its ouput goes to a pipe or not.
        #if yes, automatically newline separates it:

            ls | cat

        #one per line:

            ls -1

        #ls a file:

            touch a
            assert [ "$(ls a)" = "a" ]

        #ls a dir:

            mkdir d
            touch d/a d/b
            assert [ "$(ls d)" = "$(echo $'a\nb')" ]

        #ls many dirs:

            mkdir d
            touch d/a d/b
            mkdir e
            touch e/a e/b
            ls d e
                #nice listing of both

        #-d: list dirnames only:

            mkdir d
            touch d/a d/b
            mkdir e
            touch e/a e/b
            assert [ "$(ls -d d e)" = "$(echo $'d\ne')" ]

        #-lL : when showing symlinks, shows info to what is linked to

        ##sort

            #modification time (newest first):

                ls -t

            #inode change:

                ls -tc

            #file access:

                ls -tu

            #reverse sort order:

                ls -tr

        ##dircolors

            #config <#ls> colors

        ##gnu extensions

            #-R: recursive

                ls -R

    ##tree

        #prints visual file tree

        #install:

            sudo aptitude install tre

        #recurse 2 levels (default infinite):

            tree -L 2

        #-a: include hidden:

            tree -a

        ##--charset

            #select a smaller charset for output:

                tree --charset=ascii

            #this is good if you want to paste output!

    ##cd
        #POSIX

        #go to dir

            mkdir d
            cd d
            pwd

        #goto home dir:

            cd
            cd ~

        #go back to last dir:

            cd -

        #only works once

        #-a : (all) show hidden files
        #-h : human readable filesizes
        #-l : long. one per line, lots of data.

            cd -alh

        #PATH variable for cd!

            CDPATH=/usr/:~
            cd
            mkdir a
            mkdir b
            cd b
            cd a
            pwd
                #~/a

    ##touch

        #POSIX

        touch f
            #creates file if does not exist.
            #updates modify date to present if exists

    ##mkdir

        #POSIX

        #make dirs

        #make a dir:

            mkdir "$d"

        #no error if existant:

            mkdir d
            mkdir -p d

        #make parent dirs if not existent:

            mkdir -p a/b/c/d

        #-m: set mode of new dir (permissions)

            mkdir -m 1777 d
            assert [ `stat -c "%A" d` = 'drwxrwxrwt' ]

    ##mv

        #POSIX

        #move or rename files and dirs

        ##files

            #if dest does not exist, move the file to it:

                mkdir d
                touch d/a
                mkdir d2
                mv d/a d2/b
                assert [ "`ls d`" = '' ]
                assert [ "`ls d2`" = 'b' ]

            #if dest exists and is a file, overwrite by default:

                echo a > a
                echo b > b
                mv a b
                assert [ "`ls`" = "b" ]
                assert [ "`cat b`" = "a" ]

            #if dest exists and is a dir, move into dir:

                touch a
                mkdir d
                mv a d

        ##dirs

            #same as files except does not overwrite non empty dirs:

                mkdir d
                mkdir d2
                mkdir d2/d
                mv d d2
                    #d2/d was overwritten:
                assert [ "`ls`"     = "d2" ]
                assert [ "`ls d2`"  = "d" ]
                mkdir d
                touch d2/d/a
                mv d d2
                    #cannot mv: dir not empty

        ##-b

            #make backup if dest exits

            #if backupt exists, it is lost:

                touch a
                touch b

            #backup ~a is made:

                mv -b b a
                assert [ -f a ]
                assert [ -f a~ ]
                assert [ `ls | wc -l` = 2 ]

            #backup is only made if destination exists:

                mv -b a b
                assert [ -f a~ ]
                assert [ -f b ]
                assert [ `ls | wc -l` = 2 ]

            #if backup exists, it gets overwritten:

                touch a
                mv -b a b
                assert [ -f a ]
                assert [ -f a~ ]
                assert [ `ls | wc -l` = 2 ]

    ##cp

        #POSIX

        #copy files and dirs

        ##file

            #if dest does not exist, create it:

                echo a > a
                copy a b
                assert [ "`cat b`" = $'a' ]

            #if dest exists and is dir, copy into dir:

                mkdir d
                copy a d
                assert [ "`cat d/a`" = $'d/a' ]

            #if dest exists and is file, overwrite without asking!

                echo a > a
                echo b > b
                cp a b
                assert [ "`cat b`" = $'a' ]

        ##dir

                function setup_test
                {
                    mkdir d
                    echo a > a
                    echo a > d/a
                    mkdir d2
                    mkdir d2/d
                    echo A > d2/d/a
                    echo b > d2/d/b

                    mkdir d3
                    cd d3
                    ln -s ../d2 d
                    cd ..
                }

                function teardown_test
                {
                    rm -r a d d2 d3
                }

            #must use recursive `-r`, even if dir is empty

                setup_test
                if cp d e; then assert false; fi
                teardown_test

                setup_test
                cp -r d d2
                assert [ -d d2 ]
                teardown_test

            #unlike move, can copy into dir recursively overwritting by default:

                setup_test
                cp -r d d2
                assert [ "`ls d2/d`"    = 'a b' ]
                assert [ "`cat d2/d/a`"  = 'A' ]
                assert [ "`cat d2/d/b`"  = 'b' ]
                teardown_test

            #if fails however if you try to overwrite a file with a dir:

                setup_test
                if cp -r d a; then assert false; fi
                teardown_test

            #it also fails if you try to overwrite a link to a dir with a dir:

                setup_test
                if cp -r d d3; then assert false; fi
                teardown_test

        ##symlink

            #by default, for files copies content of symlinks to new files/dirs:

                echo a > a
                ln -s a b
                ln -s b c

                cp c d
                assert [ -f d ]
                assert [ "`cat a`" = $'a' ]

            #with `-d` copies symlink to files into new symlinks (mnemonic: no-Dereference):

                cp -d c e
                assert [ -L d ]

            #for dirs by default copies symlink into a new symlink:

                mkdir d
                ln -s d dln
                cp dln e
                assert [ -L e ]

            #to dereference symlinks to directories, use `-L`:

                mkdir d
                ln -s d dln
                cp -L dln e
                assert [ -d e ]

            #does not work with `-r`. Probable rationale:

                #the only thing this could do is to copy dirs
                #and symlink files

                #but then why not do this with hardlinks?

        ##hardlink

                echo a > a
                cp -l a b
                ln -l a b
                assert [ "`stat -c '%i' a`" = "`stat -c '%i' b `" ]

            #with `-r`, makes dirs, and hardlinks files:

                mkdir d
                touch d/a
                touch d/b
                cp -lr d e
                assert [ "`stat -c '%i' d/a`" = "`stat -c '%i' e/a `" ]
                assert [ "`stat -c '%i' d/b`" = "`stat -c '%i' e/b `" ]

            #if `-l` is used, does not overwrite file:

                echo a > a
                echo b > b
                if cp -l a b; then assert false; fi

            #but can overwrite if `-f` is given:

                cp -fl a b

    ##rename

        rename -n 's/^([0-9]) /0$1 /g' *.mp3
            #does not make changes to all .mp3 files

        rename 's/^([0-9]) /0$1 /g' *.mp3
            #makes changes

    ##cpio

        #TODO

        find . ! -iname '* - *' -type f -print | cpio -pvdumB './no author'
        #cfind selected files to destination, building and keeping their relative directory structure

    ##rsync

        #TODO powered up `cp`?

    ##install

        #move and set: mode, ownership and groups

        #make all components of path:

            install -d a/b/c
            assert [ -d a ]
            assert [ -d a/b ]
            assert [ -d a/b/c ]

    ##mkfifo

        #make a fifo (named pipe)

        mkfifo f
        echo a > f &
            #the other end of the pipe has not been opened to read
            #therefore the echo write system call blocks
        cat f
            #a
            #requests for data
            #echo sends its data
            #echo terminates
            #this closes the echo input pipe

            #TODO understand this!

    ##chown
        #POSIX

        #change owner and group of files

        #you must use sudo to do this, because otherwise users would be able to:

        #- steal ownership of files
        #- git ownership to users who do not want to own the files

            su a
            mkdir d
            touch d/f
            sudo chown newuser:newgroup d
                #must use sudo to chown
            assert [ `stat -c '%U' d` = newuser ]
            assert [ `stat -c '%G' d` = newgroup ]
            assert [ `stat -c '%U' d/f` = a ]

        #`-R` for recursive operation:

            su a
            mkdir d
            touch d/f
            sudo chown b d
            assert [ `stat -c '%U' d` = newuser ]
            assert [ `stat -c '%G' d` = newgroup ]
            assert [ `stat -c '%U' d/f` = newuser ]
            assert [ `stat -c '%G' d/f` = newgroup ]

        #to change only user:

            sudo chown newuser

        #to change only group:

            sudo chown :newgroup

    ##chmod

        #POSIX

        #change file permissions

        #chomod [ugoa][+-=][rwxXst]+
            chmod a+x "$f"
                #makes f executable for all (owner, group and other)
            chmod a+r "$f"
                #makes f readable for all
            #a vs nothing: umask
                umask 002
                chmod +w "$f"
                stat -c "%a" "$f"
                    #220
                chmod a=w "$f"
                stat -c "%a" "$f"
                    #222
                chmod o=w "$f"
                stat -c "%a" "$f"
                    #002
            chmod -x "$f"
                #makes f not executable for all
            chmod =r "$f"
                #makes file readable by all
                #makes file not executable and not writeble by all
            chmod u+x "$f"
                #makes f executable for owner
            chmod go+x "$f"
                #makes f executable for group and other
            chmod +rw "$f"
                #makes f readable and writible for all
            chmod +w "$f"
        chmod 777 "$f"
            #chmod =rwx

        #sticky bit, suid sgid bits

            #sticky

                chmod 1000 "$f"
                chmod o=t "$f"
                chmod a=t "$f"
                stat -c "%A" "$f"
                    #---------T
                chmod a-t "$f"
                chmod u=t "$f"
                chmod g=t "$f"
                stat -c "%A" "$f"
                    #---------T
            chmod =s "$f"
            chmod 6000
                #set suid and sgid
            chmod u=s "$f"
            chmod 4000
                #set suid and sgid
            chmod g=s "$f"
            chmod 2000
            #can't clear them on numeric mode! only symbolic!
                chmod 7777 f
                stat -c "%A" "$f"
                    #-rwsrwsrws
                chmod 0 f
                stat -c "%A" "$f"
                    #---S--S--T
                chmod a-st f
                stat -c "%A" "$f"
                    #----------

        #can only change permissions for files you own
        #even if you have all the permissions on the file:

            su a
            touch a
            chmod 777 a
            su b
            if ! chmod 770 a; then assert true; fi

    ##umask

        #shows/sets permissions that will be *removed*
        #this is system implemented, and interacts with certain system calls such as `open`
        #this also has direct effect on commands such as `chmod` and `touch`

        touch a
        ls -l a
            #rw-rw-r--
        umask
            #002
            #ok the other w was removed
            #the x are not set by touch by default
        umask 0
        touch b
            #rw-rw-rw-
        umask 777
        touch c
            #---------

    ##stat

        #POSIX

        #cli for sys_stat

        #get file/dir info such as:
        #- size
        #- owner
        #- group
        #- permissions
        #- last access date
        #- create date
        #- modify date

            touch f
            stat f
                #lots of info

        ##-c

            #format string

                chmod 1234 f
                assert [ `stat -c "%a" f` = "234" ]

                chmod a=rt f
                assert [ "`stat -c "%A" f`" = "-r--r--r-T" ]

            #inode:

                touch a
                ln a b
                assert [ "`stat -c "%i" a`" = "`stat -c '%i' b`" ]

        ##--print

            #like `-c` but interprets escapes like `\n`

                touch a
                echo "`stat --print "%a\n%a\n" a`"
                assert [ "`stat --print "\n" a`" = $'\n' ]

    ##links

        ##hard vs soft

            #TODO lazy

        ##ln

            #make hardlinks and symlinks

            #this can also be done with `cp`

            #hardlink:

                ln dest name

            #symlink files only:

                ln -s dest name

            #symlink dir:

                ln -ds dest name

            #the link will be created even if the destination does not exist:

                ln -s idontexist name

            #if the name is in another dir, the destination is not changed by default:

                mkdir d
                ln -s a d/a
                [ `readlink d/a` = a ] || exit 1

            #to create relative to dest use `-r`:

                mkdir d
                ln -rs a d/a
                [ `readlink d/a` = ../a ] || exit 1

            #if the name is in another dir, the destination is not changed by default:

            #absolute link:

                ln /full/path/to/dest name
                [ `readlink name` = "/full/path/to/dest" ] || exit 1

        ##readlink

            #get target of symlink

                touch a
                ln -s a b
                ln -s b c

                assert [ "`readlink c`" = $'b' ]
                assert [ "`readlink b`" = $'a' ]

            #recursive:

                assert [ "`readlink -f c`" = $'a' ]

        ##realpath

            #resolve all symbolic links and '.' and '..' entries of a path recursivelly

            #prefer <#readlink> which is more widespread by default in distros

            sudo aptitude install -y realpath

            mkdir a
            ln -s a b
            cd a
            touch a
            ln -s a b
            cd ..
            realpath ./b/b
                #= "`pwd`/a/a"

            #readlink -f

                #same:

                    readlink ./b/b

                #and is part of coreutils, so more widespread default.

    ##cmp

        cmp "$F" "$G"
        #compares F and G byte by byte, until first difference
        #if equal, print nothing
            #else, print location of first difference

        ##-s

            #silent

            #return status 0 if equal
            #!= 0 otherwise

                cmp -s "$F" "$G"
                if [ $? -eq 1 ]; then
                        echo neq
                else
                        echo eq
                fi

    ##find

        #recursivelly looks for files and dirs that match tons of possible criteria

        #prints filenames to stdout, or do some few other actions

        #great for combo with <#xargs>

        #consider <#ack> instead when for searching code

        ##preparation

            touch a b

        ##matching criteria

            ##-name

                #*entire* basename matches shell glob expression

                ##-iname

                    #case insensitive

                ##applications

                    #find by extension and act upon:

                        find . -type f -name '*.sh' | xargs cat

            ##-type

                #f for files only, d for directories only

                    find . -type f
                    find . -type d

            ##-perm

                #permissions

                #mass permission changing!

                #exact match:
                    find . -perm 444
                    find . -perm u+4,g+4,o+4

                #any one matches:

                    find . -perm +111

                #finds files that are readable by either u, g or o.

                ##applications

                    #give `g+x` to all files that have `u+x`:

                      find . -type f -perm +100 | xargs chmod g+x

            #-regex: entire basename matches emacs regex

        ##actions

            ##delete

                #deletes matching files

                    #find . -delete

                #very dangerous!

            ##printf

                #print formated data about files instead of filename

                #%p	filename, including name(s) of directory the file is in
                #%m	permissions of file, displayed in octal.
                #%f	displays the filename, no directory names are included
                #%g	name of the group the file belongs to.
                #%h	display name of directory file is in, filename isn't included.
                #%u	username of the owner of the file

                    find . -printf '%f'

        ##take multiple actions

            #this is the way to go:

                while IFS= read -r -u3 -d '' f; do echo "$f"; done 3< <(find . -type f -print0)

            #the only thing tha breaks this is having programs that use 3<. godlike

            #this reverses find order of the find output, allowing you to rename directories also (with this, directories)
            #will come last and be renamed last. -r is for 'reverse, and -z is for null terminated

                while IFS= read -r -u3 -d $'\0' FILE; do
                    echo "$FILE"
                done 3< <(find /tmp -type f -print0 | sort -rz)

        ##xargs

            #posix 7

            #do some command on lots of files.

            #great for combo with <#find>.

            ##alternatives

                #downsides of xargs:
                #- max number of arguments
                #- escaping madness for multiple commands

                #upsides of xargs:
                #- golfing!

                #in scripts, always use the more versatile (and slightly verbose) read while techinque:

                    while read f; do
                        echo "$f";
                    done < <(find .)

            ##test preparations

                    function f {
                        echo $1
                    }

            ##basic operation

                #read line from stdin, append as argument to the given command

                #does not automatically quote!

                #the default command is echo, which is basically useless

                    echo $'a\nb' | xargs
                    echo $'a\nb' | xargs echo
                    echo $'a\nb c' | xargs echo

                #empty lines are ignored:

                    echo $'a\n\nb' | xargs

            ##-0

                #read up to nul char instead of newline char

                #allows for files with spaces, and even newlines!

                    echo -en 'a\0b' | xargs -0

                #combo with `find -print0`:

                    find . -print0 | xargs -0

            ##-I

                #allows you to put the argument anywhere and to quote it

                      echo $'a\nb' | xargs -I '{}' echo '{}'

            ##multiple commands

                #must use bash

                #only use this for very simple commands, or you are in for an escaping hell!

                #if you have to do this, use the read while technique instead

                      echo $'a\nb' | xargs -I '{}' bash -c "echo 1: '{}'; echo 2: '{}'"

            ##applications

                #find and replace in files found with perl regex:

                    find . -type f | xargs perl -pie 's/a/A/g'

                ##find files whose path differ from other files only by case

                    #useful when copying from linux to a system that does not accept
                    #files that differ only by case (the case for MacOS and Windows)

                        find . | sort -f | uniq -di

                    #remove them:

                        find . | sort -f | uniq -di | xargs -I'{}' rm '{}'

    ##locate

        #searchs for files in entire computer

        #prints all matches

        #this uses a database, which must be updated with <#updatedb> before your new file is found

        #commonly, `updatedb` is a <#cronjob>

        locate a.h

        ##updatedb

            sudo updatedb

    ##file

        #determine file type

        #posix 7

        #this is in general impossible,
        #but program makes good guesses

        echo a > a
        file a
            #a: ASCII text

        ##-L

            #follow links

            echo a > a
            ln -s a b
            file b
                #b: symbolic link to `a'
            file -L b
                #b: ASCII text

    ##fuser

        #psmisc package

        #determines which process are using a file or directory

        #optionally sends signals to those processes

        fuser .
            #shows pids followed by a prostfix:
                #c      current directory
                #e      executable being run
                #f      open file. f is omitted in default display mode
                #F      open file for writing. F is omitted in default display mode
                #r      root directory
                #m      mmap’ed file or shared library

            #you will have at least one process here: your bash

        fuser -v .
            #shows program and user also

        fuser -v -n tcp 5000
            #check process using tcp/udp ports

    ##which

        #prints full path of executable in path

        which ls
            #/bin/ls
        which im-not-in-path
            #
        which im-not-executable
            #
        which cd
            #
            #cd is not a program! it is a bash builtin!

        ##application

            #quick and dirty install if not installed!

                if [ -z "`which zenity`" ]; then
                        sudo aptitude install zenity
                fi

            #could also be done bashonly with `type -P`.

    ##temp

        ##mktemp

            #create temporary directories and files in currend directory

            #creates a temporary file in `/tmp/`:

                f="$(mktemp)"
                echo "$f"
                assert test -f "$f"
                rm "$f"

            #directory:

                d="$(mktemp -d)"
                echo "$f"
                assert test -d "$d"
                rm -r "$d"

            #custom name template:

                f="$(mktemp --tmpdir abcXXXdef)"
                assert echo "$f" | grep -E 'abc...def'
                assert test -f "$f"
                rm "$f"

            #must use `--tmpdir` with template or else file is created in current dir

    ##pathchk

        #check if path is portable across posix systems

        pathchk -p 'a'
        pathchk -p '\'

    ##fdupes

        #fine command line tool for eliminating byte by byte duplicates
        #you can either
            #pick one by one
            #tell fdupes to pick the first one without asking (seem to pick one of the dirs first always)

        sudo aptitude install -y fdupes

        fdupes -r .
            #finds and prints dupes

        fdupes -rd .
            #finds dupes, and prompt which to keep for each match

##prompt user

    ##while read case

        #ask for user input, break into cases
        #if none of the cases is met, print error message and ask again.
        while true; do
                read -p "Which case do you want? case a [a], case b [b], case c [c])" c
                case "$c" in
                    "a" ) echo "Action for case a"; break;;
                    "b" ) echo "Action for case b"; break;;
                    "c" ) echo "Action for case c"; break;;
                    * ) echo "Does not match any of the possible cases. Try again."
                esac
        done

        #same as above, but for the ultra common case of yes [Y] no [n] case
        while true; do
                read -p "Yes or no? [Y/n]" yn
                case "$yn" in
                        Y ) ; break;;
                        n ) ; break;;
                        * ) echo "Please enter either 'Y' or 'n'.";;
                esac
        done

##yes

    #coreutils

    #repeat an output forever!

    yes
        #y
        #y
        #y
        #...

    yes a b c
        #a b c
        #a b c
        #a b c
        #...

    yes | timeout 1 cat

##users and groups

    #to play around with those in ubuntu, do ctrl+alt+f2, f3 ... f7
    #and you will go into login shells
    #so you can log with different users at the same time
    #while logged on a different shell, process on the other shells continue to run? TODO
        #totem stops
        #simple shell scripts continue

##setterm

    #outputs stdout that changes terminal properties

    #turns the cursor on/off:

        setterm -cursor off
        setterm -cursor on

    cat /etc/passwd
        #shows users
        #includes special users
        #format:
            #ciro:x:1000:1000:ciro,,,:/home/ciro:/bin/bash
            #ciro: user name
            #x: password is encrypted and stored in /etc/shadow
            #1000: user id. 0: root. 1-99: predefined. 100-999: reserved by system. 1000: first `normal` user
            #1000: primary user group
            #ciro,,, : comment field. used by finger command.
            #/home/ciro: home dir
            #/bin/bash: login shell

    cat /etc/group
        #show groups
        #format:
            #groupname:x:5:user1,user2,user3
            #x: encrypted pass if any
            #5: group id. `regular` groups start at 1000

        getent group "$g"
            #cat line of /etc/group for group g

    cat /etc/default/useradd

    ##groups

          groups "$u"
              #list groups of u
          groups
              #list groups of cur user

    ##who

        #list who is logged on system

        who

    ##last

        #list last user logins on system

        last

    ##whoami

        #print effective user name

        whoami

    ##id

        #shows user and groups id and names

        #whoami/groups superset

        id "$u"
            #for user u
        id
            #cur user
        id -u
            #effective userid
        id -un
            #effective username
        id -ur
            #real userid
        id -urn
            #real username
        id -g
            #groupid
        id -gn
            #groupname

    ##tty

        #show current tty

        tty
            #/dev/pts/1

    ##getty

        #the tty that runs on those ctrl-alt-F\d things

        cat /etc/default/console-setup

        ACTIVE_CONSOLES="/dev/tty[1-6]"
            #allow you to change the number of consoles and their locations

    ##su

        #become another user, such as root

        su otheruser
            #enter otheruser pass
        whoami
            #otheruser

        #BAD
            #never become root

            sudo passwd root
                #give root a pass so people can log into it
                #this is disabled by defaut on some systems as ubuntu for security
            su
                #enter root pass
            whoami
                #root

        #login

            #TODO login vs su?

        ##login shell

            su - a
                #start a login shell
                #without this starts a non-login shell

    ##sudo

        #do next single command as another user or super user

        #safer than becoming root with su

        #in order to see who can sudo what as who and with what pass

            sudo cat /etc/sudoers

            #syntax:

                #Defaults:ALL timestamp_timeout=0
                    #passwords for all users timeout 0
                #Defaults:ALL timestamp_timeout=15
                    #BAD
                    #after any user enters a pass, he can sudo without pass for 15 mins
                #main lines:
                    #user   hostip=(runas)NOPASSWD ALL
                    #%group hostip=(runas)        :/bin/ls,/bin/cat
                        #user: who will get sudo premissions
                            #add '%' for group: ex: %group ...
                            #can be ALL
                        #runas: who can he sudo as
                        #NOPASSWD: if present, must enter target user's password
                        #/bin/ls,/bin/cat: list of comma separated bins he can run, or ALL
                #aliases:
                    #user
                        #User_Alias FUSE_USERS = andy,ellz,matt,jamie
                        #FUSE_USERS ALL=(root):/usr/bin/the-application
                    #host:
                        #Host_Alias HOST = jaunty
                        #%admin HOST=(ALL)
                    #runas
                        #Runas_Alias USERS = root,andy,ellz,matt,jamie
                        #%admin  ALL=(USERS) ALL
                    #command
                        #Cmnd_Alias APT     = /usr/bin/apt-get update,/usr/bin/apt-get upgrade
                        #Cmnd_Alias USBDEV  = /usr/bin/unetbootin,/usr/bin/gnome-format
                        #ALL_PROGS = APT,USBDEV
                        #%admin  ALL=(ALL) ALL

            ##redirection

                #sudo passes stdin to the called program:
                    echo a | sudo cat
                        #a

                #cannot "echo to a file" directly:
                    su a
                    mkdir b
                    chown b b
                    #sudo echo a > b/a
                        #does not work
                    sudo bash -c 'echo a > b/a'
                        #works, but quoting is hell
                    echo a | tee b/a
                        #best method. shorter and no quoting hell

                #sudo echo a > b/a
                    #does not work
                echo a | tee -a b/a
                    #to append use -a

        ##ubuntu default

            #sudo group allows members to sudo whatever they want as root

            groups
                #sudo is in my groups!
            sudo whoami
                #root
            sudo -u test whoami
                #test
            sudo -l
                #find cur user sudo permissions
            sudo env
                #you don't have your cur users env anymore
                #you are root now!
            sudo env PATH=$PATH env
                #use your user's path on sudo
            #alias sudo='sudo env PATH=$PATH'
                #tempting, but it will make options fail!
                #sudo -L --> sudo env PATH=$PATH -l
                #env thinks -l is his option

    ##logout

        #logs out
        #can only be used on login shell

        logout

    ##faillog

        faillog -a
            #TODO understand output

    ##useradd

        u=
        sudo useradd -c '$fullname,$office,$office2,$homephone' -g 1000 -G 1001,1002 -m -s /bin/bash $u
            #addes user username u
            #-m makes home dir owned by him with permissions 707
                #without -m:
                    #ubuntu won't be able to log in
                    #if he logs in on tty, he goes to /
                    #to correct this:
                        sudo mkdir /home/$u
                        sudo chmod 700 /home/$u $u
                        sudo chown /home/$u $u

                    #home dir files will me copied from a default template located at `/etc/skel`
                    #to change this template use `-k /path/to/skel/`.
                    #to create no files: `-k /dev/null`

            #-p $p
                #bad because visible
                #without -p:
                    #user can't login
                    #to correct this:
                        sudo passwd $u
                            #sets passwd for u
            #-s sets login shell
                #without -s:
                    sudo chsh -s /bin/bash $u
                        #for u
                    sudo chsh -s /bin/bash
                        #cur user
            #-g: set group he belongs to
            #-G: add to other groups too
                #if g missing, either create a group u and add user
                #of add to a default group specified in some config file
            #-c: comment field of /etc/passwd
                #this format is used for `finger` command

                #chfn
                    sudo chfn -f full_name -r room_no -w work_ph -h home_ph -o other $u

                    #changes this info


        sudo useradd -e 2000-00-00 -f 5 $u
            #-e: password expires automatically at the given date.
            #-f: account disables 5 days after password expires if pass not changed.

    ##userdel

        #remove users
        #cannot be used on logged in users

        userdel $u
            #delete user, keep home
        userdel -r $u
            #delete user and his home

    ##groupadd

        #create new groups

            g=
            sudo groupadd $g

    ##usermod

        #add/remove users to groups

        #if you are the user, you have to logout/login again for changes to take effect

        #change primary group of user u to g:
            usermod -g $g $u

        g=1000,1001

        #Sets exactly the supplementary groups of user u.
        #Remove from non listed ones:

            usermod -G $g $u

        #Append (-a) groups g to supplementary groups of user u:

            usermod -aG $g $u

        #Change home dir of user u to d.
        #The old contents are not moved:

            usermod -d $d $u

        #Also move his current dir contents to new dir

            usermod -md $d $u

    ##passwd

        #set user passws

        passwd
            #change passwd for cur user
        sudo passwd "$u"
            #change passwd for u
            #if you are not u, you need sudo...
        sudo passwd -d "$u"
            #delete passwd for u, disabling his account

    ##chsh

        #change login shell

        less /etc/shells
            #view available shells
        chsh -s /bin/bash
            #change your shell to bash

    ##ac

        #connection statistics

        sudo aptitude install -y acct

        ac -d
        #current user connection in hours, broken by days

        ac -p
        #connection time for all users

    ##finger

        #shows user info
        #some data taken from /etc/passwd comment field

        sudo aptitude install -y finger

        finger "$u"
            #shows info on user u

        ##pinky

            #lightweight finger

            #coreutils package

    ##ldap

        #filesystem, printer, etc server over network

    ##radius

        #login server

        #freeradius major implementation

##languages

    ##bc

        #simple interpreted language, calulator focus

        #c-like syntax

        #features: variable definition, function definition, arrays, strings

        #non features: string concatenation

        #posix 7

            assert [ `echo '1+1' | bc` = 2 ]

    ##ruby

        #perl python concurrent

        ##gem

            #ruby package manager

            #install a package:

                sudo gem install pkg

    ##haskell

        #glasgow compiler is the main compiler implementation

        #compile:

            echo 'main = putStrLn "a"' > a.hs
            ghc a.hs
            [ `./a` = a ] || exit 1

        #standard REPL interpreter that comes with the glasgow compiler:

            ghci

##scanner

    ##simple-scan

        #very simple to scan! after installing the printer drivers.

            #simple-scan

        #then click scan button. The image updates as the scan is made,
        #and you can stop it when you are done before the scanner reached the bottom.

        #make sure your scanner supports the definition preferences you set
        #or you will get a connexion error

##graphics card

    ##find your graphics card

    sudo lspci | grep VGA
        #I get:
            #NVIDIA Corporation GF108 [Quadro NVS 5400M] (rev a1)
            #                                 ^^^^^^^^^
            #so my card is: `NVS 5400M`

    ##nvidia

        ##download driver

            #<http://www.nvidia.com/Download/index.aspx?lang=en-us>

            #select your card on the list

        ##software prerequisites:

            ./NVIDIA*.run --extract-only
            vim NVIDIA*/README

##libs

    #this is just a quick list, installation and cheats may go better
    #in other files/dirs since libs are usually large to understand

    ##performance note

        #to get the most out of applications, you have to
        #compile it on your own computer so that the compiler will
        #be able to make all the possible optimizations for your given
        #architecture.

    ##c

        sudo aptitude install -y linux-source linux-headers

        ##check

            #c unit testing

            sudo aptitude install -y check

        ##ncurses

            #command line interactive interfaces

                sudo aptitude install -y libncurses5-dev

        ##expat

            #xml parsing

        ##to evaluate

            ##PCRE

                #perl regexes. c11 has regexes.

            ##popt

                #parse command line options

    ##c++

        ##boost

            #cross platform utilities

            #very popular, largely influences c++ future

    ##glx

        #interface between opengl and x server

        #allows x windows to use opengl acceleration

        #must also support a given opengl version

        sudo aptitude install -y mesa-utils

        glxinfo | less
            #lots of opengl info
        glxgears
            #demo

##scientific

    ##netlib

        #lots of good scientific libs from there

        ##blas lapack
            #fortran: native
            #clang:   bindings

            #linear algebra. very widely standard.

    ##acts collection

        #<http://acts.nersc.gov/tools.html>

        #collection of good numerical libraries.

        #industry usage.

    ##opengl glut
        #native:   c++
        #bindings: python

        #adsf

        #3d rendering

        #de facto open source standard.

    ##opencv

        #langs: c++(native), python

        #computer vision

    ##gsl
        #c
        #c++

        #tons of scientific functions

    ##freefem

        #2d and 3d fem

        #TODO

    ##r

        #statistics

    ##it++

        #signal processing

    ##ode

        #rigid body physics engine

    ##plplot
        #c
        #cross platform

        #graph plotting

        #quite good at first sight

##misc

    ##shutdown reboot

        sudo shutdown -P now
            #brings down the system and powers off afterwards
            #`usual` shutdown
            #sends TODO signal to running processes and waits for their termination TODO?

        sudo reboot now
            #usual restart computer

    ##setleds

        #set/get capslock, numlock and scrolllock led state

        #only works from tty (ctrl+alt+F[1-6] on ubuntu)

            setleds

    ##gtk themes

        #it is best to install them from ppas
        #since at every update of gtk version themes break =)

        #to change themes with a gui (recommended) use: <#gnome tweak tools>

        ##manual theme management

            #to install for a single user, place themes folders under `~/.themes` and they will become available

        ##webupd8team/themes ppa

            #they have a many themes there!

                sudo add-apt-repository -y ppa:webupd8team/themes
                sudo aptitude update

            #my favorourite theme:

                sudo aptitude install -y gnomishdark-theme