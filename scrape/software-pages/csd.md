## CSD

### Description

The **Cambridge Structural Database System** has two major components:

-   The Cambridge Structural *Database* ([CSD])
-    *Software* for  search, retrieval,  display and  analysis of  CSD
    contents: ConQuest,  VISTA, PreQuest, Superstar, Mercury  GOLD and
    CSD-CrossMiner.

The Cambridge  Structural Database  is a collection  of small-molecule
organic and organometallic crystal  structures determined by X-ray and
neutron diffraction techniques. The  present database consists of more
than 900 000  entries. Since 2015 CSC has obtained  a national license
which allows unlimited  installations for academic usage,  as well as,
access to WebCSD  from institutional IP address  range. Currently, the
following  universities have  access  to CSD:  Aalto, Helsinki,  Oulu,
Eastern-Finland,   Jyväskylä,   Turku,   Åbo   Akademi,   Lappeenranta
University of  Technology, Finnish  Defence Forces University.  If you
want your university added, fill  in the [License agreement] below and
contact Atte via CSC [Service Desk]

### License agreement

Using    the   CSD    components   requires    adhering   [to    these
conditions][License  agreement].  If  your university  is  not  listed
above, fill in  this document, sign, scan and email  to servicedesk at
CSC.

Software to access and analyse CSD entries:

-   [ConQuest] search and retrieval software
-   [Mercury] graphical display and visualisation of data
-   [PreQuest] In-house database creation tools
-    [IsoStar] A  Knowledge Base  of Intermolecular  Interactions (not
    available on Taito, install locally, or use from CCDC)
-   [Mogul] A Knowledge Base of Molecular Geometry
-     <span   id="yui_patched_v3_11_0_1_1437648841748_494">[SuperStar]
    Predicting   Protein-Ligand    interactions   using   experimental
    knowledge-base data</span>
-   [WebCSD] browser access to the CSD database
-    [SolidFormModule] knowledge-based  tools for  molecular materials
    design
-   [CrossMiner] interactive versatile pharmacophore query tool
-    [DASH] Solving  crystal structures  from powder  diffraction data
    interactively (only for Windows)

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

2019

[What's new in 2019]

------------------------------------------------------------------------

##### Versions for Workstations

2019

------------------------------------------------------------------------

### Usage

There are three ways to access the CSD System:

-   Using CSD System on Taito-shell
-   Local installation (Windows or Linux)
-   WebCSD (limited functionality), point  your browser in here: <span
    class="clickylink"><http://webcsd.ccdc.cam.ac.uk/></span>

The installation  media can be  downloaded from the CCDC  website, but
needs the site number and  confirmation code of your university. After
installation you need to activate  the product. To obtain the required
codes, contact either CSC Service  Desk or the local CSD administrator
at your  university. It is  also possible to batch  activate products,
ask for details.

Additionally the  WebCSD service  can be used  directly via  a browser
from the computers  within the university's IP range.  Access does not
need  further authentication.  If  there are  problems, contact  CSC's
servicedesk at csc.fi. WebCSD can  also be accessed with an individual
username password pair  from any location in  Finland. Each university
can define six  such users. Instructions on creating  the username and
password can be found [here].

CSC  is a  Nationally  Affiliated  Center for  the  CSD System.  Those
university departments  who are  not yet  members and  want to  have a
local  installation   please  contact   Atte  Sillanpää   via  Service
Desk. Please note that the size  of the databases and programs is more
than 6 GB (upto 12 GB).

Note also that to use the programs listed above from CSC's taito-shell
an X-terminal  is needed. In linux  this is built-in, but  in windows,
you will need some extra tweaking. We suggest using the Remote desktop
service (NoMachine)  which is particularly  useful for CSD as  it will
make the interactive GUI usage fluent  also for Linux users. Read more
about [NoMachine  at CSC]. The  old solution  was to use  an X-windows
emulator, such as [Xming], but the Remote Desktop is simply better.

**Using CSD on Taito-shell:**

Cambridge Structural Database and programs related to it are available
both by the *module* command.

By typing the command

`module load ccdc`

you  have  access  to  programs ConQuest,  PreQuest,  IsoStar,  Vista,
Superstar, and Mercury.

For example, to access ConQuest, you need to type

`cq`

or to start Mercury, type

`mercury`

Alternatively,  you  can  just   login  to  nxkajaani.csc.fi  via  the
NoMachine remote desktop client, and choose Applications - Chemistry -
CSD from the menu which opens with the mouse right click.

------------------------------------------------------------------------

### Discipline

Biosciences  
Chemistry  
Visualization  

------------------------------------------------------------------------

### References

New software for searching the Cambridge Structural Database and
visualising crystal structures  
I. J. Bruno, J. C. Cole, P. R. Edgington, M. Kessler, C. F. Macrae, P.
McCabe,  J.  Pearson  and  R. Taylor,  *Acta  Crystallogr.*,  **B58**,
389-397, 2002

Program     specific     references     can     be     found     here:
<http://www.ccdc.cam.ac.uk/support/product_references/>

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------

  [CSD]: http://www.ccdc.cam.ac.uk/products/csd_system
  [License agreement]: https://research.csc.fi/documents/48467/73370/CCDC+License+Agreement+Template.pdf/bea49ea1-a6ee-4e7e-94d3-9b7ef8e3a361
  [Service Desk]: https://research.csc.fi/support
  [ConQuest]: http://www.ccdc.cam.ac.uk/Solutions/CSDSystem/Pages/ConQuest.aspx
  [Mercury]: http://www.ccdc.cam.ac.uk/Solutions/CSDSystem/Pages/Mercury.aspx
  [PreQuest]: http://www.ccdc.cam.ac.uk/Solutions/CSDSystem/Pages/PreQuest.aspx
  [IsoStar]: http://www.ccdc.cam.ac.uk/Solutions/CSDSystem/Pages/IsoStar.aspx
  [Mogul]: http://www.ccdc.cam.ac.uk/Solutions/CSDSystem/Pages/Mogul.aspx
  [SuperStar]: http://www.ccdc.cam.ac.uk/Solutions/LifeSciences/Pages/SuperStar.aspx
  [WebCSD]: http://www.ccdc.cam.ac.uk/Solutions/CSDSystem/Pages/WebCSD.aspx
  [SolidFormModule]: http://www.ccdc.cam.ac.uk/Solutions/CSDSolidFormSuite/Pages/SolidFormModule.aspx
  [CrossMiner]: https://www.ccdc.cam.ac.uk/solutions/csd-discovery/components/CSD-CrossMiner/
  [DASH]: http://www.ccdc.cam.ac.uk/Solutions/PowderDiffraction/Pages/DASH.aspx
  [What's new in 2019]: https://downloads.ccdc.cam.ac.uk/documentation/CSDS/2019/Whats_New.pdf
  [here]: https://research.csc.fi/documents/48467/73370/WebCSD-access-with-individual-password/390e1df8-fd12-479d-bb2a-0ceba6da9432
  [NoMachine at CSC]: https://research.csc.fi/-/nomachine
  [Xming]: http://sourceforge.net/projects/xming
