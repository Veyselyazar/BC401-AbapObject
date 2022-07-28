class ZCX_00_BC401 definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  constants ZCX_00_BC401 type SOTR_CONC value '00505604273F1EECBADEAF7C77DD5F34' ##NO_TEXT.
  constants HOECHSTWERT_UEBERSCHRITTEN type SOTR_CONC value '00505604273F1EDCBADF0726AA04C043' ##NO_TEXT.
  constants MINIMALWERT_UNTERSCHRITTEN type SOTR_CONC value '00505604273F1EDCBADF0B1F48D3C04E' ##NO_TEXT.
  data WERT1 type INT4 .
  data WERT2 type INT4 .

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !WERT1 type INT4 optional
      !WERT2 type INT4 optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_00_BC401 IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
.
 IF textid IS INITIAL.
   me->textid = ZCX_00_BC401 .
 ENDIF.
me->WERT1 = WERT1 .
me->WERT2 = WERT2 .
  endmethod.
ENDCLASS.
