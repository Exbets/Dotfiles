#    _               _              
#   | |__   __ _ ___| |__  _ __ ___ 
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__ 
# (_)_.__/ \__,_|___/_| |_|_|  \___|
# 
# -----------------------------------------------------
# Load modular configarion
# -----------------------------------------------------

for f in ~/.config/bashrc/*; do 
    if [ ! -d $f ] ;then
        c=`echo $f | sed -e "s=.config/bashrc=.config/bashrc/custom="`
        [[ -f $c ]] && source $c || source $f
    fi
done

# -----------------------------------------------------
# Load single customization file (if exists)
# -----------------------------------------------------

if [ -f ~/.bashrc_custom ] ;then
    source ~/.bashrc_custom
fi
#export PATH=/home/dom/.local/bin:/usr/lib/ccache/bin/:/usr/lib/ccache/bin/:/usr/local/sbin:/usr/local/bin:/usr/bin:/home/dom/.local/share/flatpak/exports/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl