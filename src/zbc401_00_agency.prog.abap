*&---------------------------------------------------------------------*
*&  Include           ZBC401_00_AGENCY
*&---------------------------------------------------------------------*

INTERFACE lif_partner.
  METHODS display_partner.
  events partner_event.

ENDINTERFACE.
CLASS lcl_travel_agency DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_partner.
    METHODS:
      constructor IMPORTING iv_name TYPE string,

      display_attributes,
      add_partner IMPORTING io_partner TYPE REF TO lif_partner.

  PRIVATE SECTION.
    CLASS-DATA mt_partners TYPE TABLE OF REF TO lif_partner.
    DATA:
      mv_name     TYPE string.

ENDCLASS.                    "lcl_travel_agency DEFINITION

*---------------------------------------------------------------------*
*       CLASS lcl_travel_agency IMPLEMENTATION
*---------------------------------------------------------------------*
CLASS lcl_travel_agency IMPLEMENTATION.

  METHOD display_attributes.
    WRITE: / icon_private_files AS ICON,
             'Travel Agency:'(007), mv_name.
    ULINE.
    LOOP AT mt_partners INTO DATA(lo_partner).
      lo_partner->display_partner( ).
    ENDLOOP.
  ENDMETHOD.                    "display_attributes

  METHOD  constructor.
    mv_name = iv_name.
    raise event lif_partner~partner_event.
  ENDMETHOD.                    "constructor

  METHOD add_partner.
    INSERT io_partner INTO TABLE mt_partners.
  ENDMETHOD.
  METHOD lif_partner~display_partner.
    CALL METHOD display_attributes( ).
  ENDMETHOD.
ENDCLASS.                    "lcl_travel_agency IMPLEMENTATION
