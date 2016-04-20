/* ****************************************************************************
**									     **
**	Script Name:  script1.sql					     **
**	Purpose:  Create two new user accounts (iteacher, idev)	  	     **
**									     **
***************************************************************************  */

CREATE USER iteach IDENTIFIED BY password;

GRANT connect, resource, dba TO iteach;

CREATE USER idev IDENTIFIED BY password;

GRANT connect, resource, create view, create public synonym, create synonym TO idev;


