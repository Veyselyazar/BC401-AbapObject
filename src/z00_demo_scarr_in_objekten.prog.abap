*&---------------------------------------------------------------------*
*& Report Z00_DEMO_SCARR_IN_OBJEKTEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_demo_scarr_in_objekten.
CLASS lcl_scarr DEFINITION.
  PUBLIC SECTION.
    METHODS set_scarr IMPORTING is_scarr TYPE scarr.
    METHODS display_fg.
  PRIVATE SECTION.
    DATA ms_scarr TYPE scarr.
ENDCLASS.
CLASS lcl_scarr  IMPLEMENTATION.
  METHOD set_scarr.
    ms_scarr = is_scarr.
  ENDMETHOD.
  METHOD display_fg.
    WRITE: / ms_scarr-carrid,
             ms_scarr-carrname,
             ms_scarr-currcode,
             ms_scarr-url(30).
    ULINE.
  ENDMETHOD.
ENDCLASS.
* Hauptprogramm
DATA gs_scarr TYPE scarr.
DATA go_scarr TYPE REF TO lcl_scarr.
DATA gt_scarr TYPE TABLE OF REF TO lcl_scarr.

START-OF-SELECTION.
  SELECT * FROM scarr INTO gs_scarr
    WHERE currcode = 'EUR'.
    CREATE OBJECT go_scarr.
    INSERT go_scarr INTO TABLE gt_scarr.
    go_scarr->set_scarr( is_scarr = gs_scarr  ).
  ENDSELECT.

  LOOP AT gt_scarr INTO go_scarr.
    go_scarr->display_fg( ).
  ENDLOOP.
