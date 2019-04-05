# 3.6 Orchestration with Heat

The  Pouta   cloud  services  provide  orchestration   services  using
OpenStack  Heat.   You can  access  this  feature  from the  web  user
interface's left  hand panel  or using the  OpenStack or  Heat command
line client.   Orchestration provides  you an easy  way to  create the
entire infrastructure based on a  reusable and human readable template
file. The template can describe many components of the infrastructure,
like the servers, volumes and floating IPs and in the same file it can
attach the volumes and IPs to  the specific instances. A  template can
also define multiple instances connected to specific networks, some of
which have  floating IPs and some  a volume attached and  the file can
also be used to modify the existing infrastructure.

### Orchestration via the web user interface

**Note:  You should  use "2016-10-14"  or older  as the  Heat template
version. Features in newer template versions may not be supported. You
can find a list of the different template versions [here].**

These instructions  will provide a simple  example on how to  set up a
stack via  the web user interface.  To create a Heat  stack, click the
"Stacks"  link under  the  Orchestration menu.  The  opened view  will
display all existing stacks and also provide the button "Launch Stack"
to launch a  new stack. In the window which  was opened after clicking
the   "Launch  Stack"   button,   you  can   start  configuring   your
stack. Selecting  a template  is mandatory and  the template  data can
also  be  provided  as  direct  input,  as  depicted  in  the  picture
below. Note that this picture contains  a valid, yet simple example of
a template, which will build two  instances and display the IP address
of the first instance.

![][1]

After choosing "Next"  the web user interface will ask  for stack name
and your  password. After  this you  can launch  the stack.  After the
stack  is built,  it can  be managed  from the  Orchestration's Stacks
view. The items which  were built as a part of the  stack can be found
from their corresponding  menus, for example in this  example case the
two instances can be seen and  managed in the instances menu. From the
stack's (Orchestration  -&gt; Stacks  -&gt; click the  stack) Overview
tab, you can  also see the output defined by  the "outputs" section in
the picture's example.  To delete all components created  by the stack
template, simply press "Delete Stack" in the Stacks page.

### Using orchestration with command line client

Heat  can be  operated with  the  OpenStack command  line client,  but
currently you can still use the deprecated Heat command line client as
well. To create a stack with command line, use the command:

    openstack stack create -t /path/to/my/stack.yml my-heat-stack

 

To  show details  of  the  newly created  stack  among other  existing
stacks, use commands:

    openstack stack list
    +--------------------------------------+---------------+-----------------+----------------------+--------------+
    | ID                                   | Stack Name    | Stack Status    | Creation Time        | Updated Time |
    +--------------------------------------+---------------+-----------------+----------------------+--------------+
    | 98077bd5-9d69-47c3-98db-b0e19a60b1fa | my-heat-stack | CREATE_COMPLETE | 2016-06-08T07:34:46Z | None         |
    +--------------------------------------+---------------+-----------------+----------------------+--------------+

 

### Heat guidelines and command references

You can find information about writing Heat templates [here][2]. <span
style="line-height:  1.5;">For more  information, visit  the OpenStack
</span>[Heat wiki]<span style="line-height: 1.5;">. For full reference
to the  OpenStack command  line client,  see the  </span>[command line
reference]<span  style="line-height: 1.5;"> and  for the  Heat command
line    client,    see    the   </span>[Heat    CLI    reference]<span
style="line-height: 1.5;">.</span>

To try out the example provided  here, modify at least the "key\_name"
in the template code:

    heat_template_version: 2015-10-15

    description: >
      Simple template to deploy
      a single instance in cPouta

    resources:
      instance0:
        type: OS::Nova::Server
        properties:
          image: Ubuntu-16.04
          flavor: standard.tiny
          key_name: my-key
      instance1:
        type: OS::Nova::Server
        properties:
          image: CentOS-7
          flavor: standard.small
          key_name: my-key
    outputs:
        server_networks:
          description: >
            Outputs the networks of the
            deployed server
          value: { get_attr: [instance0, networks] }

|                    | | | | |
|--------------------|-----|----------------|-----|----------------|
| [Previous chapter] |     | [One level up] |     | [Next chapter] |

 

 

 

 

  [here]: https://docs.openstack.org/heat/latest/template_guide/hot_spec.html#heat-template-version
  [1]: https://research.csc.fi/documents/48467/51198/stacks-view.png/876ae91b-ba1c-4782-a78b-abe698d84611?t=1474288845312
  [2]: http://docs.openstack.org/developer/heat/template_guide/
  [Heat wiki]: https://wiki.openstack.org/wiki/Heat
  [command line reference]: http://docs.openstack.org/cli-reference/openstack.html
  [Heat CLI reference]: https://docs.openstack.org/mitaka/cli-reference/heat.html
  [Previous chapter]: https://research.csc.fi/pouta-vm-lifecycle
  [One level up]: https://research.csc.fi/pouta-usage
  [Next chapter]: https://research.csc.fi/pouta-container-orchestration
