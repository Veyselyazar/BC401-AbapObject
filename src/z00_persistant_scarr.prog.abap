*&---------------------------------------------------------------------*
*& Report Z00_PERSISTANT_SCARR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_persistant_scarr.

DATA go_scarr TYPE REF TO zcl_scarr_00.
DATA go_agent TYPE REF TO zca_scarr_00.

go_agent = zca_scarr_00=>agent.

go_scarr = go_agent->create_persistent( i_carrid = 'ATS' ).
go_scarr->set_carrname( 'ATS-Airline' ).
go_scarr->set_currcode( 'EUR').
go_scarr->set_url( 'http://ats.com' ).

COMMIT WORK.

WRITE 'Fluggesellschaft wurde erzeugt'.
