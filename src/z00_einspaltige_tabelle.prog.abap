*&---------------------------------------------------------------------*
*& Report Z00_EINSPALTIGE_TABELLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_einspaltige_tabelle.

DATA gt_namen TYPE TABLE OF string.
DATA gv_name TYPE string.


APPEND 'Werner' TO gt_namen.
APPEND 'Melanie' TO gt_namen.
APPEND 'Stefanie' TO gt_namen.
APPEND 'Markus' TO gt_namen.

READ TABLE gt_namen INTO gv_name
  WITH KEY table_line = 'Melanie'.

IF sy-subrc = 0.
  WRITE: sy-tabix, gv_name.
ENDIF.
