/*\
##=========+====================+================================================+
##RD        IODD_Server.mjs     | IODD Server script
##RFILE    +====================+=======+===============+======+=================+
##FD      IODD_Server_u1.02.mjs |   2925|  3/12/23 12:08|    65| u2.05`30312.1200
##FD      IODD-Server_u1.03.mjs |  16788|  3/31/23 22:46|   378| u1-03`30331.2246
##FD      IODD-Server_u1.05.mjs |  24655|  4/03/23 21:00|   510| u1-05`30403.2100
##FD      IODD-Server_u1.06.mjs |  34475|  4/12/23 16:31|   598| u1-06`30412.1630
##FD      IODD-Server_u1.06.mjs |  35577|  4/25/23 17:04|   598| u1-06`30425.1704
##FD      IODD-Server_u1.06.mjs |  35736|  4/28/23 16:21|   598| u1-06`30412.1621
##FD      IODD-Server_u1.06.mjs |  36039|  4/28/23 23:20|   618| u1-06`30428.2320
##FD      IODD-Server_u1.08.mjs |  50025|  5/11/23 16:00|   823| u1-08`30511.1600
##FD      IODD-Server_u1.08.mjs |  66923|  5/24/23 19:30|  1065| u1-08`30524.1930
##FD      IODD-Server_u1.08.mjs |  75467|  5/25/23 16:08|  1160| u1-08`30525.1608
##FD      IODD-Server_u1.08.mjs |  76787|  5/25/23 21:30|  1171| u1-08`30525.2130
##FD      IODD-Server_u1.08.mjs |  79131|  5/27/23 16:10|  1200| u1-08`30527.1610
##FD      IODD-Server_u1.08.mjs |  81217|  5/29/23 12:23|  1218| u1-08`30529.1223
##DESC     .--------------------+-------+---------------+------+-----------------+
#           This Javascript file modifies the Login Button
##LIC      .--------------------+----------------------------------------------+
#           Copyright (c) 2023 8020Data-formR * Released under
#           MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#           IODD                | Main Class of Express routes
#             getTable          |
#             Root_getRoute     |
#             Login_getRoute    |
#             Login_postRoute   |
#             Meetings_getRoute |
#             Members_getRoute  |
#             Member_postRoute  |                                                       // .(30510.03.1 RAM Add Member_postRoute)
#             MembersBios_getRoute     |
#             MembersProjects_getRoute |
#             Project_getRoute  |                                                       // .(30525.04.1 RAM Add Project_getRoute)
#             Projects_getRoute |
#             Project_postRoute |                                                       // .(30516.01.1 RJS Add Project_postRoute)
#             ProjectsList_getRoute  |                                                  // .(30511.03.1 RAM Add ProjectsList_getRoute)
#             ProjectCollaborators_getRoute  |
#             ProjectCollaborators_postRoute |                                          // .(30510.05,1 RAN Add ProjectCollaborators_postRoute)
#             ProjectBanner_getRoute |                                                  // .(30521.01.1 RJS Add ProjectBanner_getRoute)
#             User_getRoute     |
#             User_postRoute    |                                                       // .(30510.02.1 RAM Finish User_postRoute)
#             Users_getRoute    |
#             init              |
#             start             |
#          onRoute              |
#    //    onGetRoute           |                                                       //#.(30327.01.1 RAM)
##CHGS     .--------------------+----------------------------------------------+
# .(30221.01  2/21/23 RAM  3:44p| Created
# .(30310.01  3/10/23 RAM  1:00p|
# .(30320.01  3/20/23 RAM 11:56a|
# .(30320.01  3/20/23 RAM 12:33p|
# .(30322.01  3/22/23 RAM 10:56a|
# .(30323.01  3/23/23 RAM 10:21a|
# .(30327.01  3/27/23 RAM 11:00a|
# .(30328.03  3/28/23 RAM  9:18p|  Move setRoute to server-fns.mjs
# .(30331.01  3/31/23 RAM  8:09p|  Display onRoute name
# .(30402.04  4/02/23 RAM  4:37p|  Add getStyles to this.getLogin
# .(30403.01  4/03/23 RAM  7:30a|  Use shared function fmtHTML
# .(30403.02  4/03/23 RAM  8:52a|  Add Login_postRoute
# .(30403.04  4/03/23 RAM  3:10p|  Add sndFile
# .(30403.05  4/03/23 RAM  7:36p|  Add putData
# .(30403.06  4/03/23 RAM  8:46p|  Add chkSQL
# .(30404.01  4/04/23 RAM  1:20p|  Fix aDatasetName / aRecords being plural
# .(30404.02  4/04/23 RAM  3:24p|  Add Login_getRoute and Login_GetForm
# .(30404.03  4/04/23 RAM  2:00p|  Return JSON for /login routes
# .(30405.03  4/05/23 RAM  8:30a|  Add ${aAPI_Host} to URLs)
# .(30405.04  4/05/23 RAM  2:10p|  Change login_view2 query
# .(30406.01  4/06/23 RAM  9:15a|  Insert into login_log

# .(30406.02  4/06/23 RAM  6:20p|  Add setRoutes into this script
# .(30406.03  4/06/23 RAM  9:10p|  Add IPAddress4
# .(30412.02  4/12/23 RAM  4:10p|  Move aAPI override to init()
# .(30413.01  4/13/23 RAM  4:40p|  Parse SQL with SQLn:
# .(30417.02  4/17/23 RAM 10:20a|  Add bLog_HTML and bLog_Styles
# .(30428.03  4/28/23 RAM 11:20p|  Missing pReq.ip
# .(30510.02  5/10/23 RAM  9:00p|  Finish User_postRoute
# .(30510.03  5/10/23 RAM  9:15p|  Add Members_postRoute
# .(30510.05  5/11/23 RAM  8:00a|  Add ProjectCollaborators_postRoute
# .(30511.01  5/11/23 RAM  8:15a|  Write fmtForm fns for Root_getRoute
# .(30511.02  5/11/23 RAM  3:45p|  Prevent crash if SELECT nothing if no args
# .(30511.03  5/11/23 RAM  4:00p|  Add ProjectsList_getRoute
# .(30515.03  5/11/23 RAM  7:30a|  Finish Members_postRoute
# .(30515.04  5/15/23 RAM  8:00a|  Finish ProjectCollaborators_postRoute
# .(30515.08  5/15/23 RAM  9:30a|  Double up single quotes, if any
# .(30516.01  5/16/23 RJS  8:00a|  Add Project_postRoute
# .(30521.01  5/21/23 RJS  3:00p|  Add ProjectBanner_getRoute
# .(30524.01  5/24/23 RAM  7:30a|  Add insert & delete project_collaborators
# .(30525.02  5/25/23 RAM  9:30a|  Finish project_collaborators
# .(30525.03  5/25/23 RAM  9:30a|  Change ids to mid, pid, mpid, uid, etc.
# .(30525.04  5/25/23 RAM  2:15p|  Add Project_getRoute
# .(30525.05  5/25/23 RAM  2:30p|  Keep members?id=, rather than mid=
# .(30525.06  5/25/23 RAM  3:15p|  Use userid, not username in URL
# .(30525.07  5/25/23 RAM  4:00p|  ToDo: Allow pArgs to be anycase
# .(30508.08  5/25/23 RAM  4:08p|  ToDo: Use any id in SQL for plural route
# .(30525.06  5/25/23 RAM  9:00p|  But still use username if submitted
# .(30525.03  5/25/23 RAM  9:30p|  Gotta still accept memberno, not mid
# .(30526.02  5/26/12 RAM  1:35p|  Use getIPAddr and logIP
# .(30527.02  5/27/12 RAM  4:10p|  Use fmtFld4SQL
# .(30528.03  5/28/12 RAM  2:00p|  Check for valid Email, Cleanup SQL
# .(30528.04  5/28/12 RAM  3:00p|  Add Abort to sayMsg, Forgot to sayMsg
# .(30528.05  5/28/12 RAM  6:00p|  Add say('Done', "handler") and sayMsg('End')
# .(30529.01  5/29/12 RAM 12:22p|  Fix spacing for saySQL on Error

##PRGM     +====================+===============================================+
##ID                            |
##SRCE =========================+===============================================+========================== #  ===============================  #
#*/
//  ----------------------------|  -------------------------------- ------------------- ------------------+ --------------------------

    import   express from  'express';

    import { chkArgs, sndHTML, getData, sndRecs, sndFile      } from './assets/mjs/formr_server-fns_u1.06.mjs';  // .(30403.04.3 RAM Add sndFile)
    import { init, start, setRoute, sayMsg, sndErr            } from './assets/mjs/formr_server-fns_u1.06.mjs';  // .(30327.01.1 RAM)
//  import { getHTML, getStyles,  getJSON,  indexObj, logIP   } from './assets/mjs/formr_server-fns_u1.06.mjs';  //#.(30402.02.4 RAM).(30402.04.5).(30526.02.4).(30527.02.1)
    import { putData, getStyles,  sndJSON,  traceR, __appDir  } from './assets/mjs/formr_server-fns_u1.06.mjs';  // .(30403.05.3 RAM Add putData).(30403.06.5 RAM Add chkSQL).(30404.03.1)# .(30412.02.4)
    import { chkSQL,  fmtFld4SQL, logIP,    getIPAddr         } from './assets/mjs/formr_server-fns_u1.06.mjs';  // .(30526.02.4 RAM Add logIP, getIPAddr).(30527.02.1 RAM Add fmtFld4SQL)
//
//  ------  ---- ----- =  ------|  -------------------------------- ------------------- ------------------+

        if (process.argv[1].replace( /.*[\\/]/, '' ).match( /IODD.*\.mjs/ )) {

       var  bQuiet //  =  true        // Override .env Quiet = {true|false}
       var  nPort      =  3012        // Override .env Server_Port
       var  aAPI   //  = 'api15'      // Override .env API_URL                          // .(30408.02.3)

       var  pIODD      =  new IODD                                                      // .(30406.02.1 Beg)
            pIODD.init(   bQuiet, aAPI )                                                // .(30412.02.11 RAM Override aAPI here)
            pIODD.setRoutes( )
//          pIODD.start(  nPort,  aAPI )                                                //#.(30406.02.1 End).(30408.02.4).(30412.02.12)
            pIODD.start(  nPort )                                                       // .(30406.02.1 End).(30408.02.4).(30412.02.12)
            }
//  ------  ---- ----- =  ------|  -------------------------------- ------------------- ------------------+
//==============================+==========================================================================

  function  IODD ( ) {

       var  pApp, pDB, aAPI_Host          // Doesn't work for bQuiet, because it is not used in this module
       var  pApp  =  express()                                                          // .(30406.02.2 RAM pApp is now local to IODD)

       var  pDB_Config= { }                                                             // .(30412.02.13 RAM Override it here??)

//  ------  ---- ----- =  ------|  -------------------------------- -------------------

this.setRoutes = function( bQuiet ) {                                                   // .(30406.02.3 RAM Beg Write function)

            this.Root_getRoute( '/' )
//          this.Table_getRoute()

            this.Login_getRoute( )
            this.Login_getForm( )                   // .(30404.02.1)
            this.Login_postRoute( )                 // .(30403.02.1)
//          this.Login_postForm( )                  // .(30403.02.1)

            this.Meetings_getRoute( )

            this.Member_postRoute( )                // .(30510.03.2)
            this.Members_getRoute( )
            this.MembersBios_getRoute( )
            this.MembersProjects_getRoute( )

            this.Project_getRoute( )                // .(30525.04.2)
            this.Projects_getRoute( )
            this.ProjectsList_getRoute( )           // .(30511.03.2)
            this.ProjectCollaborators_getRoute( )
            this.ProjectCollaborators_postRoute( )  // .(30510.05.2)
            this.ProjectBanner_getRoute()           // .(30521.01.2 RJS Robin added)

//          this.ProjectCollaboratorsLetters_getRoute( '/letters' )

            this.User_postRoute( )                  // .(30510.02.2)
            this.Users_getRoute( )                  // .(30510.02.3)
            this.User_getRoute( )                   // .(30510.02.4 RAM Change to this.user_getRoute)

         }; // eof setRoutes                                                            // .(30406.02.3 End)
//--------  ------------------  =  --------------------------------- ------------------

this.Table_getRoute = function( aGetRoute, pValidArgs ) {

       var  aMethod   = 'get'
       var  aRoute    = '/table'

            aGetRoute =  aGetRoute  ? aGetRoute  : aRoute
            pValidArgs=  pValidArgs ? pValidArgs :
                          {  id:      /[0-9]+/
                          ,  letters: /([a-z],)*[a-z]/
                             }
//          ---------------------------------------------------

            setRoute( pApp, aMethod, aGetRoute, JSON_getRoute_Handler, pValidArgs, fmtSQL )

//          ---------------------------------------------------

  function  fmtSQL( pArgs ) {
       var  nRecs     =  pArgs.recs || 999
       var  aLetters  =  pArgs.letters

        if (aLetters) {  // --------------------------------
       var  aSQL      = `
          SELECT  *
            FROM  table
           WHERE  substring( Name, 1, 1) in ( '${ aLetters.replace( /,/, "','" ) }' )
        ORDER BY  Name `
        } else {
       var  aSQL      = `
          SELECT (@nRow:=@nRow + 1) AS RNo, countries_view.*
            FROM  table
               , (SELECT @nRow:=0) AS T
           WHERE  @nRow <= ${nRecs}
        ORDER BY  Id `
        }
    return  aSQL
            };  // eof fmtSQL
//     ---  ---------------------------------------------------
         }; // eof Table_getRoute
//--------  ---- ----- =  ------|  -------------------------------- -------------------

this.Root_getRoute  = function( aRoute_,  pValidArgs ) {

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

       var  aRootRoute= aRoute.substring( aAPI_Host ? 1 : 0 )                                               // .(30414.02.2)

                               logIP(   pReq, pDB, `GET  Route, '/'` )                                      // .(30526.02.5 RAM Use logIP)
                               sayMsg(  pReq, aMethod, aRootRoute )

       var  pArgs      =       chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }
       var  aHTML      =       fmtHTML( pArgs.name || '' )
                               sndHTML( pRes, aHTML, `${aRootRoute}${pReq.args}`)                           // .(30528.05.2 RAM Remove Handler).(30331.01.1).(30414.02.3)
                               sayMsg( 'Done',         "Root_getRoute_Handler"   )                          // .(30528.05.3)

            } // eof Root_getRoute_Handler
//          ------------------  =  ---------------------------------

  function  fmtHTML( aName ) {                                                                              // .(30405.03.1 Beg RAM Add ${aAPI_Host} to URLs)
       var  aHTML = `
            Welcome ${aName} to IODD MySQL Express Server API (v1-06.30412.1630).<br>
            Use any of the following APIs:<br><br>
            <div style="margin-left:40px; font-size:18px; line-height: 25px;">

            <a href="${aAPI_Host}/login?uid=90"                      >/login?uid=90</a><br>                  <!-- .(30525.03.1 RAM Was: id) -->
            <a href="${aAPI_Host}/login_form?uid=90"                 >/login_form?uid=90</a><br>             <!-- .(30525.03.2 RAM Was: id) -->
<!--        <a href="${aAPI_Host}/login_form?form&uid=90"            >/login_form?form&uid=90</a><br> -->
<!--        <a href="${aAPI_Host}/login_form_post?userid=a.b@c&password=" >/login_form_post</a><br> -->      <!-- .(30525.06.1)
<!--        <a href="${aAPI_Host}/login_form"                        >/login_form?id=90</a><br> -->
            <form ${ fmtForm1( 'robin.mattern@gmail.com','email',200, 'login', 'login'        ) }</form>     <!-- .(30511.01.1) -->
            <a href="${aAPI_Host}/meetings"                          >/meetings</a><br>
            <a href="${aAPI_Host}/members"                           >/members</a><br>
            <a href="${aAPI_Host}/members?id=90"                     >/members?id=90 # Spcial case</a><br>   <!-- .(30525.05.1 RAM Uses id) -->
            <form ${ fmtForm2( '', 90, 'Update',                 200, 'member'                ) }</form>     <!-- .(30510.03.3 RAM Add Member_postRoute) -->
            <a href="${aAPI_Host}/members_bios"                      >/members_bios</a><br>
            <a href="${aAPI_Host}/members_projects"                  >/members_projects</a><br>
            <a href="${aAPI_Host}/projects"                          >/projects</a><br>
            <a href="${aAPI_Host}/project?pid=149"                   >/project?pid=149</a><br>               <!-- .(30525.03.3 RAM Was: id).(30525.04.3) -->
            <a href="${aAPI_Host}/projects_list?mid=90"              >/projects_list?mid=90</a><br>          <!-- .(30511.03.3 RAM Add GET projects_list).(30525.03.4 RAM Was: id) -->
            <a href="${aAPI_Host}/project_banner?pid=149"            >/project_banner?pid=149</a><br>        <!-- .(30521.01.3 RJS).(30525.03.5 RAM Was: id) -->
            <a href="${aAPI_Host}/project_collaborators?pid=149"     >/project_collaborators?pid=149</a><br> <!-- .(30525.03.6 RAM Was: id) -->
            <form ${ fmtForm5( 'Insert',  99, 90,             30, 30, 'project_collaborators' ) }</form>     <!-- .(30524.01.2 RAM Add Insert project_collaborators) -->
            <form ${ fmtForm4( 'Delete', 111,                     35, 'project_collaborators' ) }</form>     <!-- .(30524.01.1 RAM Add Delete project_collaborators) -->
            <a href="${aAPI_Host}/users"                             >/users</a><br>                         <!-- .(30328.03.1 Add Users) -->
            <a href="${aAPI_Host}/user?uid=7"                        >/user?uid=7</a><br>                    <!-- .(30405.03.1 End).(30525.03.7 RAM Was: id) -->
            <form ${ fmtForm3( 'new email', 'Add',               200, 'user'                  ) }</form>     <!-- .(30511.01.3).(30510.02.5 RAM Add POST User) -->
            </div> `;

    return  aHTML
            }; // eof fmtRoot
//     ---  ------------------  =  ---------------------------------

  function  fmtForm1( aValue, aDefault, nWdt, aRoute, aRouteName ) {                                        // .(30511.01.4 RAM Beg)
       var  aURL  =   aRouteName ? aRouteName : aRoute
       var  aHTML = ` method="POST" action="${aAPI_Host}/${aURL}"                     style="margin-bottom: -5px;">
              /${aRoute }` +
                   `?userid=<input type="text"   name=""         value=" ${aDefault}" style="padding: 0px;  width:${nWdt}px" />
                            <input type="hidden" name="userid"   value="${aValue}"    placeholder=" Email Address" >
                            <input type="hidden" name="password" value="iodd">
                            <input type="submit"   id="form1"    value="Submit"       style="padding: 0px;  width: 54px" />
            `
    return  aHTML
            }; // eof fmtForm1                                                                              // .(30511.01.4 End)
//     ---  ------------------  =  ---------------------------------

  function  fmtForm2( aValue, mid, aAction, nWdt, aRoute ) {                                                // .(30511.01.5 RAM Beg).(30515.03.1 RAM Add nId)
       var  aHTML = ` method="POST" action="${aAPI_Host}/${aRoute}"                   style="margin-bottom: -5px;">
              /${aRoute}` +
                 `?email=<input type="text"   name="email"    value=" ${aValue}"    style="padding: 0px;  width: ${nWdt}px" />
                        mid=<input type="text"   name="mid"      value=" ${mid}"       style="padding: 0px;  width: 30px" />
                            <input type="submit"   id="form2"    value="${aAction}"    style="padding: 0px;  width: 56px" />
            `
    return  aHTML
            }; // eof fmtForm2                                                                              // .(30511.01.5 End)
//     ---  ------------------  =  ---------------------------------

  function  fmtForm3( aValue, aAction, nWdt, aRoute ) {                                                     // .(30515.03.2 RAM Beg Add fmtForm3)
       var  aHTML = ` method="POST" action="${aAPI_Host}/${aRoute}"                 style="margin-bottom: -5px;">
              /${aRoute }` +
                  `?userid=<input type="text"   name="userid"   value=" ${aValue}"     style="padding: 0px;  width: ${nWdt}px" />
                           <input type="hidden" name="password" value="iodd">
                           <input type="submit"   id="form3"    value="${aAction}"       style="padding: 0px;  width: 38px" />
            `
    return  aHTML
            }; // eof fmtForm3                                                                              // .(30515.03.2 End)
//     ---  ------------------  =  ---------------------------------

  function  fmtForm4( aAction, mpid, nWdt, aRoute ) {                                                       // .(30524.01.3 RAM Beg Add fmtForm4)
       var  aURL  = `${aRoute}?action=${ aAction.toLowerCase().trim() }`
       var  aHTML = ` method="GET" action="${aAPI_Host}/${aURL}"                    style="margin-bottom: -5px;">
              /${ aURL  }` + `
                   &mpid=<input type="text"   name="mpid"     value=" ${mpid}"      style="padding: 0px;  width: ${nWdt}px;" />
                         <input type="hidden" name="action"   value="${aAction}"                                       />
                         <input type="submit"   id="form4"    value="${aAction}"    style="padding: 0px;  width: 53px" />
            `
     return aHTML
            }; // eof fmtForm4                                                                              // .(30524.01.3 End)
//     ---  ------------------  =  ---------------------------------

  function  fmtForm5( aAction, pid, mid, nWdt1, nWdt2, aRoute ) {                                                        // .(30524.01.4 RAM Beg Add fmtForm5)
       var  aURL  = `${aRoute}?action=${ aAction.toLowerCase().trim() }`
       var  aHTML = ` method="GET" action="${aAPI_Host}/${aURL}"                    style="margin-bottom: -5px;">
              /${ aURL   }` + `
                    &pid=<input type="text"   name="pid"      value=" ${pid}"       style="padding: 0px;  width: ${nWdt1}px;" />
                    &mid=<input type="text"   name="mid"      value=" ${mid}"       style="padding: 0px;  width: ${nWdt2}px;" />
                         <input type="hidden" name="action"   value="${aAction}"                                       />
                         <input type="submit"   id="form5"    value="${aAction}"    style="padding: 0px;  width: 50px" />
            `
     return aHTML
            }; // eof fmtForm5                                                                              // .(30524.01.4 End)
//     ---  ------------------  =  ---------------------------------
         }; // eof Root_getRoute
//--------  ------------------  =  --------------------------------- ------------------

// BEGINNING OF FETCHES (= MENU NAME)

//=login===============================================================================
//-(getLogin)----------------------------------------------------------------

this.Login_getRoute  = function( ) {    // Send back JSON                                                   // .(30404.02.2 )

       var  pValidArgs ={ uid : /[0-9]+/ }                                                                  // .(30525.03.8 RAM Was: id)

            setRoute( pApp, 'get', '/login', Login_getRoute_Handler, pValidArgs, `SELECT * FROM login_view`  )

     async  function  Login_getRoute_Handler( aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL ) {

            pRes.bSndNoData = true                                                                          // .(30407.03.1 RAM Don't send Error msg)
            JSON_getRoute_Handler(aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL )                         // .(30407.03.2 RAM Send Error msg)

            }; // eof Login_getRoute_Handler
//     ---  ------------------  =  ---------------------------------
         }; // eof Login_getRoute
//--------  ------------------  =  --------------------------------- ------------------


//-(getLogin_form)--------------------------------------------------------

this.Login_getForm  = function( ) {     // Send back HTML form with route = '/login?form' if present        // .(30404.02.3)

       var  pValidArgs ={ uid : /[0-9]+/ }                                                                  // .(30525.03.9 RAM Was: id)

            setRoute( pApp, 'get', '/login_form', Login_getForm_Handler )

     async  function  Login_getForm_Handler( aMethod, pReq, pRes, aRoute ) {

                               logIP(   pReq, pDB, `GET  Route, '/login_form'` )                            //.(30526.02.6 RAM Use logIP)
                               sayMsg(  pReq, aMethod, aRoute )

       var  pArgs     =        chkArgs( pReq, pRes,  pValidArgs   ); if (!pArgs) { return }
        if (pArgs.id > 0) {
       var  aSQL      =  await fmtSQL(  pArgs )
       var  mRecs     =  await getData( pDB,   aSQL, aRoute, pRes );                                        // .(30402.05.13 RAM say aRoute found).(30407.03.3)
        } else {
            mRecs     =  [ { Email: "", PIN: "" } ]
            }
//     var  aHTML     =  fmtHTML( mRecs[0], await fmtStyles( ) )                                            // .(30402.04.1)

       var  aHTML     =  await fmtHTML( mRecs[0] )                                                          // .(30403.01.1)
                               sndHTML( pRes, aHTML, `${aRoute}${pReq.args}`  )                             // .(30528.05.4 RAM Remove Handler).(30331.01.1).(30404.02.4)
                               sayMsg( 'Done',        "Login_getForm_Handler" )                             // .(30528.05.5)

            } // eof Login_getForm_Handler
//     ---  ------------------  =  ---------------------------------

     async  function  fmtSQL( pArgs ) {
    return `SELECT * FROM login_check_view WHERE Id = ${ pArgs.id } `
            }; // eof fmtSQL
//     ---  ------------------  =  ---------------------------------

     async  function  fmtHTML( pData ) {
    return  await Login_fmtHTML( pData )                                                                    // .(30403.01.2 RAM Use shared function )
            }; // eof fmtHTML
//     ---  ------------------  =  ---------------------------------
         }; // eof Login_getForm
//--------  ------------------  =  --------------------------------- ------------------


//-( postLoginRoute )----------------------------------------------------------

this.Login_postRoute = function( ) {    // Send back JSON if found, otherwise send back empty JSON or HTML form with error and route = '/login?form' if present

       var  pValidArgs =  { userid   : /[a-zA-Z0-9]+/                                                       // .(30525.06.2  RAM Was: username)
                          , username : /[a-zA-Z0-9]+/                                                       // .(30525.06.11 RAM Put it back)
                          , password : /[a-zA-Z0-9]{4,}/
                            }
            setRoute( pApp, 'post', '/login', Login_postRoute_Handler )

//     ---  ------------------  =  ---------------------------------

     async  function  Login_postRoute_Handler( aMethod, pReq, pRes, aRoute ) {

       var { fmtSQL1, fmtSQL2, fmtSQL3, fmtSQL4, fmtSQL5 } = Login_fmtSQLfns                                // .(30404.04.1).(30406.01.7).(30407.02.1)

                               logIP(   pReq, pDB, `POST Route, '/login'` )                                 // .(30526.02.7 RAM Use logIP)
                               sayMsg(  pReq, aMethod, aRoute )

       var  pArgs      =       chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }

       var  mRecs1     = await getData( pDB,  fmtSQL1( pArgs    ), aRoute, pRes );  // select login_view    // .(30403.01.3 RAM Check if username & password are in DB)
        if (mRecs1.length == 0) {    // sndErr( pRes, mRecs1[1] ); return                                   // .(30404.02.5 RAM If none found)
                               sndJSON( pRes, JSON.stringify( { login: [] } ), 'login' )                    // .(30404.02.6 RAM Return empty JSON)
        } else { // no error
       var  aIPAddr4   =       getIPAddr( pReq )[0]                                                         // .(30526.02.8 RAM Use getIPAddr).(30526.02.18)
            mRecs1[0]  =  { ...mRecs1[0], LastPageVisited: 'login.html', IPv4Address: aIPAddr4 }            // .(30406.03.2).(30405.04.6)

                         await putData( pDB,  fmtSQL2( mRecs1[0] ), aRoute );        // delete login        // .(30403.05.4).(30403.02.3 RAM Delete prior Login records).(30407.03.4)
       var  mRecs3     = await putData( pDB,  fmtSQL3( mRecs1[0] ), aRoute );        // insert login        // .(30403.05.5).(30403.02.4 RAM Change getData to putData)

       var  mRecs3     =   [ { Id: mRecs3[2].affectedId,  IPAddress4: mRecs1[0].IPAddr4                     // .(30406.01.4)
                             , LastPageVisited: mRecs1[0].LastPageVisited, Count: mRecs3[2].affectedRows }] // .(30406.03.3)

       var  mRecs4     = await putData( pDB,  fmtSQL4( mRecs3[0] ), aRoute );        // insert login_log    // .(30406.01.5 RAM Insert into login_log)
                         await putData( pDB,  fmtSQL5( mRecs1[0] ), aRoute );        // update members      // .(30406.01.5 RAM Insert into login_log).(30407.03.5 RAM Will never get an error)

                               sndJSON( pRes, JSON.stringify( { login: mRecs1 } ) , 'login' )               // .(30404.02.7)
                         }
                               sayMsg( 'Done', 'Login_postRoute_Handler' )                                  // .(30528.05.6)
            } // eof Login_postRoute_Handler
//     ---  ------------------  =  ---------------------------------
         }; // eof Login_postRoute
//--------  ------------------  =  --------------------------------- ------------------

       var  Login_fmtSQLfns = {                                                                             // .(30404.04.2 RAM Combine fmtSQL functions)

            fmtSQL1 : function( pArgs ) {                                                                   // .(30404.04.3 RAM Define function differently)

            pArgs.userid = pArgs.userid ? pArgs.userid : pArgs.username                                     // .(30525.06.12)
                                                                                                            // .(30405.04.1 RAM PIN vs Password and 'yes' vs 'Y')
    return `SQL1:   SELECT * FROM login_view2                                                               -- .(30413.01.5 RAM Parse SQL with SQLn:)
                     WHERE  Email   = '${ pArgs.userid }'                                                   -- .(30525.06.3 RAM Was: username)
                       AND  PIN     = '${ pArgs.password }'
                       AND  Active  = 'yes'`
            } // eof fmtSQL1
//     ---  ------------------  =  ---------------------------------

         ,  fmtSQL2 : function( pData ) {                                                                   // .(30404.04.4)

//  return `DELETE FROM login  WHERE MemberId = ${pData.Id}`                                                //#.(30407.02.2)
    return `SQL2:   DELETE  FROM login  WHERE MemberNo = ${pData.MemberNo}`                                   // .(30407.02.3)
            } // eof fmtSQL2
//     ---  ------------------  =  ---------------------------------

         ,  fmtSQL3 : function( pData ) {                                                                   // .(30404.04.5)

       var  aNow = (new Date).toISOString().replace( /T/, ' ').substring( 0, 19 )

            pData.LastPageVisited =  pData.LastPageVisited ? pData.LastPageVisited : `login.html`
            pData.LogInDateTime   =  aNow
            pData.LogOutDateTime  =  null
            pData.CreatedAt       =  aNow
            pData.UpdatedAt       =  aNow

//               `INSERT  INTO login                                                                               //#.(30407.02.4)
//                     (  MemberId, LastName, IPAddress4, LastPageVisited, LogInDateTime, LogOutDateTime, CreatedAt, UpdatedAt )
//                VALUES
//                     (  ${pData.Id }, '${pData.LastName}', '${pData.IPAddress4 }', '${ pData.LastPageVisited }'
//                                                                                                          // .(30405.04.2 RAM Change IPAddress4 to IPv4Address)
       var  aSQL = `SQL3:                                                                                   -- .(30406.03.4 RAM Add IPAddress4 to SQL).(30407.02.5)
                    INSERT  INTO login
                         (  MemberNo, FullName, IPv4Address, LastPageVisited, LogInDateTime, LogOutDateTime, CreatedAt, UpdatedAt )
                    VALUES
                         (  ${pData.MemberNo }, '${pData.FullName}', '${pData.IPAddress4 }', '${ pData.LastPageVisited }'
                         ,  STR_TO_DATE(  '${pData.LogInDateTime}' , '%Y-%m-%d %H:%i:%s' )
                         ,                 ${pData.LogOutDateTime}
                         ,  STR_TO_DATE(  '${pData.CreatedAt}'     , '%Y-%m-%d %H:%i:%s' )
                         ,  STR_TO_DATE(  '${pData.UpdatedAt}'     , '%Y-%m-%d %H:%i:%s' )
                            ); `
    return  aSQL
            } // eof fmtSQL3
//     ---  ------------------  =  ---------------------------------

         ,  fmtSQL4( pData ) {                                                                              // .(30406.01.6 Beg RAM Write function)

//                SELECT  Id, MemberId, LastName, IPAddress4,  LastPageVisited, LogInDateTime, CreatedAt, UpdatedAt//#.(30407.02.6)
//                SELECT  Id, MemberNo, LastName, IPv4Address, LastPageVisited, LogInDateTime, CreatedAt, UpdatedAt//#.(30405.04.3)
//                  FROM  login WHERE id = ${pData.Id};`
                                                                                                            // .(30406.03.5).(30407.02.7).(30405.04.3)
    return `SQL4:   INSERT  INTO login_log
                    SELECT  Id, MemberNo, FullName, IPv4Address, LastPageVisited, LogInDateTime, CreatedAt, UpdatedAt
                      FROM  login WHERE id = ${pData.Id};`

            }  // eof fmtSQL4                                                                               // .(30406.01.6 End)
//     ---  ------------------  =  ---------------------------------

         ,  fmtSQL5( pData ) {                                                                              // .(30406.01.6 Beg RAM Write function)
                                                                                                            // .(30407.02.8).(30405.04.4)
    return `SQL5:   UPDATE  members
                       SET  IsLoggedIn    = 'Y', IPv4Address = '${pData.IPv4Address}'
                         ,  LogInDateTime =  STR_TO_DATE( '${pData.LogInDateTime}', '%Y-%m-%d %H:%i:%s' )
                     WHERE  MemberNo = ${pData.MemberNo}`

            }  // eof fmtSQL5                                                                               // .(30407.02.9)
//     ---  ------------------  =  ---------------------------------
         }; // eoo Login_fmtSQLfns                                                                          // .(30404.04.6)
//--------  ------------------  =  --------------------------------- ------------------

     async  function  Login_fmtHTML( pData, aErr ) {                                                        // .(30403.01.5 Beg Move to shared async function ).(.30403.05.1)

       var  mStyles    =
                      [ '.Section1Title', '.login', '.login form', '.login h1' , '.login form label'
                      , '.login form input[type="password"], .login form input[type="text"]'
                      , '.login form input[type="submit"]', '.login form input[type="submit"]:hover'
                           ]
       var  aStyleSheet= `${__appDir}/login/login.css`                                                      // .(30416.05.1)
       var  aStyles    =  await getStyles( aStyleSheet, mStyles )                                           // .(30416.04.1 RAM was '../../login/login.css')
            aStyles   += `\n#ErrorMsg { display: ${ aErr ? 'block' : 'none' } }`
//          traceR(      'login_fmtHTML[1]', `aStyles:\n'${aStyles}'`, 1 );
            aStyles    =  aStyles.replace( /\n/g, '\n'.padEnd(9) ) + '\n'.padEnd(7)

       var  aHTML      =                                                                                    // .(30402.04.4 RAM Add Styles)
`    <style>${ aStyles}</style>
      <div class="Section1Title">institute of database developers</div>
      <div class="login">
          <h1>Login</h1>
          <form action="/login" method="post">
            <label for="username">
              <!-- font awesome icon -->
              <i class="fas fa-user"></i>
            </label>
            <input type="text"     name="userid" placeholder="eMail"      id="userid"   value="${pData.Email}" required>  <!-- .(30525.06.4) -->
            <label for="password">
              <i class="fas fa-lock"></i>
            </label>
            <input type="password" name="password" placeholder="Password" id="password" value="${pData.PIN}" required>
          <input type="submit" value="Login">
        </form>
        <div id="ErrorMsg">${aErr}</div>
      </div><!-- eof class login -->
     `
        var bLog_HTML  =  process.env.Log_HTML == true                                                      // .(30417.02.2)
            traceR(      'login_fmtHTML[2]', `aHTML:\n'${aHTML}'`, bLog_HTML );                             // .(30417.02.3)
    return  aHTML
            } // eof Login_fmtHTMLogin                                                                      // .(30330.06.3 End)
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================


//= meeting s==============================================================
//-(Meeting Notification)--------------------------------------------------

this.Meetings_getRoute = function( ) {

            setRoute(  pApp, 'get', '/meetings',        Meetings_getRoute_Handler, { id : /[0-9]+/ }, `SELECT * FROM meetings_view` )

//     ---  ------------------  =  ---------------------------------

     async  function  Meetings_getRoute_Handler ( aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL ) {

                               logIP(   pReq, pDB, `GET  Route, '/meetings'` )                              // .(30526.02.9 RAM Use logIP)
                               sayMsg(  pReq, aMethod, aRoute )

       var  pArgs      =       chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }
       var  aSQL       =       chkSQL(  fmtSQL, pArgs )                                                     // .(30403.06.6).(30407.03.6)
//     var  mRecs      = await getData( pDB,   aSQL ); if (mRecs[0] == 'error') { sndErr( pRes, mRecs[1] ); return }
       var  mRecs      = await getData( pDB,   aSQL, aRoute, pRes ); if (mRecs[0] == 'error') { sndErr( pRes, mRecs[1] ); return }
                               sndRecs( mRecs, aSQL, aRoute, pRes, "Meetings_getRoute_Handler" )            // .(30331.02.2).(30407.03.7)
                               sayMsg( 'End' )                                                              // .(30528.05.7)

            } // eof Meetings_getRoute_Handler
//     ---  ------------------  =  ---------------------------------
         }; // eof Meetings_getRoute
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================


//= members ===============================================================
//-(Members Listing)-------------------------------------------------------

this.Members_getRoute = function( ) {

     // var aSQL = `SELECT DISTINCT FullName, Address1, Address2, City, State, Zip, LastName FROM iodd.AllData2_view WHERE Active = 'Y' ORDER BY LastName ;`
        var aSQL = `SELECT * FROM members_view`

            setRoute( pApp, 'get', '/members',          JSON_getRoute_Handler, aSQL )                       // .(30525.05.2 RAM Allows pArg.id with pValidArgs)
//          setRoute( pApp, 'get', '/members',          JSON_getRoute_Handler, `SELECT * FROM members_view`)

         }; // eof Members_getRoute
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================


//-(postMembers)-----------------------------------------------------------
//-(Update/Insert Member)--------------------------------------------------

this.Member_postRoute = function( ) {                                                                       // .(30510.03.4 Beg RAM Add Members_postRoute)

       var  aNow = (new Date).toISOString().replace( /T/, ' ').substring( 0, 19 )

       var  pValidArgs = {  mid              : [ 'Id',           /.[0-9]+/, "required", "must be a number"] // .(30515.03.3 RAM Was id).(30525.03.10 RAM Was: MemberNo)
                         ,  memberno         : [ 'Id',           /.[0-9]+/ ]                                // .(30525.03.21 RAM Can't get rid of it yet)
//                       ,  title            : [ 'TitleName',    /.+/, ]                                    // .(30515.03.4 RAM Not in form)
                         , 'first-name'      : [ 'FirstName',    /.+/, ]                                    // .(30515.03.5 RAM Was firstname)
                         , 'middle-inits'    : [ 'MiddleName',   /.+/, ]                                    // .(30515.03.6 RAM Was middleinits)
                         , 'last-name'       : [ 'LastName',     /.+/, ]                                    // .(30515.03.7 RAM Was lastname)
                         ,  suffix           : [ 'PostName',     /.+/, ]
//                       ,  role             : [ 'RoleId',       /.+/, ]
                         ,  email            : [ 'Email',        /[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+/, "", "must be a valid email address (xx@xx.xx)" ]  // .(30515.03.8 RAM Was: email).(30515.03.9 Was username)
                         ,  password         : [ 'PIN',          /[a-zA-Z0-9]{4,}/,                         "", "must be at least 4 characters" ]
//                       ,  active           : [ 'Active',       /.+/, 'Y' ]                                // .(30515.03.10 RAM Set in SQL)
//                       ,  login            : [ 'IsLoggedIn',   /.+/, 'N' ]                                // .(30515.03.11 RAM Set in SQL)
//                       ,  login_at         : [ 'LogInDateTime',/.+/, '#" + aNow ]                         // .(30515.03.12 RAM Not in form).(30527.02.2 RAM MSAccess Date)
//                       ,  ipaddr           : [ 'IPv4Address',  /.+/,  ]                                   // .(30515.03.13 RAM Not in form)
                         , 'company'         : [ 'Company',      /.+/,  ]                                   // .(30515.03.14 RAM Was 'co-name')
                         , 'company-address1': [ 'Address1',     /.+/,  ]                                   // .(30515.03.15 RAM Was 'co-addr1')
                         , 'company-address2': [ 'Address2',     /.+/,  ]                                   // .(30515.03.16 RAM Was 'co-addr2')
                         ,  city             : [ 'City',         /.+/,  ]
                         ,  state            : [ 'State',        /.+/,  ]
                         ,  zip              : [ 'Zip',          /.[0-9.]{5,10}/, "", "must be a valid zip code (xxxxx[.xxxx])" ]
                         ,  country          : [ 'Country',      /.+/,  ]
                         ,  phone1           : [ 'Phone1',       /.+/,  ]
                         ,  phone2           : [ 'Phone2',       /.+/,  ]
//                       ,  fax              : [ 'Fax',          /.+/,  ]
                         , 'company-url'     : [ 'WebSite',      /.+/,  ]                                    // .(30515.03.17 RAM Was website)
//                       ,  skills           : [ 'Skills',       /.+/,  ]                                    // .(30515.03.18 RAM Not in form)
                         ,  bio              : [ 'Bio',          /.+/,  ]
//                       ,  created_at       : [ 'CreatedAt',    /.+/,  aNow ]                               // .(30515.03.19 RAM Set in DB)
                         ,  updated_at       : [ 'UpdatedAt',    /.+/, `=STR_TO_DATE( '${ aNow }', '%Y-%m-%d %H:%i:%s' )` ]   // .(30527.02.3 RAM Expression)
//                       ,  last_updated     : [ 'LastUpdated',  /.+/,  aNow ]                               // .(30515.03.21 RAM Set in SQL)
                            }

//     var  pArgs = chkArgs( pReq, pValidArgs )

            setRoute( pApp, 'post', '/member', Member_postRoute_Handler, pValidArgs )

     async  function  Member_postRoute_Handler( aMethod, pReq, pRes, aRoute ) {

                               logIP(   pReq, pDB, `POST Route, '/member'` )                                // .(30526.02.10 RAM Use logIP)
                               sayMsg(  pReq, aMethod, aRoute )

//     var  pArgs      =       chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }
//     var  pArgs      =                pReq.body.map( aFld => pValidArgs[ aFld ][0] )
       var  pArgs      = { };  Object.keys( pReq.body ).forEach( function( aFld ) {
        if (pValidArgs[ aFld ]) {pArgs[ pValidArgs[ aFld ][0] ] = pReq.body[ aFld ] } } )

       var  mRecs1     = await putData( pDB,  fmtSQL1( pArgs ), aRoute );
//      if (mRecs1.error)    { sndErr(  pRes, mRecs1.error   ); return }                                    //#.(30515.03.22 RAM return no workie, CUZ mRecs1.error is an error)
        if (mRecs1[0] == 'error') {                                                                         // .(30515.03.22 RAM Would mRecs1[0].error be better)
                               sndErr(  pRes, mRecs1[1]      ); return }

//     var  mRecs2     =   [ { MemberNo:mRecs1[2].affectedId, Count: mRecs1[2].affectedRows, ... }          // .(30515.03.23 RAM Why is affectedId = 0)
//     var  mRecs2     =   [ { MemberNo:pArgs.MemberNo,  Count: mRecs1[2].affectedRows, ... }               //#.(30525.03.11)
       var  mRecs2     =   [ { Id:      pArgs.Id,        Count: mRecs1[2].affectedRows                      // .(30525.03.11 RAM Was: MemberNo. Gotta change it here too)
                             , Email:   pArgs.Email,       Msg: mRecs1[1] }
                               ]
       var  mRecs2     = await getData( pDB,  fmtSQL2( mRecs2[0] ), aRoute );

                               sndJSON( pRes, JSON.stringify( { member: mRecs2 } ), aRoute )
                               sayMsg( 'Done', "Member_postRoute_Handler" )                                 // .(30528.05.8)
         }; // eof Member_postRoute_Handler
//     ---  ------------------  =  ---------------------------------

  function  fmtSQL1_x( pVars ) {

            pVars.Email = pVars.Email ? `${ pVars.Email }`.trim() : ''                                      // .(30515.03.24 RAM Email not a string?)

       var  aSQL = `UPDATE  members
                       SET  Email           = '${ pVars.Email           }'
                         ,  PIN             = '${ pVars.PIN             }'
                         ,  UpdatedAt       =     STR_TO_DATE( '${ aNow }', '%Y-%m-%d %H:%i:%s' )
                     WHERE  Id              =  ${ pVars.Id              }
                   `
    return  aSQL
            }
//     ---  ------------------  =  ---------------------------------

  function  fmtSQL1( pVars ) {

            pVars.Email     =  pVars.Email ? `${ pVars.Email }`.trim() : ''                                 // .(30515.03.24 RAM Email not a string?)
            pVars.Active    = `'Y'`
//          pVars.UpdatedAt = `=STR_TO_DATE( '${ aNow }', '%Y-%m-%d %H:%i:%s' )`                            // .(30527.01.4)
            pVars.UpdatedAt = '@' + aNow                                                                    // .(30527.01.4)

//      if (pVars.Bio) {                                                                                    // .(30525.02.1 RAM Bio may not be present)
//          pVars.Bio       =  pVars.Bio.replace( /'/g, "''" ) }                                            // .(30515.08.2 RAM Double up single quotes, if any).(30525.02.2)

//     var  updateFld       = (aFld) => `, ${aFld} ='${ pVars[ aFld ] }'`.padStart( 25 )                    //#.(30525.02.4)
/*     var  updateFld       =  function( aFld ) {                                                           //#.(30527.02.5 Beg RAM Replace)
                                   if (aFld == 'Id') { return null }                                        //#.(30525.03.12 RAM Was: MemberNo)
//                                     aFld =  `, ${aFld} ='${ pVars[ aFld ] }'`.padStart( 25 )             //#.(30525.02.3)
                                       aFld =  `,  ${aFld.trim()} = '${ pVars[ aFld ].trim() }'`            // .(30525.02.3 RAM padStart: no workie)
                               return `${''.padEnd(23)}${aFld}`
                                       } */                                                                 //#.(30527.02.5 End)
       var  updateFld       =  function( aFld ) { return fmtFld4SQL(  aFld,  pVars[  aFld ], 25 ) }         // .(30529.01.7 RAM Was: 22).(30527.02.5 RAM Use fmtFld4SQL)
       var  aUpdateFlds     =  Object.keys( pVars ).map( updateFld ).filter( aFld => aFld ).join('\n')      // .(30525.02.4 RAM Beg Loop thru only those present)

       var  aSQL = `UPDATE  members
                       SET  ${ aUpdateFlds.substring( 28 ) }                                                -- .(30529.01.8 RAM Was: 25)
                     WHERE  Id = ${ (pVars.Id || '').trim( ) }                                              -- .(30525.09.2 RAM Added .toString)
                     `                                                                                      // .(30525.02.4 End)
/*     var  aSQL = `UPDATE  members                                                                         //#.(30525.02.4 Beg RAM Revised)
--                     SET  TitleName       = '${ pVars.TitleName       }'
                       SET  FirstName       = '${ pVars.FirstName       }'
                         ,  MiddleName      = '${ pVars.MiddleName      }'
                         ,  LastName        = '${ pVars.LastName        }'
                         ,  PostName        = '${ pVars.PostName        }'
--                       ,  RoleId          = '${ pVars.RoleId          }'
                         ,  Email           = '${ pVars.Email           }'
                         ,  PIN             = '${ pVars.PIN             }'
                         ,  Active          = 'Y'
--                       ,  IsLoggedIn      = 'N'
--                       ,  LogInDateTime   = '${ pVars.LogInDateTime   }'
--                       ,  IPv4Address     = '${ pVars.IPv4Address     }'
                         ,  Company         = '${ pVars.Company         }'
                         ,  Address1        = '${ pVars.Address1        }'
                         ,  Address2        = '${ pVars.Address2        }'
                         ,  City            = '${ pVars.City            }'
                         ,  State           = '${ pVars.State           }'
                         ,  Zip             = '${ pVars.Zip             }'
                         ,  Country         = '${ pVars.Country         }'
                         ,  Phone1          = '${ pVars.Phone1          }'
                         ,  Phone2          = '${ pVars.Phone2          }'
--                       ,  Fax             = '${ pVars.Fax             }'
                         ,  WebSite         = '${ pVars.WebSite         }'
--                       ,  Skills          = '${ pVars.Skills          }'
                         ,  Bio             = '${ pVars.Bio             }'
--                       ,  CreatedAt       =     STR_TO_DATE( '${ aNow }' , '%Y-%m-%d %H:%i:%s' )
                         ,  UpdatedAt       =     STR_TO_DATE( '${ aNow }' , '%Y-%m-%d %H:%i:%s' )
                         ,  LastUpdated     =     STR_TO_DATE( '${ aNow }' , '%Y-%m-%d %H:%i:%s' )
                     WHERE  Id              =  ${ pVars.MemberNo        }
                     `
*/                                                                                                          //#.(30525.02.4 End)
    return  aSQL
            }
//     ---  ------------------  =  ---------------------------------

  function  fmtSQL2( pMember ) {
//          return `SELECT * FROM members WHERE MemberNo = ${pMember.MemberNo}`                             //#.(30525.03.13)
            return `SELECT * FROM members WHERE Id  = ${pMember.Id}`                                        // .(30525.03.13 RAM Was: MemberNo )
            }
//     ---  ------------------  =  ---------------------------------
         }; // eof Member_postRoute                                                                         // .(30510.03.4 End)
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================


//= members_bios============================================================
//-(Bios)------------------------------------------------------------------

this.MembersBios_getRoute = function( ) {

     // var aSQL = `SELECT DISTINCT FullName, Bio, LastName FROM AllData2_view WHERE Active = 'Y' ORDER BY LastName ;`
        var aSQL = `SELECT * FROM members_bios_view`

            setRoute( pApp, 'get', '/members_bios',     JSON_getRoute_Handler, aSQL )
         // setRoute( pApp, 'get', '/members_bios',     JSON_getRoute_Handler, `SELECT * FROM members_bios_view` )

         }; // eof MembersBios_getRoute
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================


// =members_projects ======================================================
//-(Project Listing)-------------------------------------------------------

this.MembersProjects_getRoute = function( ) {

            setRoute( pApp, 'get', '/members_projects', JSON_getRoute_Handler, `SELECT * FROM members_projects_view` )

         }; // eof MembersProjects_getRoute
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================


//=projects================================================================
//-(Project Details)-------------------------------------------------------

this.Projects_getRoute = function( ) {                                                    // GET Route, '/projects

        var aSQL = `SELECT * FROM members_projects_colaboration_view`

            setRoute( pApp, 'get', '/projects',         JSON_getRoute_Handler,  aSQL )

         }; // eof Projects_getRoute
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================

this.Project_getRoute  = function( ) {                                                    // .(30525.04.4 RAM Beg Add: GET Route, '/project

        var pValidArgs = { pid:/[0-9]+/ }                                                 // .(30525.03.14 RAM Was: id)
        var fmtSQL     =   pArgs => `SELECT * FROM projects where Id = ${ pArgs.pid || -1 }`

            setRoute( pApp, 'get', '/project',          JSON_getRoute_Handler,  fmtSQL, pValidArgs )

         }; // eof Project_getRoute                                                       // .(30525.04.4 End)
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================


//-(postProject)-----------------------------------------------------------
//-(Update/Insert Project)--------------------------------------------------

this.Project_postRoute = function( ) {                                                  // .(30516.01.4 Beg RJS Copied Members_postRoute)

       var  aNow       = (new Date).toISOString().replace( /T/, ' ').substring( 0, 19 )

       var  pValidArgs = {  pid               : [ 'Id',            /.[0-9]+/, "required", "must be a number"]
                         ,  projectname       : [ 'ProjectName',         /.+/                                     ]
                            }

//     var  pArgs = chkArgs( pReq, pValidArgs )

            setRoute( pApp, 'post', '/projects', Project_postRoute_Handler, pValidArgs )

     async  function  Project_postRoute_Handler( aMethod, pReq, pRes, aRoute ) {

                               logIP(   pReq, pDB, `POST Route, '/projects'` )          // .(30526.02.11 RAM Use logIP)
                               sayMsg(  pReq, aMethod, aRoute )

//     var  pArgs      =      chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }
       var  pArgs      = { }; Object.keys( pReq.body ).forEach( aFld => { if (pValidArgs[ aFld ]) {   pArgs[ pValidArgs[ aFld ][0] ] = pReq.body[ aFld ] } } )

            pArgs.Id   = pReq.body.pid
            pArgs.Name = pReq.body.projectname

            console.log("-- RJS: pArgs", pArgs)
       var  mRecs1     = await putData( pDB,  fmtSQL1( pArgs ), aRoute );
        if (mRecs1[0] =='error') { sndErr(  pRes, mRecs1[1]    ); return }

        var  mRecs2    = await getData( pDB,  `SELECT * FROM projects WHERE ProjectId = ${pArgs.ProjectId}`, aRoute );
                               sndJSON( pRes, JSON.stringify( { project: mRecs2 } ), aRoute )
                               sayMsg( 'Done', "Project_postRoute_Handler" )            // .(30528.05.9)

            }; // eof Project_postRoute_Handler
//     ---  ------------------  =  ---------------------------------

  function  fmtSQL1( pProject ) {

       var  aSQL = `UPDATE  projects
                       SET  Name  = '${ pProject.Name       }'
                     WHERE  Id    =  ${ pProject.Id         }
                   `
    return  aSQL
            }
//     ---  ------------------  =  ---------------------------------
    }; // eof Project_postRoute                                                         // .(30516.01.4 End)
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================


//= projects_list ===============================================================
//-(ProjectDropdown Listing)-------------------------------------------------------

this.ProjectsList_getRoute = function( ) {                                              // .(30511.03.4 Beg Add ProjectsList_getRoute)

       var  aRoute     = '/projects_list'
       var  pValidArgs = {  mid    : /[0-9]+/
                         ,  owner  : /primary|secondary/
                            }

  function  fmtSQL (pArgs) {
       var  aSQL = `SELECT * FROM iodd.form_projects_dropdown
                     WHERE  Owner like  '${ pArgs.owner || ''}%' AND MemberId = ${ pArgs.mid || -1 }
                   `
//     var  aSQL = `SELECT * FROM iodd.form_projects_dropdown WHERE  ProjectId = ${ pArgs.id || -1 }`
    return  aSQL
            }
            setRoute( pApp, 'get', '/projects_list',    JSON_getRoute_Handler,  pValidArgs,  (pArgs) => {return fmtSQL(pArgs)})

         }; // eof ProjectsList_getRoute                                                // .(30511.03.4 End)
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================


//= project (singular) ===============================================================
//-(Project Banner)-------------------------------------------------------

this.ProjectBanner_getRoute = function( ) {                                             // .(30521.01.3 RJS Beg)

       var  aRoute     =  '/project_banner'
       var  pValidArgs = { pid:/[0-9]+/ }

  function  fmtSQL (pArgs) {
            return `SELECT * FROM iodd.form_projects_dropdown WHERE ProjectId = ${ pArgs.pid || -1 }`
            }
//          setRoute( pApp, 'get', '/project_banner',    JSON_getRoute_Handler, pValidArgs, ( pArgs ) => {return fmtSQL(pArgs)})
            setRoute( pApp, 'get',  aRoute,              JSON_getRoute_Handler, pValidArgs, fmtSQL )

         }; // eof ProjectBanner_getRoute                                               // .(30521.01.3 End)
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================


//= project_collaborators =======================================e===========

//-(getProjectCollaborators)-------------------------------------------------

this.ProjectCollaborators_getRoute = function( ) {

       var  aRoute    = '/project_collaborators'
       var  aHandler  = 'ProjectCollaborators_getRoute_Handler'

       var  pValidArgs=  { mpid: /[0-9]+/
                         , pid:  /[0-9]+/
                         , mid:  /[0-9]+/ }
            pValidArgs[ "action" ] = /([Dd]elete|[Ii]nsert)/                            // .(30525.07.1 RAM ToDo: Allow anycase)

                               sayMsg( 'get', aRoute )
//     ---  ------------------  =  ---------------------------------

       pApp.get( `${aAPI_Host}${aRoute}`, async function( pReq, pRes ) {

                               logIP(   pReq, pDB, `GET  Route, '/project_collaborators'` ) // .(30526.02.12 RAM Use logIP)
                               sayMsg(  pReq, 'get', aRoute )

       var  pArgs      =       chkArgs( pReq, pRes,  pValidArgs  ); if (!pArgs) { return }

       var  aSQL       =       chkSQL(  fmtSQL, pArgs )                                 // .(30403.06.7)
   if (aSQL.match(/SELECT/)) {                                                          // .(30524.01.5 RAM )
       var  mRecs      = await getData( pDB,   aSQL, aRoute )                           // .(30407.03.8 RAM No Errors??)
   } else {                                                                             // .(30524.01.6 Beg RAM use putData)
       var  mRecs      = await putData( pDB,   aSQL, aRoute )
            mRecs      = mRecs }
                               sndRecs( mRecs, aSQL, aRoute, pRes, aHandler )           // .(30407.03.9)
                               sayMsg( 'End')                                           // .(30528.05.10)

            } ) // eof pApp.get( /project_collaborators )
//     ---  ------------------  =  ---------------------------------

  function  fmtSQL( pArgs ) {
       var  nId        =  pArgs.pid    || -1
       var  aAction    = (pArgs.action || '').toLowerCase()                            // .(30525.07.2).(30525.07.2 RAM Fix Err: toLowerCase() on undefined) )
       var  aName      =  pArgs.name   || ""

        if (aAction == "") {                                                            // .(30524.01.7)
       var  aSQL = `
                    SELECT  Distinct *
                      FROM  members_projects_view
${ nId ?
'                     WHERE  ProjectId = ' + nId : '' }
                   `
            }                                                                           // .(30524.01.8 Beg RAM Add Insert and Delete)
        if (aAction == "delete") {
       var  aSQL = `
                    DELETE  FROM members_projects WHERE Id = ${ pArgs.mpid }
                   `
            }
        if (aAction == "insert") {
       var  aSQL =  `
                    INSERT  INTO members_projects ( MemberId, ProjectId ) VALUES ( ${pArgs.mid}, ${pArgs.pid} )
            `
            }                                                                           // .(30524.01.8 End)
    return  aSQL
            }; // eof fmtSQL
//     ---  ------------------  =  ---------------------------------
         }; // eof ProjectCollaborators_getRoute
//--------  ------------------  =  --------------------------------- ------------------

//RJS
//=====================================================================================
//-(postProjectCollaborators)-----------------------------------------------------------
//-(Update/Insert Member)--------------------------------------------------

this.ProjectCollaborators_postRoute = function( ) {                                     // .(30510.05.3 Beg RAM Add ProjectCollaborators_postRoute )

       var  aRoute     = '/project_collaborators'
//     var  aNow       = (new Date).toISOString().replace( /T/, ' ').substring( 0, 19 )

       var  pValidArgs = {  pid         : [ 'Id',            /.[0-9]+/, "required", "must be a number"] // .(30515.04.1 RAM Was: id)
                         ,  mpid        : [ 'Id',            /.[0-9]+/                                ]
                         ,  projectname : [ 'Name',          /.+/                                     ]
                         ,  projecturl  : [ 'ProjectWeb',    /.+/                                     ]
                         ,  clientname  : [ 'Client',        /.+/                                     ]
                         ,  clienturl   : [ 'ClientWeb',     /.+/                                     ]
                         ,  industry    : [ 'Industry',      /.+/                                     ]
                         ,  location    : [ 'Location',      /.+/                                     ]
                         ,  description : [ 'Description',   /.+/                                     ]
                         ,  role        : [ 'Role',          /.+/                                     ]
                         ,  dates       : [ 'Dates',         /.+/                                     ]
                         ,  duration    : [ 'Duration',      /.+/                                     ]
                       }

//     var  pArgs = chkArgs( pReq, pValidArgs )

            setRoute( pApp, 'post', '/project_collaborators', ProjectCollaborators_postRoute_Handler, pValidArgs )

     async  function  ProjectCollaborators_postRoute_Handler( aMethod, pReq, pRes, aRoute ) {

                               logIP(   pReq, pDB, `POST Route, '/project_collaborators'` ) // .(30526.02.13 RAM Use logIP)
                               sayMsg(  pReq, aMethod, aRoute )

//     var  pArgs      =       chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }
//     var  pArgs      = { };  Object.keys(   pReq.body ).forEach( aFld => { if (pValidArgs[ aFld ]) {   pArgs[ pValidArgs[ aFld ][0] ] = pReq.body[ aFld ] } } )
       var  pArgs      = { };  Object.keys(   pReq.body ).forEach( aFld => { if (pValidArgs[ aFld ]) {   pArgs[ aFld ] = pReq.body[ aFld ] } } )

            pArgs.Id   =  pReq.body.pid
            pArgs.Name =  pReq.body.projectname

//          console.log("pArgs", pArgs)
       var  mRecs1    =  await putData( pDB,  fmtSQL1( pArgs ), aRoute );
        if (mRecs1[0] == 'error') { sndErr(   pRes, mRecs1[1]    ); return }            // .(30515.04.2 RAM Would mRecs1[0].error be better)

       var  mRecs2    =  await putData( pDB,  fmtSQL2( pArgs ), aRoute );
//          console.log("mRecs2", mRecs2)
        if (mRecs2[0] == 'error') { sndErr(   pRes, mRecs2[1]    ); return }            // .(30515.04.3 RAM Would mRecs1[0].error be better)

//     var  mRecs3    =  await getData( pDB, `SELECT * FROM members_projects_view WHERE Members_ProjectsId = ${pArgs.mpid}`, aRoute );
       var  mRecs3    =  await getData( pDB,  fmtSQL3( pArgs.mpid ), aRoute );          // .(30515.04.4 RAM Add fmtSQL3())

                               sndJSON( pRes, JSON.stringify( { project_collaborators: mRecs3 } ), aRoute )
                               sayMsg( 'Done', "ProjectCollaborators_postRoute_Handler")// .(30528.05.11)

         }; // eof ProjectCollaborators_postRoute_Handler
//     ---  ------------------  =  ---------------------------------

function  fmtSQL1( pForm ) {

       //   pForm.Description = pForm.Description.replace( /'/g, "''" )                 // .(30515.08.2 RAM Double up single quotes, if any)

       var  aSQL = `UPDATE  projects
                       SET  Name       = '${ pForm.projectname  }'
                         ,  ProjectWeb = '${ pForm.projecturl   }'
                     WHERE  Id         =  ${ pForm.pid          }
              `
    return  aSQL
            }
//          --------------------------------------------------------

  function  fmtSQL2( pForm ) {

       var  aSQL = `UPDATE  members_projects
                       SET  Dates      = '${ pForm.dates        }'
                         ,  Role       = '${ pForm.role         }'
                     WHERE  Id         =  ${ pForm.mpid         }
                     `
    return  aSQL
            }
//          --------------------------------------------------------

  function  fmtSQL3( mpid ) {                                                           // .(30515.04.5 RAM Add fmtSQL3())
    return `SELECT * FROM members_projects_view WHERE Members_ProjectsId = ${mpid}`
            }
//          --------------------------------------------------------

//     ---  ------------------  =  ---------------------------------
         }; // eof Project_postRoute                                                    // .(30510.05.3 End)
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================

//= User =================================================================
//-(getUser)--------------------------------------------------------------

this.User_getRoute = function() {                                                       // .(30510.02.6 RAM Was Users_getOneRoute)

            setRoute( pApp, 'get', '/user',             JSON_getRoute_Handler
//                  return `SELECT * FROM users WHERE Id = ${ pArgs.uid       } `       //#.(30511.02.7)
            , ( pArgs ) => `SELECT * FROM users WHERE Id = ${ pArgs.uid || -1 } `       // .(30511.02.7 RAM SELECT nothing if no args).(30525.03.15 RAM Was: id)
            , { uid: /[0-9]+/ }                                                         // .(30508.08.1 RAM Add kludge)
                       );
         }; // eof Users_getOneRoute
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================

//= users ================================================================
//-(getUsers)-------------------------------------------------------------

this.Users_getRoute = function( ) {                                                     // .(30328.04.1 Beg RAM Add getUsers).(30510.02.7 RAM Was: Users_getAllRoute)

            setRoute( pApp, 'get', '/users',            JSON_getRoute_Handler,
                      `SELECT * FROM users`, { uid: /[0-9]+/ } )                        // .(30508.08.2 RAM ToDo: Use any id in SQL)

         }; // eof Users_getAllRoute                                                    // .(30328.04.1 End)
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================

//= adduser =================================================================
//-(addUser)-----------------------------------------------------------------

this.User_postRoute  =  function( ) {                                                   // .(30328.05.1 Beg RAM Add addUser)

       var  aRoute = `/user`
       var  pValidArgs =  { userid   : /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+/               // .(30528.03.1 RAM Check for valid email).(30525.06.5)
                          , username : /[a-zA-Z0-9]+/                                   // .(30525.06.13 RAM Put it back)
                          , password : /[a-zA-Z0-9]{4,}/
                            }
       var { fmtSQL1, fmtSQL2 } = Login_fmtSQLfns

            setRoute( pApp, 'post', '/user', User_postRoute_Handler )

//     ---  ------------------  =  ---------------------------------

     async  function  User_postRoute_Handler( aMethod, pReq, pRes, aRoute ) {

                               logIP(   pReq, pDB, `POST Route, '/user'` )              // .(30526.02.14 RAM Add 'begin')
                               sayMsg(  pReq, aMethod, aRoute )

       var  pArgs     =        chkArgs( pReq, pRes, pValidArgs ); if (!pArgs) { return }
//          pArgs.username  =  pArgs.userid                                             // .(30525.06.6 RAM Use username, not userid)

       var  mRecs1    =  await getData( pDB,  fmtSQL1( pArgs ), aRoute, pRes );
        if (mRecs1.length != 0) {
       var  mMsg      =  [ ` ** The user, '${mRecs1[0].UserName }', currently exists` ]
                               sndJSON( pRes, JSON.stringify( { error: mMsg  } ), 'user' )
                               sayMsg( 'ABORT', mMsg[0], 'User_postRoute_Handler' )     // .(30528.04.3 RAM Switch args).(30528.04.2 RAM Add abort).(30528.04.1 RAM Forgot to say)
        } else { // no error
       var  mRecs2    =  await putData( pDB,  fmtSQL2( pArgs ), aRoute );

       var  mRecs2    =    [ { Id: mRecs2[2].affectedId, Count: mRecs2[2].affectedRows
                             , UserName: pArgs.userid, Password: pArgs.password }       // .(30525.06.7 RAM Use userid, not userid)
                               ]
                               sndJSON( pRes, JSON.stringify( { user: mRecs2 } ), 'user' )
                               sayMsg( 'Done', "User_postRoute_Handler" )               // .(30528.05.12)
            }
//     ---  ------------------  =  ---------------------------------

  function  fmtSQL1( pArgs ) {

            pArgs.userid = pArgs.userid ? pArgs.userid : pArgs.username                 // .(30525.06.14)

            return `SELECT  UserName
                      FROM  users
                     WHERE  UserName = '${ pArgs.userid }'                              -- .(30525.06.8)
                   `
            }; // eof fmtSQL1
//     ---  ------------------  =  ---------------------------------

  function  fmtSQL2( pArgs ) {

       var  aDay = (new Date).toISOString().substring( 0, 10 )
            pArgs.userid = pArgs.userid ? pArgs.userid : pArgs.username                 // .(30525.06.15)

            return `INSERT  INTO  users
                         (  UserName, Email, Password, PasswordDate, Role, Active, MemberNo )
                   VALUES( '${ pArgs.userid }'
                         , '${ pArgs.userid }@gmail.com'                                -- .(30525.06.9)
                         , '${ pArgs.password }'                                        -- .(30525.06.10)
                         ,  STR_TO_DATE( '${ aDay }' , '%Y-%m-%d' )
                         , 'Admin'
                         , 'Y'
                         ,  9
                            ) `

            }; // eof fmtSQL2
//     ---  ------------------  =  ---------------------------------
          }; // eof User_postRoute_Handler
//     ---  ------------------  =  ---------------------------------
         }; // eof Users_postUser                                                       // .(30328.05.1 End)
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================

//= json_getroute ==================================================
//-(JSON_getRoute_Handler)------------------------------------------

     async  function  JSON_getRoute_Handler( aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL ) {

                               logIP(   pReq, pDB, `GET  Route, '/${aRoute}'` )         // .(30526.02.15 RAM Use logIP)
                               sayMsg(  pReq, aMethod, aRoute )

       var  pArgs     =        chkArgs( pReq, pRes, pValidArgs );        if (!pArgs) { return }                                    // .(30511.02.8 RAM Error may be sent already)
       var  aSQL      =        chkSQL(  fmtSQL, pArgs )                                                                            // .(30403.06.8)
//     var  mRecs     =  await getData( pDB,   aSQL               ); if (mRecs[0] == 'error') { sndErr( pRes, mRecs[1] ); return } // .(30407.03.10)
//     var  mRecs     =  await getData( pDB,   aSQL, aRoute, pRes ); if (mRecs[0] == 'error') { sndErr( pRes, mRecs[1] ); return } // .(30407.03.11)
       var  mRecs     =  await getData( pDB,   aSQL, aRoute, pRes );  if (!mRecs) { return }                                       // .(30511.02.9 RAM Error may be sent already).(30407.03.12)
                               sndRecs( mRecs, aSQL, aRoute, pRes, "JSON_getRoute_Handler" )                                       // .(30407.03.13 RAM Moved pRes arg)

                               sayMsg( 'End' )                                          // .(30528.05.13)

         }; // eof JSON_getRoute_Handler
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================

//is.init = function( pApp_, bQuiet_ ) { ... }                                          //#.(30406.01.5)
//          pApp   =  pApp_  // express()                                               //#.(30406.01.5)
//is.init = function(       bQuiet_ ) { ... }                                           // .(30406.01.5)
this.init = function( bQuiet_, aAPI ) {                                                 // .(30412.02.14)

//    var { pDB_,     aAPI_Host_, bQuiet_ } = init( pApp, pDB_Config,       bQuiet_ );  // no workie without var, and must returned vars must be underlined
      var { pDB_,     aAPI_Host_, bQuiet_ } = init( pApp, pDB_Config, bQuiet_, aAPI );  // .(30412.02.15 RAM Override aAPI_Host here)
//          pDB    =  pDB_; aAPI_Host = aAPI_Host_, bQuiet = bQuiet_                    //#but only works for objects, not "singleton"s. Probably not true, just a theory
            pDB    =  pDB_; aAPI_Host = aAPI_Host_                                      // and must use underlined vars to reset globals

         }; // eof init
//--------  ------------------  =  --------------------------------- ------------------
//=====================================================================================

//this.start  = function( nPort ) { start( pApp, nPort, aAPI_Host ) }                  // .(30408.02.1)
this.start  = function( nPort, aAPI ) {                                                // .(30408.02.1 RAM Override aAPI_Host).(30412.02.16 RAM Not here)

            aAPI_Host = aAPI ? `/${ aAPI.replace( /^\//, '' ) }` : aAPI_Host           // .(30408.02.2).(30412.02.17)
            start( pApp, nPort, aAPI_Host )                                            // .(30412.02.18)

         }; // eof start
//--------  ------------------  =  --------------------------------- ------------------
//=========================================================================================================
     }; // eoc IODD
//========================================================================================================= #  ===============================  #

    export { IODD }
