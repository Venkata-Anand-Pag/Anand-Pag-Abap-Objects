CLASS zcl_raj_demo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    class-METHODS: get_ariba_token,
                   get_sf_token,
                   get_sf_oauth_token
                      IMPORTING iv_token type string,
                   get_sf_emp_job_details
                      importing iv_token type string,
                   get_cat_food,
                   get_sourcing_document
                      importing    iv_token    type string,
                   get_successfactors_job1,
                   update_skills
                      importing   iv_data type zxstring.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_RAJ_DEMO IMPLEMENTATION.


  METHOD get_ariba_token.
    DATA:
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_request       TYPE REF TO /iwbep/if_cp_request_update,
*      lo_response      TYPE REF TO /iwbep/if_cp_response_update,
      lo_response_read TYPE REF TO /iwbep/if_cp_response_read.
     DATA lv_body type string.


    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'ZARIBATOKEN'
                                                     comm_system_id = 'ZARIBATOKEN'
                                                     service_id     = 'ZARIBA_GET_TOKEN_REST' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*        DATA(lo_http_client) = cl_http_client=>create_by_destination( lo_destination ).
        DATA(request) = lo_http_client->get_http_request( ).

*        lo_http_client->request->set_method( if_http_request=>co_request_method_post ).
*        request->set_header_fields( VALUE #(
*          ( name  = 'Ocp-Apim-Subscription-Key'
*            value = '660932ed8262476c80786941d528a956' )
*          ( name = 'Content-Type'                         ##NO_TEXT
*            value = 'text/xml; charset=UTF-8' ) ) ).
*
*      lv_body = |<?xml version="1.0" standalone="no"?>| &&
*                |<labels _FORMAT="case.nlbl" _PRINTERNAME="Production01" _QUANTITY="1">| &&
*                |<label>        <variable name="CASEID">0000000123</variable>| &&
*                |<variable name="CARTONTYPE"/>| &&
*                |<variable name="ORDERKEY">0000000534</variable>| &&
*                |<variable name="CONTAINERDETAILID">0000004212</variable>| &&
*                |<variable name="SERIALREFERENCE">0</variable>| &&
*                |<variable name="FILTERVALUE">0</variable>| &&
*                |<variable name="INDICATORDIGIT">0</variable>| &&
*                |<variable name="DATE">11/19/2012 10:59:03</variable>| &&
*                |</label>| &&
*                |</labels>|.
*        request->set_text( i_text = lv_body
*                         i_length = strlen( lv_body ) ).
*
        DATA(lo_response) = lo_http_client->execute( if_web_http_client=>post ).

        DATA(status) = lo_response->get_status( ).
        IF status-code NE 200.
            "Error handling here
        ENDIF.
        data(lv_response) = lo_response->get_text(  ).
        SPLIT lv_response at '{"access_token":"' INTO DATA(lv_dummy) lv_response .
        SPLIT lv_response at '"' INTO lv_response lv_dummy.
        CALL method zcl_raj_demo=>get_sourcing_document( lv_response ).
        CATCH cx_web_http_client_error cx_http_dest_provider_error.
*        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*        DATA(request) = lo_http_client->get_http_request( ).
*        DATA body TYPE string VALUE '{}'.
** Set Filter
**        request->set_query( |$filter=Product eq 'RAWRDB'| ).
**       request->set_query( .|{ lv_filter }| ).
*        request->set_header_fields( VALUE #(
*          ( name  = 'Ocp-Apim-Subscription-Key'
*            value = '660932ed8262476c80786941d528a956' )
*          ( name = 'Content-Type'                         ##NO_TEXT
*            value = 'application/json; charset=UTF-8' )   ##NO_TEXT
*          ( name = 'Accept'                               ##NO_TEXT
*            value = 'application/json' )                  ##NO_TEXT
*           ( name = 'Content-Length'                      ##NO_TEXT
*             value = strlen( body ) ) ) ).
*
*
**        request->set_authorization_basic(
**          i_username = lv_username
**          i_password = lv_password ).
*
*        request->set_text( i_text = body
*                         i_length = strlen( body ) ).
*
*        DATA(response) = lo_http_client->execute( if_web_http_client=>get ).
*
**        /ui2/cl_json=>deserialize(
**          EXPORTING
**            json = response->get_text( )
**          CHANGING
**            data = DATA(response_value) ).
*
        CATCH cx_root INTO DATA(lx_exception).

     ENDTRY.

  ENDMETHOD.


  METHOD get_cat_food.

  ENDMETHOD.


  METHOD get_sf_emp_job_details.
    DATA:
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_request       TYPE REF TO /iwbep/if_cp_request_update,
*      lo_response      TYPE REF TO /iwbep/if_cp_response_update,
      lo_response_read TYPE REF TO /iwbep/if_cp_response_read.
     DATA lv_body type string.


    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'ZSFGETEMPJOBDETAILS'
                                                     comm_system_id = 'ZSFGETEMPJOBDETAILS'
                                                     service_id     = 'ZSF_GET_EMP_JOB_DETAILS_REST' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*        DATA(lo_http_client) = cl_http_client=>create_by_destination( lo_destination ).
        DATA(request) = lo_http_client->get_http_request( ).

*        lo_http_client->request->set_method( if_http_request=>co_request_method_post ).
        DATA(lv_auth) = |Bearer { iv_token }|.
        request->set_header_fields( VALUE #(
*          ( name  = 'APIKEY'
*            value = 'JPM2rKshs9FH3RtTYRMh2KiVlgqPPpD9' )
          ( name = 'Authorization'                         ##NO_TEXT
            value = lv_auth ) ) ).

*        request->set_form_field( i_name = '$filter' i_value = '(createDateFrom gt 1706017141000 and createDateTo lt 1732369141000)' ).
*        request->set_form_field( i_name = 'realm' i_value = '744827196-T' ).
*        request->set_form_field( i_name = 'user' i_value = 'RYenamandra' ).
*        request->set_form_field( i_name = 'passwordAdapter' i_value = 'PasswordAdapter1' ).
        DATA(lo_response) = lo_http_client->execute( if_web_http_client=>get ).

        DATA(status) = lo_response->get_status( ).
        IF status-code NE 200.
            "Error handling here
        ENDIF.
        data(lv_response) = lo_response->get_text(  ).
        CATCH cx_web_http_client_error cx_http_dest_provider_error.
        CATCH cx_root INTO DATA(lx_exception).

     ENDTRY.
  ENDMETHOD.


  METHOD get_sf_oauth_token.
    DATA:
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_request       TYPE REF TO /iwbep/if_cp_request_update,
*      lo_response      TYPE REF TO /iwbep/if_cp_response_update,
      lo_response_read TYPE REF TO /iwbep/if_cp_response_read.
     DATA lv_body type string.


    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'ZSFGETOAUTHTOKEN'
                                                     comm_system_id = 'ZSFGETOAUTHTOKEN'
                                                     service_id     = 'ZSF_GET_OAUTH_TOKEN_REST' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*        DATA(lo_http_client) = cl_http_client=>create_by_destination( lo_destination ).
        DATA(request) = lo_http_client->get_http_request( ).

        request->set_form_field( i_name = 'client_id' i_value = 'NDM2YWIxNWNkM2FhMzYyMjE1ODJkMDcxOTExMg' ).
        request->set_form_field( i_name = 'company_id' i_value = 'SFCPART000604' ).
        request->set_form_field( i_name = 'user_id' i_value = 'SFAPI' ).
        request->set_form_field( i_name = 'token_url' i_value = 'https://apisalesdemo8.successfactors.com/oauth/idp' ).
        request->set_form_field( i_name = 'private_key' i_value = 'TUlJRXZnSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS2d3Z2dTa0FnRUFBb0lCQVFEbHlBTnZQZzFNbUVOSjR1cG5Bd2xpOVYvb2s3eVE4YS90ZDhodEtySHJKK2FyV3lrQzQvcW1MaDE4djEzbVBBRUhYd3NvQ1pydUZYQ2JtSWlKOTM2Wm' &&
'F5M05VQjFnTHd1VTl1NnBQb0pPY05WZXR2MTZGdXNTS053aXphTVEveHh5cWdXQk5MQytEMDZHT2l1bkFqaXREZ1NvV3J4MDVSNTNoR05aTjd2djk4TXdCOU5ITE8rOERhb28yWjlteVhDaUlVb1V3UEFLY3B6dEFGU09YVkVTNktXbUVOak5XcUtIQjFPbUhvR0NiMXVobjNvbnBtNUxOQ25xTUlFRzJYYVd5SFdDRHJsdWVKSXZCd2' &&
'5sa2xQV2lmcXF6RWdQbGZPVituakl1Y0g4cjlFdDE3ZVhrbXZyMzFiNGZWRlZjR2JJVFNDcVdFeEUxSlFrWU94WEtHMkZBZ01CQUFFQ2dnRUFCd1dJVlZYb0YzY2FWMHBWTDJDckMyM0VIZG43Tm4xVzRFTFF5bS9nNVV3SzJIYitBZFh3U3Q1ak9Fb0F3ZVd1TFFqU2U4bGtyL0hTY2NRYUtBZlFHVHEvNDQ1QjE0dnQwVmVGRGl4Qz' &&
'FITE9QUWxmMERpZHU2aFQvSEdjUExZUEFIeXNQbVBiSXNrRTlVVVhJR1lJK3F0Ni9rb0hpRUJDeTJtQzZsbXhwekRlM2ZXR2l0Uzl4a25aNm40MXY3RDZCN25qc3k5dVVjWlkvSjZzbWdmWk85eENqckh6OExZRXZ3bVVVMTZYcUdGZCtTZVlFcVJZMWVCUW1QMmQrT09TWTdIQU4wTElpei9tK1V2OHBEUkd5MjVUalo3dC9PY0ZHMz' &&
'hiMEsvcEFrR3o3aUtjUmlUYUdpbFBlZUdYYm9DNUpUcjg4YmJuSWpkTnU4a2xyWnpGNFFLQmdRRDc4Ny9jS2ttbE1nNjA4djJDd25pMFU5M3JKeTZVRVNzZUtxMVlTZzRTbThwa2F6cXd4bWxjZDNtWFdPVVlwOThueTd1L0kwcUtKRjhTS2dFN3JKWDEwWEI1VHM0MTRLUnVnbXNScFAySkZ0K1p6c1QzTzJ4NlJoSVRYTVJOQjZUdl' &&
'ZZeTRZb2w3UWRKdWo5TDlJRkpsaTkwNXVvenY0YmFIeTRCUHJ1RUErd0tCZ1FEcGVSUHF5NjRKWW9CM05pOUJZbGtKbUdvaVNONHUwdGhiUk95UXpNWWlZVWdMVllmQ0dzM09jcDlmU25jUUJBVCtWZ2UwNzY2ZkFvMWN5RURKemZjUlpiV1JZRFNicXI4UHdBQnpvRUEyS2JTOERTTjgvbmo3akF1WVBSK0NVTHV3Y0N1clFTbWlEQ0' &&
'RQZFNReUc0Z1FKOHdBbFUrRGNmbVVwUWxVakxJRGZ3S0JnUUNua1NhaVJCRzA1OFQyUGNHemJLbWdyVUtqK2V3MWwvR0lYN1BvUzJCdXFlU0N3dnBHeGI4Zk8yckg2Tng5ZUhDblpBMmJBdHE1WTVWRFhHSnprTVl2dGpyS3cwbk1kWHFHOFFCS3ZPUE9nRUw0WlplRUlxWno4QlJuZ2tRZ1F4eEQvUzdaRnRmKy9QajZoWGM2Mkh0VW' &&
'hCLy9HLzVPTUYwWWxaVGg2aHBGYndLQmdFZXRQRWdoTDlVQndKN1lxN2xQRURhNTdCdUtjMnU4bjErbDBWckRBekVhM0p0ZUxzZVFvdzUyY2ljM0hVWjFkWEwveG0zdUI1WVptbnlabmdwV2lUdDJGa0FEWVNOSlVFN3RpelgwUk1KY0czaUFNQnozb3Z6WENkZzdLNmsrVCtEakR3VU1oRk9UbFo4YlAzbUNxa3NMYkwzaEdRQXB4WT' &&
'IwL1NCUDhYYlJBb0dCQU5KWWpva2dWWjFKZldPK3NnUS91YVl1RTgxd3ZSZllmOWNqd3R0bTc3cHd5VjVWQUdXRHFTQ1dWbkhqenpOOThHdlVsaGxyL0p3ZmpiRHJvLzl4RUplWlhJbnpOYXlGNUNMM1BrNUlOT0pNcExHdVV0VDBvQXR5ZnBwU2NKcEcwOFd1N0c5ckhjbWI2cHpWSHVUY1VBKzJiWGRMRzhFR0ZHODV5YVJzNXlnUy' &&
'MjI1NGQ1BBUlQwMDA2MDQ=' ).
        request->set_form_field( i_name = 'assertion' i_value = iv_token ).
        request->set_form_field( i_name = 'grant_type' i_value = 'urn:ietf:params:oauth:grant-type:saml2-bearer' ).

        DATA(lo_response) = lo_http_client->execute( if_web_http_client=>post ).

        DATA(status) = lo_response->get_status( ).
        IF status-code NE 200.
            "Error handling here
        ENDIF.
        data(lv_response) = lo_response->get_text(  ).
        SPLIT lv_response at '{"access_token":"' INTO DATA(lv_dummy) lv_response .
        SPLIT lv_response at '"' INTO lv_response lv_dummy.
        CALL method zcl_raj_demo=>get_sf_emp_job_details( lv_response ).
        CATCH cx_web_http_client_error cx_http_dest_provider_error.
        CATCH cx_root INTO DATA(lx_exception).

     ENDTRY.


  ENDMETHOD.


  METHOD get_sf_token.
    DATA:
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_request       TYPE REF TO /iwbep/if_cp_request_update,
*      lo_response      TYPE REF TO /iwbep/if_cp_response_update,
      lo_response_read TYPE REF TO /iwbep/if_cp_response_read.
     DATA lv_body type string.


    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'ZSFGETTOKEN'
                                                     comm_system_id = 'ZSFGETTOKEN'
                                                     service_id     = 'ZSF_GET_TOKEN_REST' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*        DATA(lo_http_client) = cl_http_client=>create_by_destination( lo_destination ).
        DATA(request) = lo_http_client->get_http_request( ).

        request->set_form_field( i_name = 'client_id' i_value = 'NDM2YWIxNWNkM2FhMzYyMjE1ODJkMDcxOTExMg' ).
        request->set_form_field( i_name = 'company_id' i_value = 'SFCPART000604' ).
        request->set_form_field( i_name = 'user_id' i_value = 'SFAPI' ).
        request->set_form_field( i_name = 'token_url' i_value = 'https://apisalesdemo8.successfactors.com/oauth/idp' ).
        request->set_form_field( i_name = 'private_key' i_value = 'TUlJRXZnSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS2d3Z2dTa0FnRUFBb0lCQVFEbHlBTnZQZzFNbUVOSjR1cG5Bd2xpOVYvb2s3eVE4YS90ZDhodEtySHJKK2FyV3lrQzQvcW1MaDE4djEzbVBBRUhYd3NvQ1pydUZYQ2JtSWlKOTM2Wm' &&
'F5M05VQjFnTHd1VTl1NnBQb0pPY05WZXR2MTZGdXNTS053aXphTVEveHh5cWdXQk5MQytEMDZHT2l1bkFqaXREZ1NvV3J4MDVSNTNoR05aTjd2djk4TXdCOU5ITE8rOERhb28yWjlteVhDaUlVb1V3UEFLY3B6dEFGU09YVkVTNktXbUVOak5XcUtIQjFPbUhvR0NiMXVobjNvbnBtNUxOQ25xTUlFRzJYYVd5SFdDRHJsdWVKSXZCd2' &&
'5sa2xQV2lmcXF6RWdQbGZPVituakl1Y0g4cjlFdDE3ZVhrbXZyMzFiNGZWRlZjR2JJVFNDcVdFeEUxSlFrWU94WEtHMkZBZ01CQUFFQ2dnRUFCd1dJVlZYb0YzY2FWMHBWTDJDckMyM0VIZG43Tm4xVzRFTFF5bS9nNVV3SzJIYitBZFh3U3Q1ak9Fb0F3ZVd1TFFqU2U4bGtyL0hTY2NRYUtBZlFHVHEvNDQ1QjE0dnQwVmVGRGl4Qz' &&
'FITE9QUWxmMERpZHU2aFQvSEdjUExZUEFIeXNQbVBiSXNrRTlVVVhJR1lJK3F0Ni9rb0hpRUJDeTJtQzZsbXhwekRlM2ZXR2l0Uzl4a25aNm40MXY3RDZCN25qc3k5dVVjWlkvSjZzbWdmWk85eENqckh6OExZRXZ3bVVVMTZYcUdGZCtTZVlFcVJZMWVCUW1QMmQrT09TWTdIQU4wTElpei9tK1V2OHBEUkd5MjVUalo3dC9PY0ZHMz' &&
'hiMEsvcEFrR3o3aUtjUmlUYUdpbFBlZUdYYm9DNUpUcjg4YmJuSWpkTnU4a2xyWnpGNFFLQmdRRDc4Ny9jS2ttbE1nNjA4djJDd25pMFU5M3JKeTZVRVNzZUtxMVlTZzRTbThwa2F6cXd4bWxjZDNtWFdPVVlwOThueTd1L0kwcUtKRjhTS2dFN3JKWDEwWEI1VHM0MTRLUnVnbXNScFAySkZ0K1p6c1QzTzJ4NlJoSVRYTVJOQjZUdl' &&
'ZZeTRZb2w3UWRKdWo5TDlJRkpsaTkwNXVvenY0YmFIeTRCUHJ1RUErd0tCZ1FEcGVSUHF5NjRKWW9CM05pOUJZbGtKbUdvaVNONHUwdGhiUk95UXpNWWlZVWdMVllmQ0dzM09jcDlmU25jUUJBVCtWZ2UwNzY2ZkFvMWN5RURKemZjUlpiV1JZRFNicXI4UHdBQnpvRUEyS2JTOERTTjgvbmo3akF1WVBSK0NVTHV3Y0N1clFTbWlEQ0' &&
'RQZFNReUc0Z1FKOHdBbFUrRGNmbVVwUWxVakxJRGZ3S0JnUUNua1NhaVJCRzA1OFQyUGNHemJLbWdyVUtqK2V3MWwvR0lYN1BvUzJCdXFlU0N3dnBHeGI4Zk8yckg2Tng5ZUhDblpBMmJBdHE1WTVWRFhHSnprTVl2dGpyS3cwbk1kWHFHOFFCS3ZPUE9nRUw0WlplRUlxWno4QlJuZ2tRZ1F4eEQvUzdaRnRmKy9QajZoWGM2Mkh0VW' &&
'hCLy9HLzVPTUYwWWxaVGg2aHBGYndLQmdFZXRQRWdoTDlVQndKN1lxN2xQRURhNTdCdUtjMnU4bjErbDBWckRBekVhM0p0ZUxzZVFvdzUyY2ljM0hVWjFkWEwveG0zdUI1WVptbnlabmdwV2lUdDJGa0FEWVNOSlVFN3RpelgwUk1KY0czaUFNQnozb3Z6WENkZzdLNmsrVCtEakR3VU1oRk9UbFo4YlAzbUNxa3NMYkwzaEdRQXB4WT' &&
'IwL1NCUDhYYlJBb0dCQU5KWWpva2dWWjFKZldPK3NnUS91YVl1RTgxd3ZSZllmOWNqd3R0bTc3cHd5VjVWQUdXRHFTQ1dWbkhqenpOOThHdlVsaGxyL0p3ZmpiRHJvLzl4RUplWlhJbnpOYXlGNUNMM1BrNUlOT0pNcExHdVV0VDBvQXR5ZnBwU2NKcEcwOFd1N0c5ckhjbWI2cHpWSHVUY1VBKzJiWGRMRzhFR0ZHODV5YVJzNXlnUy' &&
'MjI1NGQ1BBUlQwMDA2MDQ=' ).
        request->set_form_field( i_name = 'grant_type' i_value = 'urn:ietf:params:oauth:grant-type:saml2-bearer' ).

        DATA(lo_response) = lo_http_client->execute( if_web_http_client=>post ).

        DATA(status) = lo_response->get_status( ).
        IF status-code NE 200.
            "Error handling here
        ENDIF.
        data(lv_response) = lo_response->get_text(  ).
*        SPLIT lv_response at '{"access_token":"' INTO DATA(lv_dummy) lv_response .
*        SPLIT lv_response at '"' INTO lv_response lv_dummy.
        CALL method zcl_raj_demo=>get_sf_oauth_token( lv_response ).
        CATCH cx_web_http_client_error cx_http_dest_provider_error.
        CATCH cx_root INTO DATA(lx_exception).

     ENDTRY.


  ENDMETHOD.


  METHOD get_sourcing_document.
    DATA:
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_request       TYPE REF TO /iwbep/if_cp_request_update,
*      lo_response      TYPE REF TO /iwbep/if_cp_response_update,
      lo_response_read TYPE REF TO /iwbep/if_cp_response_read.
     DATA lv_body type string.


    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'ZARIBASOURCING'
                                                     comm_system_id = 'ZARIBASOURCING'
                                                     service_id     = 'ZGETARIBASOURCING_REST' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*        DATA(lo_http_client) = cl_http_client=>create_by_destination( lo_destination ).
        DATA(request) = lo_http_client->get_http_request( ).

*        lo_http_client->request->set_method( if_http_request=>co_request_method_post ).
        DATA(lv_auth) = |Bearer { iv_token }|.
        request->set_header_fields( VALUE #(
          ( name  = 'APIKEY'
            value = 'JPM2rKshs9FH3RtTYRMh2KiVlgqPPpD9' )
          ( name = 'Authorization'                         ##NO_TEXT
            value = lv_auth ) ) ).

        request->set_form_field( i_name = '$filter' i_value = '(createDateFrom gt 1706017141000 and createDateTo lt 1732369141000)' ).
        request->set_form_field( i_name = 'realm' i_value = '744827196-T' ).
        request->set_form_field( i_name = 'user' i_value = 'RYenamandra' ).
        request->set_form_field( i_name = 'passwordAdapter' i_value = 'PasswordAdapter1' ).
*        request->set_text( i_text = lv_body
*                         i_length = strlen( lv_body ) ).
*
        DATA(lo_response) = lo_http_client->execute( if_web_http_client=>get ).

        DATA(status) = lo_response->get_status( ).
        IF status-code NE 200.
            "Error handling here
        ENDIF.
        data(lv_response) = lo_response->get_text(  ).
        CATCH cx_web_http_client_error cx_http_dest_provider_error.
*        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*        DATA(request) = lo_http_client->get_http_request( ).
*        DATA body TYPE string VALUE '{}'.
** Set Filter
**        request->set_query( |$filter=Product eq 'RAWRDB'| ).
**       request->set_query( .|{ lv_filter }| ).
*        request->set_header_fields( VALUE #(
*          ( name  = 'Ocp-Apim-Subscription-Key'
*            value = '660932ed8262476c80786941d528a956' )
*          ( name = 'Content-Type'                         ##NO_TEXT
*            value = 'application/json; charset=UTF-8' )   ##NO_TEXT
*          ( name = 'Accept'                               ##NO_TEXT
*            value = 'application/json' )                  ##NO_TEXT
*           ( name = 'Content-Length'                      ##NO_TEXT
*             value = strlen( body ) ) ) ).
*
*
**        request->set_authorization_basic(
**          i_username = lv_username
**          i_password = lv_password ).
*
*        request->set_text( i_text = body
*                         i_length = strlen( body ) ).
*
*        DATA(response) = lo_http_client->execute( if_web_http_client=>get ).
*
**        /ui2/cl_json=>deserialize(
**          EXPORTING
**            json = response->get_text( )
**          CHANGING
**            data = DATA(response_value) ).
*
        CATCH cx_root INTO DATA(lx_exception).

     ENDTRY.


  ENDMETHOD.


  METHOD get_successfactors_job1.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    TRY.
        CALL METHOD zcl_raj_demo=>get_sf_token(  ).
*        CALL METHOD zcl_raj_demo=>get_ariba_token(  ).
      CATCH cx_http_dest_provider_error cx_web_http_client_error.
        "handle exception
    ENDTRY.
  ENDMETHOD.


  METHOD update_skills.

  ENDMETHOD.
ENDCLASS.
