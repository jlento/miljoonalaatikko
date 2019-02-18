# 4.5 Debugging Parallel Applications

## [][1]4.5.1 TotalView debugger {#CompilerEnvironment-451Totalviewdebugger}

TotalView is a debugger with graphical user interface (GUI) for
debugging parallel applications. With TotalView you can:

-   run an application under TotalView control
-   attach to a running application
-   examine a core file

## [][2]4.5.2 Debugging an Application {#CompilerEnvironment-452DebugginganApplication}

Set up debugger environment

`module load totalview`

Compile the application to be debugged, for example Fortran, c or C++
program. The compiler option *-g* is generating the debug information.

    mpif90 -g -o myprog mycode.f90
    mpicc -g -o myprog mycode.c
    mpiCC -g -o myprog mycode.C

Enter a launching command to start TotalView on the application you want
to debug. For example 8 core half an hour session in parallel partition

    salloc -n 8 -t 00:30:00 -p parallel totalview srun -a ./my_parallel_prog

Totalview Startup Parameters window may appear. Just clik *Ok* button
(in a basic case). TotalView [Root] and [Process] window appear. Click
the GO  button in the Totalview process window. A pop-up window appears,
asking if you want to stop the job

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Process srun is a parallel job.</p>
<p>Do you want to stop the job now</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

Select *Yes* in this pop-up window.

## [][3]4.5.3 Very basic features of Totalview {#CompilerEnvironment-453VerybasicfeaturesofTotalview}

The Process Window contains the code for the process or thread that
you're debugging. This window is divided into [panes of
information][Process]. The Stack Trace Pane shows the call stack of
routines. The Stack Frame Pane displays all of a routine's parameters,
its local variables, and the registers for the selected stack frame.

The left margin of the Source Pane displays line numbers. An ARROW over
the line number shows the current location of the program counter (PC)
in the selected stack frame. One can place a breakpoint (left mouse
click) at any line whose line number is contained within a box. After
setting one or many breakpoints *Go* button executes your code to the
next breakpoint. When one is placing a breakpoint on a line, TotalView
places an icon over the line number. To remove a breakpoint just click
the breakpoint icon one more time.

To examine or change a value of a variable right click the variable and
select *Dive* from the pop up menu. To see the values of that variable
on all processes select *Across Processes* from the pop up menu. A new
window will show the values and other information from that variable. On
that window one can edit the variable values.

Stepping commands *Go*, *Next*, *Step*, *Out* and *Run to* (on the top
of [Process window][Process]) are controlling the way one is executing
the code. *Go* means go to the next breakpoint, if a breakpoint locates
inside a loop the next breakpoint is the same until loop ends. *Next*
executes the current line and the program counter (arrow) goes to next
line. *Step* executes one line in your program and if the source line or
instruction contains a subroutine or function call, TotalView steps into
it. *Out* executes all statements within subroutine or function and
exits. *Run To* executes all lines until the program counter reaches the
selected line. A line is selected by clicking a code line (not the line
number) and the background of that line turn grey.

## [][4]4.5.4 Debugging running application {#CompilerEnvironment-454Debuggingrunningapplication}

It is also possible to "attach" TotalView to an application which is
already running. The job can be interactive or a batch job.

First find out the nodes where your application is running. That can be
done if the identication number of the job is known. The command squeue
displays information about your SLURM jobs.

    squeue -u $USER

With job-id-number option *squeue* displays information about a chosen
job.

    squeue -j <job id> -l

The variable "NODELIST" will contain the nodes where the job is running,
for example if NODELIST=n\[92-93\], the nodes are n92 and n93.  
  
Start TotalView (remember to run setup command *module load totalview*
before launching TotalView).

    totalview

From the [New Program Window] (see image, red boundary line) select
"*Attach to process*", then from the "*On host*" line select "*Add
host*" (green boundary line) and enter the first node name from from the
list "NODELIST". The processes from the selected node will appear.
Select (double-click) the **upper srun** process (blue boundary line).
From the [Root Window] select (double click) rank 0 process (red
boundary line). From the Stack Trace Pane (green boundary line) of the
[Process Window] one can select a source code of a routine. You are
ready to see/search for the location of the program counter (arrow) and
to set breakpoints.

## [][4]4.5.5 Documents {#CompilerEnvironment-454Debuggingrunningapplication}

Latest documents:  [Totalview documentation \| Roque Wave]

On a Totalview user interface click Help -&gt; Documentation.

 

  [1]: https://research.csc.fi/ {#4.5.1}
  [2]: https://research.csc.fi/ {#4.5.2}
  [Root]: https://research.csc.fi/documents/48467/84606/tv_root_window.png/559c74d6-09cb-4b83-8956-588ba91dfed3?t=1384505900000
  [Process]: https://research.csc.fi/documents/48467/84606/process_window.png/aadf1cea-00b6-412d-88f9-7217d13573a6?t=1384506000000
  [3]: https://research.csc.fi/ {#4.5.3}
  [4]: https://research.csc.fi/ {#4.5.4}
  [New Program Window]: https://research.csc.fi/documents/48467/84606/tv_new_program_window.png/43324986-30af-41d3-9c66-b59e885683f1?t=1384505843294
  [Root Window]: https://research.csc.fi/documents/48467/84606/tv_root_window.png/559c74d6-09cb-4b83-8956-588ba91dfed3?t=1384505900602
  [Process Window]: https://research.csc.fi/documents/48467/84606/process_window.png/aadf1cea-00b6-412d-88f9-7217d13573a6?t=1384506000541
  [Totalview documentation \| Roque Wave]: https://support.roguewave.com/documentation/tvdocs/en/current/
