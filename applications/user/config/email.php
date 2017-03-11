<?php

/*
|--------------------------------------------------------------------------
| Email Config
|--------------------------------------------------------------------------
*/

/*
$config['protocol'] = 'smtp';
$config['smtp_host'] = 'localhost';
$config['smtp_user'] = 'no-reply@pediukdi.com';
$config['smtp_pass'] = 'no-reply2016';
$config['smtp_port'] = 25;
$config['mailtype'] = 'html';
*/

$config['protocol'] = 'sendmail';
$config['mailpath'] = '/usr/sbin/sendmail';
$config['charset'] = 'iso-8859-1';
$config['wordwrap'] = TRUE;
$config['mailtype'] = 'html';