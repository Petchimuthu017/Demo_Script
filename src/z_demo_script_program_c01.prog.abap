*&---------------------------------------------------------------------*
*&  Include           Z_DEMO_SCRIPT_PROGRAM_C01
*&---------------------------------------------------------------------*

CLASS lcl_inv DEFINITION.
  PUBLIC SECTION.
  DATA: ls_vbrk TYPE vbrk,
        ls_vbrp TYPE vbrp,
        lt_vbrp TYPE STANDARD TABLE OF vbrp.
  METHODS: constructor,
           fetch_invoice,
           call_scipt,
           execute.
ENDCLASS.
CLASS lcl_inv IMPLEMENTATION.
  METHOD constructor.
    REFRESH: lt_vbrp.
    CLEAR: ls_vbrk, ls_vbrp.
  ENDMETHOD.
  METHOD fetch_invoice.
    SELECT SINGLE *
      FROM vbrk
      INTO ls_vbrk
     WHERE vbeln EQ po_inv.
    IF sy-subrc IS NOT INITIAL.
      MESSAGE 'No invoice found' TYPE 'E'.
    ENDIF.
    SELECT *
      FROM vbrp
      INTO TABLE lt_vbrp
     WHERE vbeln EQ po_inv.
    IF sy-subrc IS INITIAL.
      SORT lt_vbrp BY vbeln posnr.
    ENDIF.
  ENDMETHOD.
  METHOD call_scipt.
    CALL FUNCTION 'OPEN_FORM'
      EXPORTING
*       APPLICATION                       = 'TX'
*       ARCHIVE_INDEX                     =
*       ARCHIVE_PARAMS                    =
*       DEVICE                            = 'PRINTER'
*       DIALOG                            = 'X'
        FORM                              = 'Z_DEMOGIT_SCRIPT'
*       LANGUAGE                          = SY-LANGU
*       OPTIONS                           =
*       MAIL_SENDER                       =
*       MAIL_RECIPIENT                    =
*       MAIL_APPL_OBJECT                  =
*       RAW_DATA_INTERFACE                = '*'
*       SPONUMIV                          =
*     IMPORTING
*       LANGUAGE                          =
*       NEW_ARCHIVE_PARAMS                =
*       RESULT                            =
     EXCEPTIONS
       CANCELED                          = 1
       DEVICE                            = 2
       FORM                              = 3
       OPTIONS                           = 4
       UNCLOSED                          = 5
       MAIL_OPTIONS                      = 6
       ARCHIVE_ERROR                     = 7
       INVALID_FAX_NUMBER                = 8
       MORE_PARAMS_NEEDED_IN_BATCH       = 9
       SPOOL_ERROR                       = 10
       CODEPAGE                          = 11
       OTHERS                            = 12
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
    gs_vbrk = ls_vbrk.
    CALL FUNCTION 'WRITE_FORM'
       EXPORTING
*         ELEMENT                        = ' '
*         FUNCTION                       = 'SET'
*         TYPE                           = 'BODY'
         WINDOW                         = 'TITLE'
*       IMPORTING
*         PENDING_LINES                  =
       EXCEPTIONS
         ELEMENT                        = 1
         FUNCTION                       = 2
         TYPE                           = 3
         UNOPENED                       = 4
         UNSTARTED                      = 5
         WINDOW                         = 6
         BAD_PAGEFORMAT_FOR_PRINT       = 7
         SPOOL_ERROR                    = 8
         CODEPAGE                       = 9
         OTHERS                         = 10
                .
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
    CALL FUNCTION 'WRITE_FORM'
       EXPORTING
         ELEMENT                        = 'ITEM_HEADER'
*         FUNCTION                       = 'SET'
*         TYPE                           = 'BODY'
         WINDOW                         = 'MAIN'
*       IMPORTING
*         PENDING_LINES                  =
       EXCEPTIONS
         ELEMENT                        = 1
         FUNCTION                       = 2
         TYPE                           = 3
         UNOPENED                       = 4
         UNSTARTED                      = 5
         WINDOW                         = 6
         BAD_PAGEFORMAT_FOR_PRINT       = 7
         SPOOL_ERROR                    = 8
         CODEPAGE                       = 9
         OTHERS                         = 10
                .
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
    LOOP AT lt_vbrp ASSIGNING FIELD-SYMBOL(<fs_vbrp>).
      gs_vbrp = <fs_vbrp>.
      CALL FUNCTION 'WRITE_FORM'
       EXPORTING
         ELEMENT                        = 'ITEM_VALUE'
*         FUNCTION                       = 'SET'
*         TYPE                           = 'BODY'
         WINDOW                         = 'MAIN'
*       IMPORTING
*         PENDING_LINES                  =
       EXCEPTIONS
         ELEMENT                        = 1
         FUNCTION                       = 2
         TYPE                           = 3
         UNOPENED                       = 4
         UNSTARTED                      = 5
         WINDOW                         = 6
         BAD_PAGEFORMAT_FOR_PRINT       = 7
         SPOOL_ERROR                    = 8
         CODEPAGE                       = 9
         OTHERS                         = 10
                .
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.
      CLEAR: gs_vbrp.
    ENDLOOP.
    UNASSIGN: <fs_vbrp>.
    CALL FUNCTION 'CLOSE_FORM'
*     IMPORTING
*       RESULT                         =
*       RDI_RESULT                     =
*     TABLES
*       OTFDATA                        =
     EXCEPTIONS
       UNOPENED                       = 1
       BAD_PAGEFORMAT_FOR_PRINT       = 2
       SEND_ERROR                     = 3
       SPOOL_ERROR                    = 4
       CODEPAGE                       = 5
       OTHERS                         = 6
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDMETHOD.
  METHOD execute.
    me->fetch_invoice( ).
    me->call_scipt( ).
  ENDMETHOD.
ENDCLASS.
