*&---------------------------------------------------------------------*
*& Report Z00_SINGLETON_VERWENDUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_singleton_verwendung.

DATA go_singleton TYPE REF TO zcl_singleton_00.

PARAMETERS pa type string.

go_singleton = zcl_singleton_00=>go_single.

BREAK-POINT.
*go_singleton = zcl_singleton_00=>get_single( ).
*go_singleton = zcl_singleton_00=>get_single( ).
*go_singleton = zcl_singleton_00=>get_single( ).
*go_singleton = zcl_singleton_00=>get_single( ).
*go_singleton = zcl_singleton_00=>get_single( ).
*go_singleton = zcl_singleton_00=>get_single( ).
