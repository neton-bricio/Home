# Configurações do Bash feitas pelo usuário pekman 


if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

PATH=$PATH:~/.Scripts 
#PATH=$PATH:~/.lib/pyroscope/bin/
# Instalacao das Funcoes ZZ (www.funcoeszz.net)
#export ZZOFF=""  # desligue funcoes indesejadas
#export ZZPATH="/home/pekman/funcoeszz/funcoeszz"  # script
#export ZZDIR="/home/pekman/funcoeszz/zz"
#source "$ZZPATH"


xhost +local:root > /dev/null 2>&1

complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export JAVA_FONTS=/usr/share/fonts/TTF
export EDITOR=/usr/bin/xfw
export BROWSER=/usr/bin/dillo


alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'
alias fixit='sudo rm -f /var/lib/pacman/db.lck && sudo pacman-mirrors -g && sudo pacman -Syyuu  && sudo pacman -Suu'
alias brc='vim ~/.bashrc'
alias c='clear'
alias x='exit'
alias np='nano PKGBUILD'
alias news='newsbeuter'
alias pod='podbeuter'
alias mt='bashmount'
alias mocx='mocp -x'
alias rt='rtorrent -o http_capath=/etc/ssl/certs'
alias yt='youtube-viewer'
alias we='weechat'
alias mpg='mpg123 --continue -E ~/.mpg_equal.txt --stereo --float --rva-album --rva-mix --control --title --fuzzy --long-tag *mp3'
alias mpgr='find . -iname "*.mp3" | mpg123 --continue -E ~/.mpg_equal.txt --stereo --float --rva-album --rva-mix --title --fuzzy --long-tag -Z --list -'
alias mps='mpg123 --stereo --float  --control -v -v -@'
alias ogg='ogg123 *.ogg'
alias oge='oggenc -q 9 *.flac'

##Commando Line Fooo
cmdfu() { curl "http://www.commandlinefu.com/commands/matching/$(echo "$@" \
    | sed 's/ /-/g')/$(echo -n $@ | base64)/plaintext" ; }

##Alias para navegaçao na arvore de arquivos
alias ds='cd ~/.Scripts'
alias dm='cd ~/Músicas/'
alias dmd='cd ~/Músicas/Dance'
alias dmf='cd ~/Músicas/Fabiana'
alias dmg='cd ~/Músicas/Grooveshark'
alias dmj='cd ~/Músicas/Jamendo'
alias dmp='cd ~/Músicas/Pop'
alias dmr='cd ~/Músicas/Rock'
alias dmr2='cd ~/Músicas/Românticas'
alias dms='cd ~/Músicas/Sertanejo'
alias dms2='cd ~/Músicas/Shows'
alias dms3='cd ~/Músicas/Synthpop'
alias dmy='cd ~/YTT/Music'

##Aliases do Git
alias gitp='git checkout master; git fetch upstream; git merge master; git push origin master'
alias gita='git add .'
alias gitc='git commit -m'
alias gite='git push origin master'

##Alias Systemd
alias sstatus='systemctl status'
alias sstart='sudo systemctl start'
alias sstop="sudo systemctl stop"
alias sreload='sudo systemctl reload'
alias senable='sudo systemctl enable'
alias sdisable='sudo systemctl disable'


# MPV Vídeo Player alias
alias mpvnova='mpv --no-video'
alias mpvshuf='mpvnova --shuffle --loop inf'
alias mpvp='mpvshuf --playlist'
playcurrentdir() {
mpvp <(find "$PWD" -type f -follow)
}
alias pcd='playcurrentdir'
playdir() {
if [[ $# == 0 ]]; then
echo "playdir requires one or more directories on input."
else
if [[ $(uname) == "Linux" ]]; then READLINK=readlink;
else READLINK=greadlink; fi
mpvshuf --playlist <(find "$@" -type f -follow -exec $READLINK -f {} \;)
unset READLINK
fi
}
alias pd='playdir'
alias mpvl='mpv --ytdl-format=18 --ontop'

# Play Music no terminal com mplayer
pvl() { youtube-dl -q --max-downloads 1 --no-playlist "$1" -o - | mplayer -vo null -;  }

# Bash Completion
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Colorized Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#----------------------------------------------------------
# Funtion for ip
#----------------------------------------------------------
ipif() { 
    if grep -P "(([1-9]\d{0,2})\.){3}(?2)" <<< "$1"; then
        curl ipinfo.io/"$1"
        else
            ipawk=($(host "$1" | awk '/address/ { print $NF  }'))
            curl ipinfo.io/${ipawk[1]}
            fi
            echo
        }

#----------------------------------------------------------
# Funtion Explain command
#----------------------------------------------------------        
explain () {
if [ "$#" -eq 0 ]; then
while read -p "Command: " cmd; do
curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
done
echo "Bye!"
elif [ "$#" -eq 1 ]; then
curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
else
echo "Usage"
echo "explain interactive mode."
echo "explain 'cmd -o | ...' one quoted command to explain it."
fi
}

#----------------------------------------------------------
# Funtion Enter List directory
#----------------------------------------------------------        
alias lcd=changeDirectory
  function changeDirectory {
    cd $1 ; ls -la
  }

# prompt
#PS1="┌─[\d][\u@\h:\w]\n└─> "
#PS1='[\u@\h \W]\$ '
#PS1='\[\e[1;30m\]» \[\e[0;33m\]\H@\u\[\e[1;30m\]╺─╸\[\e[1;30m\][\[\e[0m\]\W\[\e[1;30m\]]\[\e[1;34m\]\[\e[0m\]\[\e[m \] '
#PS1="\n\[\e[30;1m\]\[\016\]l\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]|☻_\[\e[30;1m\])-(\[\e[34;1m\]\@ #\d\[\e[30;1m\])->\[\e[30;1m\]\n\[\016\]m\[\017\]-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, #\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"
#PS1="\n\[\e[32;1m\](\[\e[37;1m\]\u\[\e[32;1m\])-(\[\e[37;1m\]jobs:\j\[\e[32;1m\])-(\[\e[37;1m\]\w\[\e[32;1m\])\n(\[\[\e[37;1m\]! \!\[\e[32;1m\])-> \[\e[0m\]"
#PS1='\[\e[1;32m\]\u@\H:\[\e[m\] \[\e[1;37m\]\w\[\e[m\]\n\[\e[1;33m\]hist:\! \[\e[0;33m\] \[\e[1;31m\]jobs:\j \$\[\e[m\] '
#PS1="[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"
#PS1="\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
#PS1="\n\[\033[35m\]\$(/bin/date)\n\[\033[32m\]\w\n\[\033[1;31m\]\u@\h: \[\033[1;34m\]\$(/usr/bin/tty | /bin/sed -e 's:/dev/::'): \[\033[1;36m\]\$(/bin/ls #-1 | /usr/bin/wc -l | /bin/sed 's: ::g') files \[\033[1;33m\]\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\033[0m\] -> \[\033[0m\]"
#PROMPT_COMMAND='PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u.\h: \`if [[ `pwd|wc -c|tr #-d " "` > 18 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"'
#PS1="\`if [ \$? = 0 ]; then echo \[\e[33m\]^_^\[\e[0m\]; else echo \[\e[31m\]O_O\[\e[0m\]; fi\`[\u@\h:\w]\\$ "
#PS1="\[\e[01;37m\][\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;33m\]\u\[\e[0m\]\[\e[01;31m\]@\[\e[0m\]\[\e[01;34m\]\h\[\e[0m\]\[\e[00;37m\] #\[\e[0m\]\[\e[01;37m\]]\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;36m\]-\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;37m\][\[\e[0m\]\[    \e[00;37m\] #\[\e[0m\]\[\e[01;32m\]\d\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;36m\]*\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;32m\]\A\[\e[0m\]\[\e[00;37m\] #\[\e[0m\]\[\e[01;37m\]]\[\e[0m\]\[\e[00;37m\]\n\[\e[0m\]\[\e[01;37m\][\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;33m\]\w\[\e[0m\]\[\e[00;37m\] #\[\e[0m\]\[\e[01;32m\]\\$\[\e[0m\]\[\e[01;37m\]]\[\e[0m\]\[\e[00;37m\] \[\e[0m\]"


## tópic https://bbs.archlinux.org/viewtopic.php?pid=1505273#p1505273
# Magic Prompt 1.0.0
function next_hue
{
    color=$((31 + (++color % 7)))   # set 31 to 30 for dark on light
    PS1="\[\e[1;30m\]» \ \[\e[1;${color}m\]»\H@\u\[\e[1;30m\]╺─╸\[\e[1;30m\][\[\e[0m\]\W\[\e[1;30m\]]\[\e[1;34m\]\[\e[0m\]\[\e[m \] $reset" # set 1 to 0 for dark on light
}

function random_hue
{
    color=$(($RANDOM % 7 + 31)) # set 31 to 30 for dark on light
    PS1="\[\e[1;30m\]» \[\e[1;${color}m\]\H@\u\[\e[1;30m\]╺─╸\[\e[1;30m\][\[\e[0m\]\W\[\e[1;30m\]]\[\e[1;34m\]\[\e[0m\]\[\e[m \] $reset" # set 1 to 0 for #dark on light
}
PROMPT_COMMAND="random_hue"

#next_hue() {
#    color=$(( 30 + (++color % 8) ))
#    echo -ne "\e[1;${color}m"    # change 1 to 0 for darker colors
#}
#PROMPT_COMMAND="next_hue"
#PS1="\$\[\e[0m\] "

BROWSER=/usr/bin/xdg-open
