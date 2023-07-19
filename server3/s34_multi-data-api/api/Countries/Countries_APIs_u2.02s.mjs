/*\
##=========+====================+================================================+
##RD       Countries_APIs.mjs   | formR API script for et217p_World
##RFILE    +====================+=======+===============+======+=================+
##FD   Countries_APIs_u2.01.mjs |   2925|  3/12/23 12:08|    65| u2.01`30312.1200
##FD   Countries_APIs_u2.02.mjs |  33135|  6/27/23 18:10|   585| u2.02`30627.1810
##DESC     .--------------------+-------+---------------+------+-----------------+
#           This Javascript file sets up and handles the ExpressJS Server routes
#           by call the appropriate SQL statements with approriate arguments
##LIC      .--------------------+----------------------------------------------+
#           Copyright (c) 2023 8020Data-formR * Released under
#           MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#           _Entity_Server      | Main Class of Express routes
#             _Entity_testRoute | Form to tgest six methods/actions
#             _Entity_getRoutes | Handle insert, select, update and delete actions
#             _Entity_postRoutes| Handle insert, and update actions
#             start             | Start the Express Server
##CHGS     .--------------------+----------------------------------------------+
# .(30607.01  6/07/23 RAM 12:00p|  Copied from IODD_Server_u1.08.mjs
# .(30619.01  6/19/23 RAM  8:10a|  Add aTestRoute
# .(30622.03  6/22/23 RAM  8:30a|  Exit if pDB.Err
# .(30627.04  6/27/23 RAM  1:00p|  Add pCols and Cols to pArgs in chkSQL

##PRGM     +====================+===============================================+
##ID                            |
##SRCE =========================+========================================================================== #  ===============================  #
#*/
//  ----------------------------|  -------------------------------- ------------------- ------------------+ --------------------------

   import   express       from    'express';

   import { setRoute, chkArgs, getData, sndHTML, sndRecs     } from '../../assets/MJSs/formr_server-fns_u1.07.mjs';
   import { init, start, initDB,  logIP, sayMsg, fncName     } from '../../assets/MJSs/formr_server-fns_u1.07.mjs';
   import { chkSQL,  putData,    CCase,  __appDir, __dirname } from '../../assets/MJSs/formr_server-fns_u1.07.mjs';
//
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+

      var __filename   =  import.meta.url.replace( /^.+\//, "" )

        if (process.argv[1].replace( /.*[\\/]/, '' ).match( __filename )) {

       var  bQuiet //  =  true        // Override .env Quiet = {true|false}
       var  nPort      =  50383       // Override .env Server_Port
       var  aAPI   //  = 'api50381'   // Override .env Remote_API

       var  pApp       =  express()

       var  aAPI_Host, aEntities, aEntity //, pDB // pDB_Config = { }
       var  pServer    =  new _Entity_Server( pApp  )

//     ---  ------------------  =  -------------------------------- -------------------

      var { aAPI_Host_: aAPI_Host, bQuiet_: bQuiet } = init( pApp, bQuiet, aAPI );

            pServer.setRoutes( aAPI_Host )

            pServer.start( pApp, nPort, '/test' )

         }; // eif Running in VSCode debugger
//  ------  ----  ---  =  ------|  -------------------------------- -------------------

//========  =============================================================================================== #  ===============================  #
//========  =============================================================================================== #  ===============================  #

  function  _Entity_Server( pApp_ ) {

       var  pApp                =  pApp_ // express()
       var  aAPI_Host
       var  pDB, pDB_Config     = { }
       var  aDBSN               = "et217p_World"
       var  aEntities           = "countries"
       var  aEntity             = "Country"

       this.Entities            =  aEntities
       this.API_Host            =  aAPI_Host
 //    this.DBs[ aDBSN ]        =  this.DBs[ aDBSN ] + ',${aEntities}'
       this.DBSNs               = ( typeof( pDBSNs ) != 'undefined' ) ? this.DBSNs : {}

//     ---  ------------------  =  -------------------------------- -------------------

this.setRoutes = function(        aAPI_Host_  ) {

            this._Entity_testRoute()     // _Countries_testRoute( )
            this._Entity_getRoutes()     // _Countries_getRoutes( )
            this._Entity_postRoutes()    // _Countries_posstRoute( )

         }; // eof setRoutes
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+

//========  ===========================================  ============================================================

this._Entity_testRoute  = function( ) {

       pApp.get( `${aAPI_Host}${aRoute}`, _Entity_testRoute_Handler )

     async  function  _Entity_testRoute_Handler( pReq, pRes ) {

  function  fmtHTML( pArgs ) {

              <form ${ fmtForm( 1, aEntities, 'get',  '',         aId,  ``,                              55, 170 ) }</form>
              <form ${ fmtForm( 2, aEntities, 'get',  'insert ',  ''  , `New ${aEntity} No. ${nNo + 1}`, 55, 170 ) }</form>
              <form ${ fmtForm( 3, aEntities, 'get',  'select ',  ''  , `Old ${aEntity} No. ${nNo + 0}`, 55, 170 ) }</form>
              <form ${ fmtForm( 4, aEntities, 'get',  'update',  'USA', `United States`,                 55, 170 ) }</form>
              <form ${ fmtForm( 5, aEntities, 'get',  'delete ',  aId,  ``,                              55, 170 ) }</form>
              <form ${ fmtForm( 6, aEntities, 'post', '',         aId,  `Chg ${aEntity} No. ${nNo - 1}`, 55, 170 ) }</form>
              <form ${ fmtForm( 7, aEntities, 'post', 'insert ',  ''  , `New ${aEntity} No. ${nNo + 1}`, 55, 170 ) }</form>
              <form ${ fmtForm( 8, aEntities, 'post', 'update',   aId,  `Chg ${aEntity} No. ${nNo - 1}`, 55, 170 ) }</form>

  function  fmtForm(  nNo, aRoute, aMethod, aAction, aIds, aName, nWdt1, nWdt2 ) {

         }; // eof _Entity_testRoute
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+

//========  ===========================================  ============================================================

this.Table_getRoute = function( ) {

            setRoute( pApp, aMethod, aRoute, JSON_getRoute_Handler, pValidArgs, fmtSQL )

  function  fmtSQL( pArgs ) {

         }; // eof Table_getRoute
//  ------  ---- ----  =  ------|  -------------------------------- ------------------- ------------------+

//========  ===========================================  ============================================================
//========  ===========================================  ============================================================

this._Entity_getRoutes = function( ) {

       var  pInsertArgs         = { name:   /[a-zA-Z][a-zA-Z0-9_]+/
       var  pSelectArgs         = { id:     /[a-zA-Z0-9]{1,3}/    // aka Code
       var  pUpdateArgs         = { code:   /[a-zA-Z0-9]{3}/
       var  pDeleteArgs         = { id:     /[a-zA-Z0-9]{3}/

  function  fmtSelectSQL( pArgs ) {
  function  fmtInsertSQL( pCols ) {
  function  fmtUpdateSQL( pArgs ) {

            setRoute( pApp, aMethod,  aRoute, _Entity_getRoutes_Handler )

//     ---  ------------------  =  -------------------------------- ------------------- ------------------+

     async  function   _Entity_getRoutes_Handler(   pReq, pRes ) {

        case 'insert': _Entity_getInsert_Handler(  pReq, pRes, pInsertArgs, fmtInsertSQL ); break; // Create
        case 'select': _Entity_getSelect_Handler(  pReq, pRes, pSelectArgs, fmtSelectSQL ); break; // Read
        case 'update': _Entity_getUpdate_Handler(  pReq, pRes, pUpdateArgs, fmtUpdateSQL ); break; // Update
        case 'delete': _Entity_getDelete_Handler(  pReq, pRes, pDeleteArgs, fmtDeleteSQL ); break; // Delete

            }   // eof _Entity_postRoute_Handler
//     ---  ------------------  =  -------------------------------- -------------------

     async  function   _Entity_getSelect_Handler(  pReq, pRes,  pValidArgs, fmtSQL ) {
     async  function   _Entity_getInsert_Handler(  pReq, pRes,  pValidArgs, fmtSQL ) {
     async  function   _Entity_getUpdate_Handler(  pReq, pRes,  pValidArgs, fmtSQL ) {
     async  function   _Entity_getDelete_Handler(  pReq, pRes,  pValidArgs, fmtSQL ) {

         }; // eof _Entity_getRoutes
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+

//========  ===========================================  ============================================================

this._Entity_postRoutes= function( ) {

       var  pInsertArgs         = { name:   /[a-zA-Z][a-zA-Z0-9_]+/
       var  pUpdateArgs         = { code:   /[a-zA-Z0-9]{3}/

  function  fmtInsertSQL( pCols ) {
  function  fmtUpdateSQL( pArgs ) {

            setRoute( pApp, aMethod,  aRoute, _Entity_postRoutes_Handler )

     async  function   _Entity_postRoutes_Handler(  pReq, pRes ) {

        case 'insert': _Entity_postInsert_Handler( pReq, pRes, pInsertArgs, fmtInsertSQL ); break;
        case 'update': _Entity_postUpdate_Handler( pReq, pRes, pUpdateArgs, fmtUpdateSQL ); break;

     async  function   _Entity_postInsert_Handler( pReq, pRes,  pValidArgs, fmtSQL   ) {
     async  function   _Entity_postUpdate_Handler( pReq, pRes,  pValidArgs, fmtSQL   ) {

         }; // eof _Entity_postRoutes
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+

//========  ===========================================  ============================================================




//========  ===========================================  ============================================================

     async  function  JSON_getRoute_Handler( aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL ) {

this.start= function( pApp, nPort, aTest ) {

     }; // eoc _Entity_Server
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+

//==============================+========================================================================== #  ===============================  #

    export default _Entity_Server
