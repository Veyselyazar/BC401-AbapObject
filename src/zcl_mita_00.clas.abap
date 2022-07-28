class ZCL_MITA_00 definition
  public
  create public .

public section.

  interfaces ZIF_DRUCKEN .

  events VORNAME_ERFASST .

  methods CONSTRUCTOR
    importing
      !IV_VORNAME type STRING
      !IV_NACHNAME type STRING
    raising
      ZCX_00_BC401_NK .
  class-methods SET_FIRMENNAME
    importing
      !IV_FIRMENNAME type STRING .
  methods SET_VORNAME
    importing
      !IV_VORNAME type STRING .
  methods SET_NACHNAME
    importing
      !IV_NACHNAME type STRING .
  methods DISPLAY_MITA_DATEN .
protected section.

  data MV_VORNAME type STRING .
  data MV_NACHNAME type STRING .
  data MV_TELEFONNUMMER type STRING .
private section.

  class-data GV_FIRMENNAME type STRING .

  methods DISPLAY_NACHNAME .
ENDCLASS.



CLASS ZCL_MITA_00 IMPLEMENTATION.


  METHOD constructor.
    IF iv_vorname IS INITIAL OR iv_nachname IS INITIAL.
      RAISE EXCEPTION TYPE zcx_00_bc401_nk
        EXPORTING
          textid = zcx_00_bc401_nk=>mita_intitial.
     ENDIF.
    mv_vorname = iv_vorname.
    mv_nachname = iv_nachname.
  ENDMETHOD.


  METHOD display_mita_daten.
    WRITE: / 'Vorname', mv_vorname.
    CALL METHOD display_nachname.
    ULINE.
  ENDMETHOD.


  method DISPLAY_NACHNAME.
    write:    / 'Nachname', mv_nachname.
  endmethod.


  method SET_FIRMENNAME.
    gv_firmenname = iv_firmenname.
  endmethod.


  method SET_NACHNAME.
    mv_nachname = iv_nachname.
  endmethod.


  method SET_VORNAME.
    mv_vorname = iv_vorname.
    raise event vorname_erfasst.
  endmethod.


  method ZIF_DRUCKEN~DISPLAY_DRUCKDATUM.
    write: / 'Druckdatum', zif_drucken~druck_datum.
  endmethod.
ENDCLASS.
