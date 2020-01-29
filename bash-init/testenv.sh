#!/bin/bash

# Recreating "user space" bash login initialization scripts for testing in
# puhti.csc.fi

# In the order login shell sources them...
shell_init_files=(
    "/etc/profile $HOME/etc/"
    "/etc/profile.d/*.sh $HOME/etc/profile.d/"
    "/etc/profile.d/sh.local $HOME/etc/profile.d/"
    "/appl/profile/zz-csc-env.sh $HOME/appl/profile/"
    "/appl/profile/ssh-keygen.sh $HOME/appl/profile/"
    "/etc/skel/.bash_profile $HOME/home/"
    "/etc/skel/.bashrc $HOME/home/"
    "/etc/bashrc $HOME/etc/"
)

printf "%s\n" ""\
    "Copying bash login shell initialization scripts (not over writing):" \
    "" \
    "${shell_init_files[@]}"

mkdir -p $HOME/{etc/profile.d,appl/profile,home}
for args in "${shell_init_files[@]}"; do
    cp -n $args
done

printf "%s\n" ""\
    "Fixing paths in the local copies of the scripts."

sed -i -r "s|(\W)(/etc/profile.d)|\1${HOME}\2|g" $HOME/etc/profile
sed -i -r "s|(\W)(/appl/profile)|\1${HOME}\2|g" \
    $HOME/etc/profile.d/zz-csc-env.sh
sed -i -r "s|(\W)(/appl/profile)|\1${HOME}\2|g" $HOME/appl/profile/zz-csc-env.sh
sed -i -r "s|(\W~)(/.bashrc)|\1/home\2|g" $HOME/home/.bash_profile
sed -i -r "s|(\W)(/etc/bashrc)|\1${HOME}\2|g" $HOME/home/.bashrc
sed -i -r "s|(\W)(/etc/profile.d)|\1${HOME}\2|g" $HOME/etc/bashrc


# Set before(?) shell initialization scripts
# login: HOME, USER, SHELL, PATH, LOGNAME, MAIL
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
    "XDG_RUNTIME_DIR=\"$XDG_RUNTIME_DIR\""
    "DISPLAY=\"$DISPLAY\""
)

printf "%s\n" "" "Test with:" \
    "" \
    "    bash -i --rcfile $HOME/home/.bashrc"\
    "" \
    "    /usr/bin/env -i ${login_env[*]} bash --login --noprofile" \
    "        source $HOME/etc/profile" \
    "        source $HOME/home/.bash_profile"\
    "" \
    "    BASH_ENV=$HOME/home/.bashrc bash -c 'env'"
