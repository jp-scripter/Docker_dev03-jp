/*\
##=========+====================+================================================+
##RD       Countries_Server.mjs | IODD Server script
##RFILE    +====================+=======+===============+======+=================+
##FD Countries_Server_u2.02.mjs |   2925|  3/12/23 12:08|    65| u2.05`30312.1200
##DESC     .--------------------+-------+---------------+------+-----------------+
#           This Javascript file sets up and handles the ExpressJS Server routes
#           by call the appropriate SQL statements with approriate arguments
##LIC      .--------------------+----------------------------------------------+
#           Copyright (c) 2023 8020Data-formR * Released under
#           MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#           IODD                | Main Class of Express routes
#             Root_getRoute     |
#             Countries_getRoutes  |
#             Countries_postRoutes |
#             init              |
#             start             |
##CHGS     .--------------------+----------------------------------------------+
# .(30607.01  6/07/23 RAM 12:00p| Copied from IODD_Server_u1.08.mjs
# .(30607.02  6/07/23 RAM  1:00p| Change Assets folder name
# .(30608.03  6/07/23 RAM  4:30p| Bump version: formr_server-fns_u1.07.mjs

##PRGM     +====================+===============================================+
##ID                            |
##SRCE =========================+========================================================================== #  ===============================  #
#*/
//  ----------------------------|  -------------------------------- ------------------- ------------------+ --------------------------

    import   express from  'express';

    import { chkArgs, sndHTML, getData, sndRecs, sndFile       } from '../Assets/MJSs/formr_server-fns_u1.07.mjs';  // .(30608.03.1 RAM Bump version).(30607.02.1)
    import { init, start, setRoute, sayMsg, sndErr             } from '../Assets/MJSs/formr_server-fns_u1.07.mjs';
    import { putData, getStyles,  sndJSON,  traceR             } from '../Assets/MJSs/formr_server-fns_u1.07.mjs';
    import { chkSQL,  fmtFld4SQL, logIP,  __appDir,  __dirname } from '../Assets/MJSs/formr_server-fns_u1.07.mjs';
//
//  ------  ---- ----- =  ------|  -------------------------------- ------------------- ------------------+

      var  __filename  =  import.meta.url.replace( /^.+\//, "" )                        // .(30607.01.1 Add __filename)

        if (process.argv[1].replace( /.*[\\/]/, '' ).match( __filename )) {             // .(30607.01.2)

       var  bQuiet //  =  true        // Override .env Quiet = {true|false}
       var  nPort      =  50381       // Override .env Server_Port
       var  aAPI   //  = 'api50381'   // Override .env API_URL

       var  pServer    =  new FRApps_Server
            pServer.init(  bQuiet, aAPI )
            pServer.setRoutes( )
            pServer.start( nPort )
            }
//  ------  ---- ----- =  ------|  -------------------------------- ------------------- ------------------+


//========  =============================================================================================== #  ===============================  #

  function  FRApps_Server( ) {

       var  pApp       =  express()

       var  pDB, aAPI_Host
       var  pDB_Config = { }

//  ------  ---- ----- =  ------|  -------------------------------- -------------------

this.setRoutes = function( bQuiet ) {                                                   // .(30406.02.3 RAM Beg Write function)

            this.Root_getRoute( )
//          this.Table_getRoute( )

            this.Countries_getRoutes( )
            this.Countries_postRoutes( )

         }; // eof setRoutes                                                            // .(30406.02.3 End)
//--------  ------------------  =  --------------------------------- ------------------


//========  ===========================================  ============================================================

this.Table_getRoute = function( ) {

       var  aMethod   = 'get'
       var  aRoute    = '/table'

            pValidArgs=  pValidArgs ? pValidArgs :
                          {  id:      /[0-9]+/
                          ,  letters: /([a-z],)*[a-z]/
                             }
//          ---------------------------------------------------

            setRoute( pApp, aMethod, aRoute, JSON_getRoute_Handler, pValidArgs, fmtSQL )

//          ---------------------------------------------------

  function  fmtSQL( pArgs ) {
       var  nRecs     =  pArgs.recs || 999
       var  nID       =  pArgs.id   || -1

        if (nID) {  // --------------------------------
       var  aSQL      = `
          SELECT  countries.*
            FROM  countries
           WHERE  countries.cid = ${ nID }
        ORDER BY  Name `
        } else {
       var  aSQL      = `
          SELECT (@nRow:=@nRow + 1) AS RNo, countries.*
            FROM  countries
               , (SELECT @nRow:=0) AS T
           WHERE  @nRow <= ${nRecs}
        ORDER BY  Id `
        }
    return  aSQL
            };  // eof fmtSQL
//     ---  ---------------------------------------------------
         }; // eof Table_getRoute
//--------  ---- ----- =  ------|  -------------------------------- -------------------


//========  ===========================================  ============================================================

this.Root_getRoute  = function( aRoute_, pValidArgs ) {

       var  aMethod             =  'get'
       var  aRoute              =  '/'

            aRoute              =   aRoute_    ? aRoute_ : aRoute
            pValidArgs          =   pValidArgs ? pValidArgs : { }
//          ------------------  =  ---------------------------------

       pApp.get( `${aAPI_Host}${aRoute}`, Root_getRoute_Handler )

                               sayMsg(  aMethod,  `${aAPI_Host}${ aRoute.substring( aAPI_Host ? 1 : 0 ) }`) // .(30414.02.1 RAM Add ${aAPI_Host})

//          ------------------  =  ---------------------------------

//          function  Root_getRoute_Handler( aMethod, pReq, pRes, aRoute, pValidArgs ) { .. }
     async  function  Root_getRoute_Handler( pReq, pRes ) {

       var  aRootRoute = aRoute.substring( aAPI_Host ? 1 : 0 )

                               logIP(   pReq, pDB, `GET  Route, '/'` )
                               sayMsg(  pReq, aMethod, aRootRoute )

       var  pArgs      =       chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }
       var  aHTML      =       fmtHTML( pArgs.name || '' )
                               sndHTML( pRes, aHTML, `${aRootRoute}${pReq.args}`)
                               sayMsg( 'Done',          "Root_getRoute_Handler" )

            } // eof Root_getRoute_Handler
//          ------------------  =  ---------------------------------

  function  fmtHTML( aName ) {                                                                              // .(30405.03.1 Beg RAM Add ${aAPI_Host} to URLs)
       var  aHTML = `
            Welcome ${aName} to FRApps MySQL Express Server API (v2-01.30607.1200).<br>
            Use any of the following APIs:<br><br>
            <div style="margin-left:40px; font-size:18px; line-height: 25px;">

              <a href="${aAPI_Host}/countries?id=90"                  >/countries?id=90</a><br>

              <form ${ fmtGetForm(  'Insert',   '',   "NewCo1", 200, 'countries' ) }</form>
              <form ${ fmtGetForm(  'Select',  'USA', "",       200, 'countries' ) }</form>
              <form ${ fmtGetForm(  'Update',  'USA', "NewCo2", 200, 'countries' ) }</form>
              <form ${ fmtGetForm(  'Delete',  'USA', "",       200, 'countries' ) }</form>

              <form ${ fmtPostForm( 'Insert',   '',   "NewCo1", 200, 'countries' ) }</form>
              <form ${ fmtPostForm( 'Update',  'USA', "NewCo2", 200, 'countries' ) }</form>

            </div> `;

    return  aHTML
            }; // eof fmtRoot
//     ---  ------------------  =  ---------------------------------

  function  fmtGetForm(  aAction, aCode, aValue, nWdt, aRoute ) {
       var  aHTML = ` method="GET" action="${aAPI_Host}/${aRoute}"                 style="margin-bottom: -5px;">
              /${aRoute}` +
                 `?name    =<input type="text"   name="name"   value=" ${aValue}"  style="padding: 0px;  width: ${nWdt}px" />
                        mid=<input type="text"   name="code"   value=" ${aCode}"   style="padding: 0px;  width: 30px" />
                            <input type="submit"   id="form1"  value= "${aAction}" style="padding: 0px;  width: 56px" />
            `
    return  aHTML
            }; // eof fmtGetForm2                                                                              // .(30511.01.5 End)
//     ---  ------------------  =  ---------------------------------

  function  fmtPostForm( aAction, aCode, aValue, nWdt, aRoute ) {
       var  aHTML = ` method="POST" action="${aAPI_Host}/${aRoute}"                style="margin-bottom: -5px;">
              /${aRoute}` +
                 `?name    =<input type="text"   name="name"   value=" ${aValue}"  style="padding: 0px;  width: ${nWdt}px" />
                        mid=<input type="text"   name="code"   value=" ${aCode}"   style="padding: 0px;  width: 30px" />
                            <input type="submit"   id="form2"  value= "${aAction}" style="padding: 0px;  width: 56px" />
            `
    return  aHTML
            }; // eof fmtForm2                                                                              // .(30511.01.5 End)
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------
         }; // eof Root_getRoute
//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------


//========  ===========================================  ============================================================

this.Countries_getRoutes = function( ) {

       var  pInsertArgs         = { name:   /[a-zA-Z][a-zA-Z0-9_]+/
                                    }

       var  pSelectArgs         = { code:   /[a-zA-Z0-9]{0,3}/
                                  , rec1:   /[0-9]+/
                                  , recs:   /[0-9]+/
                                  , name:   /[a-zA-Z]*[a-zA-Z0-9_]*/
                                    }

       var  pUpdateArgs         = { id:     /[0-9]+/
                                  , name:   /[a-zA-Z][a-zA-Z0-9_]+/
                                    }

       var  pDeleteArgs         = { id:     /[0-9]+/
                                  , name:   /[a-zA-Z][a-zA-Z0-9_]+/
                                    }
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

  function  fmtSelectSQL( pArgs ) {

       var  aSQL      = `
          SELECT  country.*
            FROM  country
           WHERE  Name like '${ pArgs.name || '' }%'
        ORDER BY  Name `

        if (pArgs.code) {
       var  aSQL      = `
          SELECT  country.*
            FROM  country
           WHERE  country.code Like '${ pArgs.code.toUpperCase() }%'
        ORDER BY  Name `
            }

        if (pArgs.recs) {
       var  aSQL      = `
          SELECT (@nRow:=@nRow + 1) AS RNo, countries.*
            FROM  country
               , (SELECT @nRow:=0) AS T
           WHERE  @nRow >= ${ (pArgs.rec1 || 1) }
             AND  @nRow <  ${ (pArgs.rec1 || 1) + pArgs.recs }
        ORDER BY  Name `
            }

    return  aSQL
            };  // eof fmtSelectSQL
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

            setRoute( pApp, 'get', '/countries', Countries_getRoute_Handler )

//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function    Countries_getRoute_Handler(   pReq, pRes ) {

       var  pAction  =  chkArgs( pReq, pRes, { action: /insert|select|update|delete/i } ); // if (!pAction) { return }
       var  aAction  =  pAction && pAction.action ? pAction.action.toLowerCase() : 'select'

    switch( aAction ) {
        case 'insert':  Countries_getInsert_Handler(  pReq, pRes, pInsertArgs, fmtInsertSQL ); break;
        case 'select':  Countries_getSelect_Handler(  pReq, pRes, pSelectArgs, fmtSelectSQL ); break;
        case 'update':  Countries_getUpdate_Handler(  pReq, pRes, pUpdateArgs, fmtUpdateSQL ); break;
        case 'delete':  Countries_getInsert_Handler(  pReq, pRes, pInsertArgs, fmtDeleteSQL ); break;
              }
            }    // eof Countries_postRoute_Handler
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function    Countries_getInsert_Handler(  pReq, pRes, pValidArgs, fmtSQL ) {
       var  aHandler = 'Countries_getInsert_Handler'
       var  pArgs    =  chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }

            }    // eof Countries_getInsert_Handler
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function    Countries_getSelect_Handler(  pReq, pRes, pValidArgs, fmtSQL ) {
       var  aHandler = 'Countries_getSelect_Handler', aRoute = 'countries?action=select', aMethod = 'get'

                               logIP(   pReq, pDB, `GET  Route, '${aRoute}'` )
                               sayMsg(  pReq, aMethod, aRoute )

       var  pArgs      =       chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }
//     var  aSQL      =  await fmtSQL(  pArgs )
       var  aSQL       =       chkSQL(  fmtSQL, pArgs )
       var  mRecs      = await getData( pDB,   aSQL, aRoute, pRes ); if (mRecs[0] == 'error') { sndErr( pRes, mRecs[1] ); return }
                               sndRecs( mRecs, aSQL, aRoute, pRes, aHandler )
                               sayMsg( 'End' )

            }    // eof Countries_getSelect_Handler
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function    Countries_getUpdate_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSQL ) {
       var  aHandler = 'Countries_getUpdate_Handler'
       var  pArgs    =  chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }

            }    // eof Countries_getUpdate_Handler
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function    Countries_getDelete_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSQL ) {
       var  aHandler = 'Countries_getDelete_Handler'
       var  pArgs    =  chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }

            }    // eof Countries_getDelete_Handler
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

         }; // eof Countries_getRoutes
//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------


//========  ===========================================  ============================================================

this.Countries_postRoutes = function( ) {

       var  pInsertArgs   = { name:   /[a-zA-Z][a-zA-Z0-9_]+/
                              }

       var  pUpdateArgs   = { id:   [ /[0-9]+/,               'required' ]
                            , name:   /[a-zA-Z][a-zA-Z0-9_]+/
                              }
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

  function  fmtUpdateSQL( pArgs ) {
       var  nRecs     =  pArgs.recs || 999
       var  nID       =  pArgs.id   || -1

        if (nID) {  // --------------------------------
       var  aSQL      = `
          SELECT  countries.*
            FROM  countries
           WHERE  countries.cid = ${ nID }
        ORDER BY  Name `
        } else {
       var  aSQL      = `
          SELECT (@nRow:=@nRow + 1) AS RNo, countries.*
            FROM  countries
               , (SELECT @nRow:=0) AS T
           WHERE  @nRow <= ${nRecs}
        ORDER BY  Id `
        }
    return  aSQL
            };  // eof fmtSQL
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

            setRoute( pApp, 'post', '/countries', Countries_postRoute_Handler )

//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function    Countries_postRoute_Handler(   pReq, pRes ) {

       var  pAction  =  chkArgs( pReq, pRes, { action: /insert|update/ } ); if (!pAction) { return }
       var  aAction  =  pAction && pAction.action ? pAction.action : 'update'

    switch( aAction ) {
        case 'insert':  Countries_postInsert_Handler( pReq, pRes, pInsertArgs, fmtInsertSQL ); break;
        case 'update':  Countries_postUpdate_Handler( pReq, pRes, pUpdateArgs, fmtUpdateSQL ); break;
              }
            }    // eof Countries_postRoute_Handler
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function    Countries_postInsert_Handler( pReq, pRes, pValidArgs, fmtSQL   ) {
       var  aHandler = 'Countries_postInsert_Handler'
       var  pArgs    =  chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }

            }    // eof Countries_postInsert_Handler
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function    Countries_postUpdate_Handler( pReq, pRes, pValidArgs, fmtSQL   ) {
       var  aHandler = 'Countries_postUpdate_Handler'
       var  pArgs    =  chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }

            }    // eof Countries_postUpdate_Handler
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------
         }; // eof Countries_postRoutes
//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------


//========  ===========================================  ============================================================

     async  function  JSON_getRoute_Handler( aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL ) {

                               logIP(   pReq, pDB, `GET  Route, '/${aRoute}'` )         // .(30526.02.15 RAM Use logIP)
                               sayMsg(  pReq, aMethod, aRoute )

       var  pArgs     =        chkArgs( pReq, pRes, pValidArgs );    if (!pArgs) { return }                                        // .(30511.02.8 RAM Error may be sent already)
       var  aSQL      =        chkSQL(  fmtSQL, pArgs )                                                                            // .(30403.06.8)
//     var  mRecs     =  await getData( pDB,   aSQL               ); if (mRecs[0] == 'error') { sndErr( pRes, mRecs[1] ); return } // .(30407.03.10)
//     var  mRecs     =  await getData( pDB,   aSQL, aRoute, pRes ); if (mRecs[0] == 'error') { sndErr( pRes, mRecs[1] ); return } // .(30407.03.11)
       var  mRecs     =  await getData( pDB,   aSQL, aRoute, pRes ); if (!mRecs) { return }                                        // .(30511.02.9 RAM Error may be sent already).(30407.03.12)
                               sndRecs( mRecs, aSQL, aRoute, pRes, "JSON_getRoute_Handler" )                                       // .(30407.03.13 RAM Moved pRes arg)

                               sayMsg( 'End' )                                          // .(30528.05.13)

         }; // eof JSON_getRoute_Handler
//--------  ------------------  =  --------------------------------- ------------------

this.init = function( bQuiet_, aAPI ) {                                                 // .(30412.02.14)

      var { pDB_,     aAPI_Host_, bQuiet_ } = init( pApp, pDB_Config, bQuiet_, aAPI );  // .(30412.02.15 RAM Override aAPI_Host here)
            pDB    =  pDB_; aAPI_Host = aAPI_Host_                                      // and must use underlined vars to reset globals

         }; // eof init
//--------  ------------------  =  --------------------------------- ------------------

this.start  = function( nPort, aAPI ) {                                                // .(30408.02.1 RAM Override aAPI_Host).(30412.02.16 RAM Not here)

            aAPI_Host = aAPI ? `/${ aAPI.replace( /^\//, '' ) }` : aAPI_Host           // .(30408.02.2).(30412.02.17)
            start( pApp, nPort, aAPI_Host )                                            // .(30412.02.18)

         }; // eof start
//--------  ------------------  =  --------------------------------- ------------------

//========  ===========================================  ============================================================
     }; // eoc FRApps_Server
//==============================+========================================================================== #  ===============================  #

    export { FRApps_Server }
