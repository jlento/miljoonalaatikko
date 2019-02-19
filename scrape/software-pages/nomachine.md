## NoMachine

### Description

The NoMachine Client and server enable a fast graphical work from CSC to
your local computer. This makes using GUIs fluent. The idea is to
connect to nxkajaani.csc.fi with the NoMachine client (free) installed
at your computer (available for Win, Mac, Linux). Then from
nxkajaani.csc.fi i.e. within Kajaani connect with ssh to the server
where you want do your science e.g. run RStudio or VMD. The speedup vs.
X11 (native or emulated) can be many fold, so you will experience
substantial improvement. Note that with NoMachine you don't need
X-emulators or X-term (in Linux).

![NoMachine server connections to Espoo and Kajaani]

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

nxkajaani.csc.fi: version 6 server

------------------------------------------------------------------------

##### Versions for Workstations

------------------------------------------------------------------------

### Usage

1.  You will need a user account at CSC (on the server where you run
    applications). If you don't have one, you can get it from [here].
2.  Download the latest NoMachine **client** (win, mac, linux) from the
    NoMachine site, see detailed instructions from the link below.
3.  Install and ***configure*** your NoMachine client. [Step-by-step
    instructions are in the CSC General user guide]
4.  Start the NoMachine client and log on to nxkajaani.csc.fi.
5.  Right click in the Desktop and choose the CSC server you want to use
    (opens an ssh terminal).
6.  Start your scientific application normally.
7.  When you're done, disconnect or terminate the connection from the
    Desktop top right corner (peel menu). Please don't suspend more than
    one session. The number of overall sessions, including suspended
    ones, is limited.

------------------------------------------------------------------------

### Discipline

Visualization  
Other  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

<https://www.nomachine.com/support>

------------------------------------------------------------------------

  [NoMachine server connections to Espoo and Kajaani]: https://research.csc.fi/documents/48467/51198/freenx-sketch.png/7a680da1-ef7a-4c00-9d60-a3fa673b1448?t=1379577395603
  [here]: http://www.csc.fi/english/customers/university/useraccounts
  [Step-by-step instructions are in the CSC General user guide]: https://research.csc.fi/csc-guide-connecting-the-servers-of-csc#1.3.3
