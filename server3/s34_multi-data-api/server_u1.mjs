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
# .(30412.02  4/12/23 RAM  4:10p|  Move aAPI override to init()
# .(30607.01  6/07/23 RAM 12:00p| Copied from IODD_Server_u1.08.mjs
# .(30607.02  6/07/23 RAM  1:00p| Change Assets folder name
# .(30608.03  6/07/23 RAM  4:30p| Bump version: formr_server-fns_u1.07.mjs
# .(30611.05  6/11/23 RAM  7:15a| Should init() be an async function
# .(30611.06  6/11/23 RAM  7:30a| sayMsg Handler Name with fncName
# .(30613.01  6/13/23 RAM  8:15a| Call Entity script from setMainRoutes
# .(30615.01  6/15/23 RAM  6:50a| Don't set pDB in MainAPI_Server


##PRGM     +====================+===============================================+
##ID                            |
##SRCE =========================+========================================================================== #  ===============================  #
#*/
//  ----------------------------|  -------------------------------- ------------------- ------------------+ --------------------------

   import   express       from    'express';
// import { dbConnect }   from    './assets/MJSs/db.connect_u4.01.mjs';

// import { getEnv    }   from    './assets/MJSs/formr_utility-fns_u1.06.mjs';

   import { chkArgs, getData, sndHTML, sndRecs, sndFile        } from './assets/MJSs/formr_server-fns_u1.07.mjs';  // .(30608.03.1 RAM Bump version).(30607.02.1)
   import { init, start, setRoute, logIP, sayMsg, fncName      } from './assets/MJSs/formr_server-fns_u1.07.mjs';  // .(30611.06.2)
// import { putData, getStyles, traceR, __appDir, __dirname    } from './assets/MJSs/formr_server-fns_u1.07.mjs';
// import { chkSQL,  fmtFld4SQL                                } from './assets/MJSs/formr_server-fns_u1.07.mjs';

   import  pAgencies      from './api/Agencies/index.mjs'
   import  pCountries     from './api/Countries/index.mjs'
// import  pCities        from './api/Cities/index.mjs'
   
//  ------  ---- ----- =  ------|  -------------------------------- ------------------- ------------------+

      var __filename   =  import.meta.url.replace( /^.+\//, "" )                        // .(30607.01.1 Add __filename)

        if (process.argv[1].replace( /.*[\\/]/, '' ).match( __filename )) {             // .(30607.01.2)

       var  bQuiet //  =  true        // Override .env Quiet = {true|false}
       var  nPort      =  50380       // Override .env Server_Port
       var  aAPI   //  = 'api50381'   // Override .env API_URL

       var  pMain_Server = new MainAPI_Server                                           // .(30611.03.1 RAM Define this.methods in "class")
//   await  pMain_Server.init( bQuiet, aAPI )                                           //#.(30611.05.1 RAM Add async again )
//          pMain_Server.init( bQuiet, aAPI )                                           //#.(30611.05.5).(30611.05.1 RAM But it didn't wait)

            pMain_Server.setMainRoutes( )                                               // .(30615.01.1 RAM Change name to Main) 

            pMain_Server.start( nPort )
            }
//  ------  ---- ----- =  ------|  -------------------------------- ------------------- ------------------+






//========  =============================================================================================== #  ===============================  #

  function  MainAPI_Server( ) {

       var  pApp                =  express()
       var  aAPI_Host
//     var  pDB, pDB_Config     = { }                                                   // .(30615.01.2 RAM No DB at this level)
       var  pMain_Server        = this 

//--------  ------------------  =  --------------------------------- ------------------

this.setMainRoutes = function( bQuiet ) {                                               // .(30615.01.3 RAM Change name. Was setRoutes)                                                

            pMain_Server.init(    pApp, bQuiet, aAPI )                                  // .(30613.01.12 RAM Pass pApp).(30611.05.2 RAM Do init() here)
            pMain_Server._Root_getRoute( 'agencies, world' )
                                                                                        // .(30613.01.13 RAM Call Entity scripts from setMainRoutes)
            pAgencies.setRoutes(  pApp, aAPI_Host )                                     // .(30615.01.4 RAM Set pDB in Entity.setRoutes)
   
            pCountries.setRoutes( pApp, aAPI_Host ) 
//          pCities.setRoutes(    pApp, aAPI_Host ) 

//          this._Entities_getRoutes( )
//          this._Entities_postRoutes( )

         }; // eof setRoutes
//--------  ------------------  =  --------------------------------- ------------------


//========  ===========================================  ============================================================

this._Root_getRoute  = function( aEntities ) {

//     var  aEntities           =  'agencies,world'
       var  aMethod             =  'get'
       var  aRoute              =  '/'
       var  aRootRoute          =   aRoute.substring( aAPI_Host ? 1 : 0 )

       var  pValidArgs          =  
             {  Entities        :  aEntities
                }
//          ------------------  =  ---------------------------------

       pApp.get( `${aAPI_Host}${aRoute}`, _Root_getRoute_Handler )

                                sayMsg(  aMethod,  `${aAPI_Host}${aRootRoute}`)

//          ------------------  =  ---------------------------------

     async  function  _Root_getRoute_Handler( pReq, pRes ) {

                                logIP(   pReq, pDB, `GET  Route, '${aRoute}'` )
                                sayMsg(  pReq, aMethod, aRoute )

//     var  pArgs      =        chkArgs( pReq, pRes, pValidArgs ); if (!pArgs ) { return }
       var  pArgs      =        pValidArgs

       var  aHTML      =        fmtHTML( pArgs )

                                sndHTML( pRes, aHTML, `${aRootRoute}${pReq.args}`)
                                sayMsg( 'Done',           fncName(2) )                  // .(30611.06.3 RAM Get Handler name)

            } // eof _Root_getRoute_Handler
//          ------------------  =  ---------------------------------

  function  fmtHTML( pArgs ) {
       var  aEntities  =        pArgs.Entities

       var  aHTML = `
            Welcome to FRApps MySQL Express Server APIs (v2-06).<br>
            Use any of the following APIs:<br><br>
            <div style="margin-left:40px; font-size:16px; line-height: 25px; font-family:arial";>

              <a href="${aAPI_Host}/agencies/test">/agencies/test</a><br>  
              <a href="${aAPI_Host}/world/test">/world/test</a><br>  

            </div> `;
    return  aHTML
            }; // eof fmtRoot
//     ---  ------------------  =  ---------------------------------
//   -----  ------------------  =  --------------------  ----------------------------  ------------------, ----------, -----------------------
         }; // eof _Root_getRoute
//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------


//========  ===========================================  ============================================================

//is.init = function(       bQuiet_, aAPI ) {                                           //#.(30412.02.14).(30613.01.13)
this.init = function( pApp, bQuiet_, aAPI ) {                                           // .(30613.01.13).(30412.02.14)

//    var { pDB_, aAPI_Host_, bQuiet_ } // init( pApp, pDB_Config, bQuiet_, aAPI );     //#.(30615.01.5).(30611.05.2 RAM Must be on same line. Nope)
//        = init( pApp, pDB_Config, bQuiet_, aAPI );                                    //#.(30615.01.5).(30611.05.2).(30412.02.15 RAM Override aAPI_Host here)

      var { aAPI_Host_, bQuiet_ } = init( pApp, bQuiet_, aAPI );                        // .(30615.01.5 RAM Set pDB later).(30412.02.15 RAM Override aAPI_Host here)

            aAPI_Host = aAPI_Host_ // pDB    =  pDB_;                                   // .(30615.01.6).(30412.02.16 and must use underlined vars to reset globals)
         }; // eof init
//--------  ------------------  =  --------------------------------- ------------------

this.start= function( nPort,   aAPI ) {                                                 // .(30408.02.1 RAM Override aAPI_Host).(30412.02.16 RAM Not here)

            aAPI_Host = aAPI ? `/${ aAPI.replace( /^\//, '' ) }` : aAPI_Host            // .(30408.02.2).(30412.02.17)
            start(    pApp, nPort, aAPI_Host )                                          // .(30412.02.18)

         }; // eof start
//--------  ------------------  =  --------------------------------- ------------------
//========  ===========================================  ============================================================
     }; // eoc Server
//==============================+========================================================================== #  ===============================  #

//  export { Server }
