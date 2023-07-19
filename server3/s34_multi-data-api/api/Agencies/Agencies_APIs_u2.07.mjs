/*\
##=========+====================+================================================+
##RD       Agencies_APIs.mjs    | formR API script for sc173d_BASEC_Agencies
##RFILE    +====================+=======+===============+======+=================+
##FD  Agencies_Server_u2.05.mjs |   2925|  3/12/23 12:08|    65| u2.05`30312.1200
##FD    Agencies_APIs_u2.07.mjs |  18735|  6/28/23 07:23|   272| u2.07`30628.0723

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
# .(30607.02  6/07/23 RAM  1:00p|  Change Assets folder name
# .(30608.03  6/07/23 RAM  4:30p|  Bump version: formr_server-fns_u1.07.mjs
# .(30611.05  6/11/23 RAM  7:15a|  Should init() be an async function
# .(30611.06  6/11/23 RAM  8:00a|  Get Handler name via fncName
# .(30612.01  6/12/23 RAM  9:00a|  Need pValidArgs for fmtSQL
# .(30613.01  6/13/23 RAM  8:15a|  Call Entity script from setMainRoutes
# .(30613.03  6/13/23 RAM  8:30a|  pDB is local or in this.DB
# .(30615.01  6/15/23 RAM  6:50a|  Don't set pDB in MainAPI_Server
# .(30619.01  6/19/23 RAM  8:10a|  Add aTestRoute
# .(30619.02  6/19/23 RAM  8:30a|  Should aAPI_HOST be pass as arg or set in this
# .(30622.01  6/22/23 RAM  7:45a|  Use aRoute or aRootRoute for 1st sayMsg
# .(30622.02  6/22/23 RAM  7:54a|  Always use CNT for testRoute
# .(30622.03  6/22/23 RAM  8:30a|  Exit if pDB.Err
# .(30622.04  6/22/23 RAM  9:00a|  Set Entity Vars
# .(30626.01  6/26/23 RAM  9:30a|  Write handler for forms
# .(30626.04  6/26/23 RAM 12:00p|  Add CCase and aEntity to fncName
# .(30627.02  6/27/23 RAM 10:37a|  Put aHandler in pRes
# .(30627.04  6/27/23 RAM  1:00p|  Add pCols and Cols to pArgs in chkSQL
# .(30627.02  6/28/23 RAM  8:07a|  Fix aHandler in Entity_testRoute_Handler
# .(30628.01  6/28/23 RAM  9:07a|  Add init back

##PRGM     +====================+===============================================+
##ID                            |
##SRCE =========================+========================================================================== #  ===============================  #
#*/
//  ----------------------------|  -------------------------------- ------------------- ------------------+ --------------------------

   import   express       from    'express';

   import { init, start, initDB, logIP, sayMsg,  fncName  } from '../../assets/MJSs/formr_server-fns_u1.07.mjs'; // .(30615.01.7).(30611.06.2)
   import { setRoute, chkArgs, getData, sndHTML, sndRecs  } from '../../assets/MJSs/formr_server-fns_u1.07.mjs'; // .(30608.03.1 RAM Bump version).(30607.02.1)
   import { chkSQL,  putData,  __appDir, __dirname, CCase } from '../../assets/MJSs/formr_server-fns_u1.07.mjs'; // .(30626.04.6 RAM Add CCase instead of sndErr)
//
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+

      var __filename   =  import.meta.url.replace( /^.+\//, "" )                        // .(30607.01.1 Add __filename)
      var   aAPI_Host, aEntities, aEntity                                               // .(30628.01.1 Move it here).(30613.01.2).(30615.01.8)

   if (process.argv[1].replace( /.*[\\/]/, '' ).match( __filename )) {                  // .(30607.01.2)

       var  bQuiet //  =  true        // Override .env Quiet = {true|false}
       var  nPort      =  50381       // Override .env Server_Port
       var  aAPI   //  = 'api50381'   // Override .env Remote_API

       var  pApp       =  express()                                                     // .(30613.01.1 RAM Set globals here when running standalone)

//     var  aAPI_Host, aEntities, aEntity  // pDB // pDB_Config = { }                   //#.(30613.01.2).(30615.01.8).(30628.01.1)
//     var  pDBs       = {}                                                             //#.(30615.03.11 RAM Initialize pDBs for pServer)

//     ---  ------------------  =  -------------------------------- -------------------

//     var  pServer    =  new _Entity_Server                                            //#.(30613.01.5).(30611.03.4 RAM Defined this.methods in "class").(30615.03.11).
       var  pServer    =  new _Entity_Server( pApp  )                                   // .(30615.03.12).(30613.01.5).(30611.03.3 RAM Defined this.methods in "class")

//   await                                     pServer.init(       bQuiet, aAPI )       //#.(30611.05.1 RAM Add async again).(30611.03.4)
                                               pServer.init( pApp, bQuiet, aAPI )       // .(30628.01.2).(30613.01.3 RAM Need to pass pApp).(30611.05.2 RAM But it didn't wait).(30611.03.4)
//    var { aAPI_Host_: aAPI_Host, bQuiet_: bQuiet } = init( pApp, bQuiet, aAPI );      //#.(30615.01.5 RAM Set pDB later).(30611.03.4).(30412.02.15 RAM Override aAPI_Host here).(30628.01.2)

//          pServer.setRoutes(   aAPI_Host, pDB )                                       //#.(30613.01.4).(30615.01.9 RAM Don't pass pDB_).(30615.03.12 RAM pDB is defined in pServer)
            pServer.setRoutes(   aAPI_Host )                                            // .(30615.03.12 RAM pDB is defined in pServer).(30615.01.9 RAM Don't pass pDB_).(30613.01.4)

//          pServer.start( pApp, nPort, aAPI_Host, '/test' )                            //#.(30619.01.1)
            pServer.start( pApp, nPort, '/test' )                                       // .(30619.01.1)

         }; // eif Running in VSCode debugger
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+


//========  =============================================================================================== #  ===============================  #

  function  _Entity_Server( pApp_ ) {                                                   // .(30615.03.10)

       var  pApp                =  pApp_ // express()                                   // .(30613.01.5 RAM pApp set in MainAPI_Server or above)
//     var  aAPI_Host
       var  pDB, pDB_Config     = { }                                                   // .(30613.03.13 RAM pDB is local or in this.DB)
       var  aDBSN               = "sc173d_BASEC"                                        // .(30615.01.7 RAM
       var  aEntities           = "agencies"                                            // .(30613.01.6)
       var  aEntity             = "Agency"                                              // .(30613.01.7)

       this.Entities            =  aEntities                                            // .(30619.01.2)
       this.API_Host            =  aAPI_Host                                            // .(30619.01.3)
 //    this.DBs[ aDBSN ]        =  this.DBs[ aDBSN ] + ',${aEntities}'                  //#.(30613.03.13)
       this.DBSNs               = ( typeof( pDBSNs ) != 'undefined' ) ? this.DBSNs : {} // .(30613.03.13)

//     ---  ------------------  =  -------------------------------- -------------------

//is.setRoutes = function(                    ) {                                       //#.(30619.02.1).(30615.03.21 RAM Don't pass it).(30615.03.11 RAM Do pass it).(30615.01.8 RAM Don't Set pDB here).(30613.01.9)
this.setRoutes = function(        aAPI_Host_  ) {                                       // .(30613.01.9).(30615.03.21 RAM Don't pass it).(30615.03.11 RAM Do pass it).(30615.01.8 RAM Don't Set pDB here).(30619.02.1)

            aAPI_Host  =  aAPI_Host_                                                    // .(30619.02.2).(30619.01.10).(30613.01.10)
//          aAPI_Host  =  this.API_Host                                                 //#.(30619.01.10).(30619.02.2 RAM was: aAPI_Host passed as arg)

       if (!this.DBSNs[ aDBSN ]) {                                                      // .(30613.03.13 RAM Check if new aDBSN, defined in this _Entity_Server, is not defined)
//     this.pDB        =  initDB( aDBSN, this.pDBSNs )                                  // .(30615.03.1 RAM Only create a new pDB if the current pDB is different)
            pDB        =  initDB( aDBSN )                                               // .(30615.03.1 RAM Only create a new pDB if the current pDB is different)
       var  aDBSN_Ents =  this.DBSNs[ aDBSN ] ? this.DBSNs[ aDBSN ] + ',' : ''          // .(30613.03.13)
       this.DBSNs[ aDBSN ] = `${ aDBSN_Ents }${aEntities}`                              // .(30613.03.14)
            }
            this._Agencies_testRoute( )
            this._Agencies_getRoutes( )
//          this._Agencies_postRoutes( )

         }; // eof setRoutes
//  ------  ---- ----  =  ------|  -------------------------------- ------------------- ------------------+


//========  ===========================================  ============================================================

this._Agencies_testRoute  = function( ) {                                                 // .(30619.01.4

       var  aMethod             =  'get'
       var  aRoute              =  `/${aEntities}/test`                                 // .(30613.01.12)
       var  aRootRoute          =   aRoute.substring( aAPI_Host ? 1 : 0 )
//     var  aEntities           =  'agencies'                                           //#.(30613.01.12
//     var  aEntities           =   this.Entities                                       //#.(30613.01.11 Was: 'agencies').(30619.01.5 RAM Was: local to Entity_Server)

//     ---  ------------------  =  -------------------------------- -------------------

       var  pValidArgs          =
             {  Entities        :  aEntities
             ,  Entity          :  aEntity                                              // .(30613.01.13)
             ,  Id              : 'A000000023'
             ,  No              :  0
                }
//     ---  ------------------  =  -------------------------------- -------------------

       var  fmtSQL1             =  function( ) {

    return `SELECT  count(*) as CNT from AGENCY_INFO  where AGENCY_DEPT_ID = 'AGENCY'`  // .(30622.02.1 RAM Always use CNT, not Cnt)
                }
//     ---  ------------------  =  -------------------------------- -------------------

       pApp.get( `${aAPI_Host}${aRoute}`, _Agencies_testRoute_Handler )

                                sayMsg(  aMethod,  `${aAPI_Host}${ aRoute }` )          // .(30622.01.1 RAM Which is it)

//     ---  ------------------  =  -------------------------------- -------------------

     async  function  _Agencies_testRoute_Handler( pReq, pRes ) {
//     var  aHandler    = `_${ CCase( aEntities ) }_testRoute_Handler`                  // .(30627.02.31 RAM Could use this and eliminate fncName)

                                logIP(   pReq, pDB, `GET  Route, ${aRoute}` )           // .(30612.01.x RAM Was: '/' )
                                sayMsg(  pReq, aMethod, aRootRoute )

       var  pArgs      =        chkArgs( pReq, pRes, pValidArgs );        if (!pArgs ) { return }

       var  mRecs1     =  await getData( pDB, fmtSQL1( ), aRoute, pRes ); if (pDB.Err) { return }
            pArgs      =        pValidArgs                                              // .(30612.01.1 RAM Need for fmtSQL)
            pArgs.No   =        mRecs1[0].CNT                                           // .(30622.02.2)

       var  aHTML      =        fmtHTML( pArgs )                                        // .(30612.01.2 RAM Was: pArgs.name || '')

                                sndHTML( pRes, aHTML, `${aRootRoute}${pReq.args}`)
                                sayMsg( 'Done', fncName( 2, CCase( aEntities ) ) )      // .(30627.02.31).(30611.06.3 RAM Get Handler name)

            } // eof _Agencies_testRoute_Handler
//     ---  ------------------  =  -------------------------------- -------------------

  function  fmtHTML( pArgs ) {                                                          // .(30612.01.3 RAM Rework it).(30405.03.1 Beg RAM Add ${aAPI_Host} to URLs)

       var  aEntities  =        pArgs.Entities
       var  aEntity    =        pArgs.Entity
       var  aId        =        pArgs.Id
       var  nNo        =        pArgs.No                                                // .(30622.02.3)

       var  aHTML      = `
            Welcome to FRApps MySQL Express Server API (v2-01).<br>
            Use any of the following APIs:<br><br>

            <div style="margin-left:40px; font-size:16px; line-height: 25px; font-family:arial";>

              <form ${ fmtForm( 1, aEntities, 'get',  '',         aId,  ``,                              75, 170 ) }</form>
              <form ${ fmtForm( 2, aEntities, 'get',  'insert ',  ''  , `New ${aEntity} No. ${nNo + 1}`, 75, 170 ) }</form>
      <!--    <form ${ fmtForm( 3, aEntities, 'get',  'select ',  ''  , `Old ${aEntity} No. ${nNo + 0}`, 75, 170 ) }</form>
              <form ${ fmtForm( 4, aEntities, 'get',  'update',   aId,  `Chg ${aEntity} No. ${nNo - 1}`, 75, 170 ) }</form>
              <form ${ fmtForm( 5, aEntities, 'get',  'delete ',  aId,  ``,                              75, 170 ) }</form>
              <form ${ fmtForm( 6, aEntities, 'post', '',         aId,  `Chg ${aEntity} No. ${nNo - 1}`, 75, 170 ) }</form>
              <form ${ fmtForm( 7, aEntities, 'post', 'insert ',  ''  , `New ${aEntity} No. ${nNo + 1}`, 75, 170 ) }</form>
              <form ${ fmtForm( 8, aEntities, 'post', 'update',   aId,  `Chg ${aEntity} No. ${nNo - 1}`, 75, 170 ) }</form>
       -->
            </div> `;

            aHTML   += `
            <script>                                                                    // .(30626.01.1 RAM Write a submit handler for forms)
                 function  onClick(  nNo, pEvt, aMethod ) {
                           pEvt.preventDefault();
                       if (pEvt.target.tagName == 'INPUT') { return }

                      var  pForm   = document.forms[ nNo - 1 ]
                      var  aAction = pForm.outerHTML.match( /action="(.+?)"/)[1]

                      var  aID     = pForm.id   ?  pForm.id.value.trim()   : '', q = aAction.match( /[?]/ ) ? '&' : '?'
                      var  aName   = pForm.name ?  pForm.name.value.trim() : ''

                       if (aID   ) { pForm.id.value   = aID   } else { pForm.id.remove() }
                       if (aName ) { pForm.name.value = aName } else { pForm.name.remove() }

                       if (aID   ) { aAction    += q + "id="   + aID;            q = '&' }
                       if (aName ) { aAction    += q + "name=" + aName.replace( / /g, '%20' ); q = '&' }

                      var  aAction = document.location.origin + aAction;         console.log( aAction )

                       if (aMethod == 'get' ) { document.location = aAction }
                       if (aMethod == 'post') { pForm.submit() }
                         }
            </script>  `

    return  aHTML
            }; // eof fmtHTML
//     ---  ------------------  =  -------------------------------- -------------------

  function  fmtForm(  nNo, aRoute, aMethod, aAction, aIds, aName, nWdt1, nWdt2 ) {      // .(30627.01.1 RAM Add nNo).(30612.01.4 Just one for all)
       var  aAction1 =  aAction ? "?action=" + aAction.replace( / /, '' ) : "";
       var  aAction2 =  aAction ? "?action=" + aAction.replace( / /, '&nbsp;' ) + "&" : "? &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;";
       var  aForm    =` method="${aMethod}" id="F${nNo}" action="${aAPI_Host}/${aRoute}${aAction1}"   style="margin-bottom: -5px;">
              <a href="${aAPI_Host}/${aRoute}${aAction1}" onclick="onClick(${nNo}, event,'${aMethod}')">/${aRoute}${aAction2}` +
                  `id=<input type="text"   name="id"     value=" ${aIds}"   style="padding: 0px;  width: ${nWdt1}px" />` +
               `&name=<input type="text"   name="name"   value=" ${aName}"  style="padding: 0px;  width: ${nWdt2}px" /></a>`
    return  aForm
            }; // eof fmtForm
//     ---  ------------------  =  -------------------------------- -------------------
         }; // eof _Agencies_testRoute
//  ------  ---- ----  =  ------|  -------------------------------- ------------------- ------------------+


//========  ===========================================  ============================================================

this._Agencies_getRoutes = function( ) {

       var  aMethod    = 'get'                                                                  // .(30622.04.1)
       var  aRoute     = `/${aEntities}`                                                        // .(30622.04.2 RAM Set Entity Vars)

       var  pValidArgs          =
             {  Id              : /A000000[0-9]{3}/
                }
//     ---  ------------------  =  -------------------------------- -------------------

       var  fmtSQL1             =  function( ) {

       var  aSQL       = `
          SELECT  *
            FROM  AGENCY_INFO
           WHERE  AGENCY_ID = '${ pArgs.id }'
             AND  AGENCY_DEPT_ID = 'AGENCY' `

    return  aSQL
                }
//     ---  ------------------  =  -------------------------------- -------------------

            setRoute( pApp, aMethod,  aRoute, _Agencies_getRoutes_Handler )

//     ---  ------------------  =  -------------------------------- ------------------- ------------------+

     async  function   _Agencies_getRoutes_Handler( pReq, pRes ) {

       var  pAction    =  chkArgs( pReq, pRes, { action: /insert|select|update|delete/i } ); // if (!pAction) { return }
       var  aAction    =  pAction && pAction.action ? pAction.action.toLowerCase() : 'select'
            delete        pReq.query.action

     async  function   _Agencies_getSelect_Handler(  pReq, pRes,  pValidArgs, fmtSQL1 ) {
       pRes.Handler    = `_${ CCase( aEntities ) }_getSelect_Handler`                           // .(30627.02.1)
       var  aRoute     = `/${ aEntities }?action=select`
//     pRes.SendNoData =  true
                                logIP(   pReq, pDB, `GET  Route, '${aRoute}'` )
                                sayMsg(  pReq, aMethod, aRoute )

       var  pArgs      =        chkArgs( pReq, pRes,  pValidArgs );   if (!pArgs ) { return }
       var  aSQL       =        chkSQL(  fmtSQL, pArgs )
       var  mRecs      =  await getData( pDB,   aSQL, aRoute, pRes ); if (pDB.Err) { return }   // .(30622.03.2)
                                sndRecs( mRecs, aSQL, aRoute, pRes )                            // .(30627.02.2)
                                sayMsg( 'End' )

            }   // eof _Agencies_getSelect_Handler
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+
          }   // eof _Agencies_getRoutes_Handler
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+
         }; // eof _Agency_getRoutes
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+


//========  ===========================================  ============================================================

this.init = function( pApp, bQuiet_, aAPI ) {                                                   // .(30628.01.3).(30613.01.13).(30412.02.14)

      var { aAPI_Host_: aAPI_Host1, bQuiet_: bQuiet } = init( pApp, bQuiet_, aAPI );            // .(30615.01.5 RAM Set pDB later).(30412.02.15 RAM Override aAPI_Host here)
//          aAPI_Host = aAPI_Host_; bQuiet = bQuiet_                                            //#.(30628.01.4 RAM and must use underlined vars to reset globals
            aAPI_Host = aAPI_Host1; bQuiet = bQuiet_                                            // .(30628.01.4 RAM Sometimes, exported aAPI_Host_ is undefined here, so use aAPI_Host1)

         }; // eof init                                                                         // .(30628.01.5)
//--------  ------------------  =  --------------------------------- ------------------

this.start= function( pApp, nPort, aTest ) {                                                    // .(30619.02.3).(30408.02.1 RAM Override aAPI_Host).(30412.02.16 RAM Not here)

       var  aEntities  =  this.Entities                                                         // .(30619.01.6)
       var  aTestRte   =  aTest ? `${aEntities}/${ aTest.replace( /^\//, '' ) }` : ''           // .(30619.01.7)

//          aAPI_Host = this.API_HOST                                                           //#.(30619.01.8)
//          aAPI_Host = aAPI ? `/${ aAPI.replace( /^\//, '' ) }` : aAPI_Host                    //#.(30619.01.8 RAM aAPI_Host is defined in process.env).(30412.02.17).(30408.02.2)

//          start(    pApp, nPort, aAPI_Host )                                                  // .(30412.02.18)
            start(    pApp, nPort, aTestRte  )                                                  // .(30619.01.9)

         }; // eof start
//  ------  ----  ---  =  ------|  -------------------------------- ------------------- ------------------+


//========  ===========================================  ============================================================
     }; // eoc _Entity_Server
//==============================+========================================================================== #  ===============================  #

//  export { _Entity_Server }
    export default _Entity_Server

