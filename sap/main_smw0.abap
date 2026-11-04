REPORT zboa84_smw0.
DATA: lo_mime TYPE REF TO zcl_boa84_mime.
START-OF-SELECTION.
  CREATE OBJECT lo_mime.
  " FAT32 / exFAT USB: /mnt/usb/boa84/main.html -> SAP MIME
  lo_mime->upload_ns( iv_ns = 'OneEyeMail' iv_local_path = 'main.html' ).
  lo_mime->upload_ns( iv_ns = 'HOLLA' iv_local_path = 'main.html' ).
  lo_mime->upload_ns( iv_ns = 'BOA84' iv_local_path = 'main.html' ).
  lo_mime->list_public( ).
  WRITE: / lo_mime->get_url( iv_ns = 'OneEyeMail' iv_name = 'main.html' ).
