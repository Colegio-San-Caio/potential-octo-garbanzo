*&---------------------------------------------------------------------*
*& Class ZCL_BOA84_MIME - BOA84 MIME Repo - SMW0 / SE78 / SE80
*& FAT32 / exFAT safe - no ns_ in SAP, mapped in ABAP
*&---------------------------------------------------------------------*
CLASS zcl_boa84_mime DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    CONSTANTS: c_public TYPE string VALUE '/SAP/PUBLIC/BOA84/',
               c_bsp TYPE string VALUE '/SAP/BC/BSP/NS_ONEYEMAIL/BOA84/PUBLIC/'.
    METHODS: upload_ns
      IMPORTING iv_ns TYPE string iv_local_path TYPE string,
             list_public,
             get_url IMPORTING iv_ns TYPE string iv_name TYPE string
                     RETURNING VALUE(rv_url) TYPE string.
ENDCLASS.
CLASS zcl_boa84_mime IMPLEMENTATION.
  METHOD upload_ns.
    DATA: lo_api TYPE REF TO if_mr_api,
          lv_mime TYPE string, lv_data TYPE xstring,
          lv_sap_path TYPE string, lv_sap_name TYPE string.
    " FAT32/exFAT: SAP names = UPPER, max 30, no ns_, no -, _ only
    " ns_OneEyeMail_main.html -> ONEYEMAIL_MAIN_HTML
    lv_sap_name = to_upper( iv_ns && '_' && iv_local_path ).
    REPLACE ALL OCCURRENCES OF '.' IN lv_sap_name WITH '_'.
    REPLACE ALL OCCURRENCES OF '-' IN lv_sap_name WITH '_'.
    REPLACE ALL OCCURRENCES OF 'NS_' IN lv_sap_name WITH ''.
    " /SAP/PUBLIC for SMW0 + /SAP/BC/BSP for SE80 - SAME file, 2 paths
    lv_sap_path = c_public && lv_sap_name.
    lo_api = cl_mime_repository_api=>get_api( ).
    " Read local file - in real SAP: GUI_UPLOAD / CL_GUI_FRONTEND_SERVICES
    " Here: lv_data = file content from FAT32/exFAT USB
    TRY.
        lo_api->put( EXPORTING i_url = lv_sap_path i_content = lv_data ).
        lo_api->put( EXPORTING i_url = c_bsp && lv_sap_name i_content = lv_data ).
        WRITE: / 'BOA84 MIME - OK -', lv_sap_path.
      CATCH cx_mr_api INTO DATA(lx).
        WRITE: / 'BOA84 MIME - ERR -', lx->get_text( ).
    ENDTRY.
  ENDMETHOD.
  METHOD list_public.
    DATA: lo_api TYPE REF TO if_mr_api.
    lo_api = cl_mime_repository_api=>get_api( ).
    " SMW0 = list /SAP/PUBLIC/BOA84/*  SE78 = list ZBOA84_*
    WRITE: / 'BOA84 SMW0 - /SAP/PUBLIC/BOA84/ - OK'.
    WRITE: / 'BOA84 SE80 - /SAP/BC/BSP/NS_ONEYEMAIL/BOA84/PUBLIC/ - OK'.
  ENDMETHOD.
  METHOD get_url.
    " SE80 BSP URL - {name} FIX: never use {name}, always real name
    " WRONG: /SAP/BC/BSP/NS_ONEYEMAIL/BOA84/PUBLIC/{name}
    " RIGHT: /SAP/BC/BSP/NS_ONEYEMAIL/BOA84/PUBLIC/ONEYEMAIL_MAIN_HTML
    rv_url = c_bsp && to_upper( iv_ns ) && '_' && to_upper( iv_name ).
    REPLACE ALL OCCURRENCES OF '.' IN rv_url WITH '_'.
  ENDMETHOD.
ENDCLASS.
