class ZCL_MITA_00_FREI definition
  public
  inheriting from ZCL_MITA_00
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IV_VORNAME type STRING
      !IV_NACHNAME type STRING
      !IV_STUNDENSATZ type I
    raising
      ZCX_00_BC401_NK .
  methods SET_STUNDENNSATZ
    importing
      !IV_STUNDENSATZ type INT4 .

  methods DISPLAY_MITA_DATEN
    redefinition .
protected section.
private section.

  data MV_STUNDENSATZ type INT4 .
ENDCLASS.



CLASS ZCL_MITA_00_FREI IMPLEMENTATION.


  METHOD constructor.

    super->constructor( iv_vorname = iv_vorname
                        iv_nachname = iv_nachname ).
    TRY.
        mv_stundensatz = iv_stundensatz.

      CATCH zcx_00_bc401_nk INTO DATA(lo_error).

    ENDTRY.
  ENDMETHOD.


  method DISPLAY_MITA_DATEN.
*SUPER->DISPLAY_MITA_DATEN( ).
    write: 'Hier ist die Implementierung aus der Unterklasse',
    / mv_vorname, mv_nachname, 'Stundesatz:', mv_stundensatz.
  endmethod.


  method SET_STUNDENNSATZ.
    mv_stundensatz = iv_stundensatz.
  endmethod.
ENDCLASS.
