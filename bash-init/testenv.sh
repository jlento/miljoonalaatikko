#!/bin/bash

# Recreating "user space" bash login initialization scripts for testing in
# puhti.csc.fi.

envroot=$HOME/testenv

# In the order login shell sources them...
shell_init_files=(
    "/etc/profile"
    "/etc/profile.d/*.sh"
    "/etc/profile.d/sh.local"
    "/appl/profile/zz-csc-env.sh"
    "/appl/profile/ssh-keygen.sh"
    "/etc/skel/.bash_profile"
    "/etc/skel/.bashrc"
    "/etc/bashrc"
)

printf "%s\n" "" \
    "Copying bash login shell initialization scripts (not overwriting)" \
    "under $envroot."

mkdir -p $envroot/{etc/profile.d,appl/profile,etc/skel}
for f in "${shell_init_files[@]}"; do
    cp -n $f ${envroot}/$(dirname "$f")
done

printf "%s\n" "" \
    "Fixing paths in the local copies of the scripts."

sed -i -r "s|(\W)(/etc/profile.d)|\1${envroot}\2|g" $envroot/etc/profile
sed -i -r "s|(\W)(/appl/profile)|\1${envroot}\2|g" \
    $envroot/etc/profile.d/zz-csc-env.sh
sed -i -r "s|(\W)(/appl/profile)|\1${envroot}\2|g" $envroot/appl/profile/zz-csc-env.sh
sed -i -r "s|(\W)(~)(/.bashrc)|\1${envroot}/etc/skel\3|g" $envroot/etc/skel/.bash_profile
sed -i -r "s|(\W)(/etc/bashrc)|\1${envroot}\2|g" $envroot/etc/skel/.bashrc
sed -i -r "s|(\W)(/etc/profile.d)|\1${envroot}\2|g" $envroot/etc/bashrc


# Set before shell initialization scripts
# login: HOME, USER, SHELL, PATH, LOGNAME, MAIL
# pam: XDG_* , SELINUX_*
# sshd: DISPLAY, XTERM, LC_*, SSH_*
login_env=(
    "HOME=\"$HOME\""
    "USER=\"$USER\""
    "SHELL=\"$SHELL\""
    "PATH=\"/usr/local/bin:/usr/bin\""
    "LOGNAME=\"$LOGNAME\""
    "MAIL=\"$MAIL\""
    "XDG_SESSION_ID=\"$XDG_SESSION_ID\""
    "SELINUX_ROLE_REQUESTED=\"$SELINUX_ROLE_REQUESTED\""
    "TERM=\"$TERM\""
    "SSH_CLIENT=\"$SSH_CLIENT\""
    "SELINUX_USE_CURRENT_RANGE=\"$SELINUX_USE_CURRENT_RANGE\""
    "SSH_TTY=\"$SSH_TTY\""
    "SELINUX_LEVEL_REQUESTED=\"$SELINUX_LEVEL_REQUESTED\""
    "SSH_CONNECTION=\"$SSH_CONNECTION\""
    "DISPLAY=\"$DISPLAY\""
    "XDG_RUNTIME_DIR=\"$XDG_RUNTIME_DIR\""
)

printf "%s\n" "" "Test with:" \
    "" \
    "    tree -a $envroot" \
    "" \
    "    /usr/bin/env -i ${login_env[*]} bash --login --noprofile" \
    "        source $envroot/etc/profile" \
    "        source $envroot/etc/skel/.bash_profile"\
    "        bash --rcfile $envroot/etc/skel/.bashrc"\
    "        BASH_ENV=$envroot/etc/skel/.bashrc bash -c 'env'"
