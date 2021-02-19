*&---------------------------------------------------------------------*
*&  Include           Z_DEMO_SCRIPT_PROGRAM_TOP
*&---------------------------------------------------------------------*

SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.
  PARAMETERS: po_inv TYPE vbrk-belnr.
SELECTION-SCREEN: END OF BLOCK b1.

CLASS lcl_inv DEFINITION DEFERRED.

DATA: go_inv TYPE REF TO lcl_inv,
      gs_vbrk TYPE vbrk,
      gs_vbrp TYPE vbrp.
