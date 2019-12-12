# Building singularity packages on laptop

Obviously, first install singularity :)

In Macs, singularity needs to run in a Linux Virtual machine, thus
install VirtualBox, Vagrant, and run `vagrant up` with the
`Vagrantfile` from this repo, for example.

Check also
<https://github.com/jlento/atm-doc/tree/master/Metview/5.7.2.1> for
more details.


## Developing a container interactively

Take some base `*.def` file, create "sandbox" container, and shell into it:

```
sudo singularity build --sandbox /tmp/mycontainer mycontainer.def
sudo singularity shell -H $HOME --writable /tmp/mycontainer
```

Opening X windows needs `~/.Xauthority`, thus `-H $HOME` option.

Play in the container as usual, install packages with
`apt/yum/zypper`, test your programs, etc. Add the stuff that you wish
to keep into your `mycontainer.def`, and then build the final
container from the updated `mycontainer.def`.

