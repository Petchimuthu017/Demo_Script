*&---------------------------------------------------------------------*
*& Report Z_DEMO_SCRIPT_PROGRAM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_DEMO_SCRIPT_PROGRAM.

INCLUDE Z_DEMO_SCRIPT_PROGRAM_TOP.
INCLUDE Z_DEMO_SCRIPT_PROGRAM_C01.

INITIALIZATION.
CREATE OBJECT go_inv.

START-OF-SELECTION.
go_inv->execute( ).
