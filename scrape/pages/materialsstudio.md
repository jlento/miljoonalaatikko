## MaterialsStudio

### Description

Materials Studio is a software environment for molecular modeling. It includes several modules (Check this [page](http://accelrys.com/products/materials-studio/)). CSC has a license to use any of them but their simultanous use is limited by the floating token system. Since 2016 CSC has had a site license that provides unlimited access to the Materials Studio for researchers in Finnish universities. Also read the end user agreement from Biovia page: [http://www.3dsbiovia.com/about/legal/user-agreements.html](http://www.3dsbiovia.com/about/legal/user-agreements.html)

Materials Studio can be used as a versatile visualizer, molecule, crystal, surface or amorphous system builder, input file generator (front end) for a number of modeling applications, and for the post processing of the results, and naturally to carry out the simulations themselves.

The software has client and server parts. The client runs only on a Windows PC (see below) and has the modeling interface (or environment). The server side runs the actual simulations and the most of the individual modules can be installed also on Linux or Unix platforms (see below). The Windows server is installed at the same time as the Windows client. The jobs are submitted via a Server Gateway which comes with the package.

The installation packages and the instructions to configure licensing are available for download for academic customers, see below. Materials Studio Server components have also been installed on taito.csc.fi. At present their use is possible via the standalone mode, see below.

* * *

### Available

##### Version on CSC's Servers

Taito: 7.0 SP2, 8.0SP1, 17.2 (2017R2) (default)

* * *

##### Versions for Workstations

7.0 SP2, 8.0SP1, 17.2

* * *

### Usage

### License

Since 2016 CSC has had a site license that provides unlimited access to the Materials Studio for researchers in Finnish universities. Also read the end user agreement from Accelrys' page: [http://accelrys.com/company/legal/user-agreements.html](http://accelrys.com/company/legal/user-agreements.html).

**Local use**

The only way to use Materials Studio Modeling Environment is to install it to your local Windows PC. You can [download the software](https://sui.csc.fi) from Scientist's interface (double click Downloads | Software | Accelrys | Materials Studio). The individual modeling packages (e.g. CASTEP) can be run also on a Linux workstation. MS has an option to write out input files for the modeling packages, which can then be run separately on other machines.

**Standalone use**

It is possible to install the server applications also locally on a linux or unix machine. In this case you can submit and monitor jobs directly from the MS Modeling (client) program running in your local Windows computer. Alternatively, it is possible to save the input files on the client computer, manually copy them on the server machine and run them using the standalone versions of the server components.

**Running in Taito**

The following modules (servers) can be run in parallel: Forcite, Mesocite, CASTEP, DMol3, DFTB+, GULP, MesoDyn, and ONETEP. This link explains how to run standalone jobs in [Taito](/-/how-to-run-standalone-materials-studio-jobs-in-taito).

**Manuals**

The primary manual is the built-in help of the MS package. We recommend to go through the tutorials for each module (and the modeling environment) to get started.

* * *

### Discipline

Chemistry  

* * *

### References

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

[Accelrys Home Page](http://www.accelrys.com/)

[Detailed info about Materials Studio](http://accelrys.com/products/materials-studio/)

[Webinar presentations and case studies with Materials Studio](http://accelrys.com/events/webinars/materials-studio-50/index.html)

* * *