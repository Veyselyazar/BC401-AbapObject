class ZCX_00_BC401_NK definition
  public
  inheriting from CX_DYNAMIC_CHECK
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  constants:
    begin of HOECHSTWERT_UEBERSCHRITTEN,
      msgid type symsgid value 'ZBC401',
      msgno type symsgno value '000',
      attr1 type scx_attrname value 'WERT1',
      attr2 type scx_attrname value 'WERT2',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HOECHSTWERT_UEBERSCHRITTEN .
  constants:
    begin of MINIMALWERT_UNTERSCHRITTEN,
      msgid type symsgid value 'ZBC401',
      msgno type symsgno value '001',
      attr1 type scx_attrname value 'WERT1',
      attr2 type scx_attrname value 'WERT2',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of MINIMALWERT_UNTERSCHRITTEN .
  constants:
    begin of AZUBI_INITIAL,
      msgid type symsgid value 'ZBC401',
      msgno type symsgno value '002',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of AZUBI_INITIAL .
  constants:
    begin of MITA_INTITIAL,
      msgid type symsgid value 'ZBC401',
      msgno type symsgno value '003',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of MITA_INTITIAL .
  constants:
    begin of WRONG_PLANETYPE,
      msgid type symsgid value 'ZBC401',
      msgno type symsgno value '004',
      attr1 type scx_attrname value 'PLANETYPE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of WRONG_PLANETYPE .
  constants:
    begin of PLANETYPE_EMPTY,
      msgid type symsgid value 'ZBC401',
      msgno type symsgno value '005',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of PLANETYPE_EMPTY .
  constants:
    begin of ERROR_CONSTRUCTOR,
      msgid type symsgid value 'ZBC401',
      msgno type symsgno value '010',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of ERROR_CONSTRUCTOR .
  data WERT1 type INT4 .
  data WERT2 type INT4 .
  data PLANETYPE type SAPLANE-PLANETYPE .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !WERT1 type INT4 optional
      !WERT2 type INT4 optional
      !PLANETYPE type SAPLANE-PLANETYPE optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_00_BC401_NK IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->WERT1 = WERT1 .
me->WERT2 = WERT2 .
me->PLANETYPE = PLANETYPE .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
