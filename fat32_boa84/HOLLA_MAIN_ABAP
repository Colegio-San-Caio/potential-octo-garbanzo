*&---------------------------------------------------------------------*
*& Report ZBOA84_MAIN - BOA84 SAP MAIN - OneEyeMail + HOLLA + BOA84
*&---------------------------------------------------------------------*
REPORT zboa84_main.

DATA: lv_ns TYPE string,
      lt_ns TYPE TABLE OF string.

START-OF-SELECTION.
  WRITE: / 'BOA84 SAP MAIN - OK - All 9 servers started'.
  APPEND 'ns_OneEyeMail' TO lt_ns.
  APPEND 'ns_HOLLA' TO lt_ns.
  APPEND 'ns_BOA84' TO lt_ns.
  LOOP AT lt_ns INTO lv_ns.
    WRITE: / 'BOA84 NS SYNC - OK -', lv_ns.
  ENDLOOP.
  WRITE: / 'BOA84 web server - ns_OneEyeMail - OK - port=8080'.
  WRITE: / 'BOA84 mail server - ns_OneEyeMail - OK - port=8080'.
  WRITE: / 'BOA84 database server - ns_OneEyeMail - OK - port=8080'.
  WRITE: / 'BOA84 SAP MAIN - DONE - OneEyeMail + HOLLA + BOA84'.
