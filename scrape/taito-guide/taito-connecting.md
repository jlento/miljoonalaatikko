# 1.3 Connecting to Taito

To connect Taito, use terminal programs like ***ssh*** (linux, MacOSX)
or **PuTTY** (Windows), which provide secure connection to the server.
If you are not able to use a suitable terminal program in your local
computer you can use the *SSH console tool* in [*Scientist's User
Interface*].  
For example, when using the ssh command the connection can be opened in
the following way:

    ssh taito.csc.fi -l username

If you wish to use applications that use graphics or you want to suspend
you session after the day, we recommend that you use the [*NoMachine
Remote Desktop connection*] instead of direct terminal connections.

The Taito supercluster has two *login nodes* ( taito-login3.csc.fi and
taito-login4.csc.fi). When you open a new terminal connection using the
server name *taito.csc.fi* you will end up to one of these login nodes.
You can also open the connection directly to two of the login nodes (
taito-login3.csc.fi and taito-login4.csc.fi) if needed:

    ssh taito-login4.csc.fi -l username

Note that **login nodes are not intended for heavy computing** but for
submitting and managing batch jobs. If you wish to do interactive
computing, instead of submitting batch jobs, you can open connection to
*taito-shell* ( [see chapter 8].)

    ssh taito-shell.csc.fi -l username

More details about connecting to the computing severs of CSC can be
found from the [CSC Computing Environment User Guide chapter 1.3].

 

  [*Scientist's User Interface*]: http://sui.csc.fi
  [*NoMachine Remote Desktop connection*]: https://research.csc.fi/csc-guide-connecting-the-servers-of-csc#1.3.3
  [see chapter 8]: https://research.csc.fi/taito-shell-user-guide
  [CSC Computing Environment User Guide chapter 1.3]: https://research.csc.fi/csc-guide-connecting-the-servers-of-csc
