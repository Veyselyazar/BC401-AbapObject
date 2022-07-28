class ZCL_BC401 definition
  public
  final
  create public .

public section.

  types:
    TV_NAMEN type c LENGTH 17 .

  class-data GV_GESAMTSUMME type INT4 read-only .
  constants GC_PI type ZSALARY01 value '3.14' ##NO_TEXT.

  class-methods ADD
    importing
      !IV_ZAHL1 type INT4
      !IV_ZAHL2 type INT4
    exporting
      !EV_SUMME type INT4
    exceptions
      WRONG_IMPORT .
  class-methods GET_SUMME
    exporting
      !EV_GESAMTSUMME type INT4
      !ET_SUMMEN type Z00_TT_SUMMEN
      !EV_MIN type INT4
      !EV_MAX type INT4
      !EV_AVG type INT4 .
  methods MULTIPLIZIERE
    importing
      !IV_ZAHL1 type INT4
      !IV_ZAHL2 type INT4 .
  methods SET_MITARBEIER
    importing
      !IR_MITARBEITER type ref to ZCL_MITA_00 .
  methods GET_TABLE
    importing
      value(IT_TABLE) type SPFLI_TAB .
protected section.

  data GV_FUER_KLASS_UND_UNTERKLASSE type S_CARR_ID .
private section.

  class-data GT_SUMMEN type Z00_TT_SUMMEN .
  class-data GS_SUMMEN type Z00_SUMMEN .
  data MV_PRODUKT type INT4 .
  data GV_NAME type TV_NAMEN .
  data R_ALV type ref to CL_GUI_ALV_GRID .
  data R_MITARBEITER type ref to ZCL_MITA_00 .
ENDCLASS.



CLASS ZCL_BC401 IMPLEMENTATION.


  METHOD add.
    IF iv_zahl1 NE 0 AND iv_zahl2 IS NOT INITIAL.
      ev_summe = iv_zahl1 + iv_zahl2.
      gv_gesamtsumme = gv_gesamtsumme + ev_summe.
      gs_summen-zahl1 = iv_zahl1.
      gs_summen-zahl2 = iv_zahl2.
      gs_summen-summe = ev_summe.
      INSERT gs_summen INTO TABLE gt_summen.
    ELSE.
      RAISE wrong_import.
    ENDIF.
  ENDMETHOD.


  METHOD get_summe.
    DATA ls_summen TYPE z00_summen.
    ev_gesamtsumme = gv_gesamtsumme.
    et_summen = gt_summen.
    IF gt_summen IS NOT INITIAL.
      READ TABLE gt_summen INTO ls_summen INDEX 1.
      ev_min = ls_summen-summe.
      READ TABLE gt_summen INTO ls_summen INDEX lines( gt_summen ).
      ev_max = ls_summen-summe.
      ev_avg =  gv_gesamtsumme / ( lines( gt_summen ) ).
    ENDIF.
  ENDMETHOD.


  method GET_TABLE.
    loop at it_table into data(ls_table).

    endloop.

    read TABLE it_table into ls_table INDEX 1.
  endmethod.


  method MULTIPLIZIERE.
    mv_produkt = iv_zahl1 * iv_zahl2.
    add 657 to gv_gesamtsumme.
  endmethod.


  method SET_MITARBEIER.
    r_mitarbeiter = ir_mitarbeiter.
  endmethod.
ENDCLASS.
