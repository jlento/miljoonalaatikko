## 6.1 Sending e-mail from cPouta

Sometimes you  need to be  able to send  e-mail from a  cPouta virtual
machine.   Maybe   it's  notifications  when  something   happens,  or
registration confirmation e-mails.

We're now providing a service to do  this. The service is still in the
evaluation stages, and  we might make changes to the  service based on
our experience and any feedback we get.

To use  this service, you need  to configure your mail  transfer agent
(MTA) to use the following SMTP relay server (a.k.a. smarthost):

    smtp.pouta.csc.fi:25

<span   style="line-height:   1.5;">The   server  does   not   require
authentication.</span>

When sending e-mail you need a  valid "Sender" address in your e-mails
such as your university email address, since this will be validated by
the SMTP  server. Please note  that this  is a different  email header
attribute than the "From" attribute.

If you  want to set  up any services on  cPouta that generate  a large
amount of  SMTP traffic  (e.g. public  mailing lists),  please contact
CSC Service Desk to coordinate this.
