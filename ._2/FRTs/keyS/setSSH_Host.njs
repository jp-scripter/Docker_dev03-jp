/*\
##=========+====================+================================================+
##RD         setSSH_Host        | Set Host Alias in SSH Confile file
##RFILE    +====================+=======+=================+======+===============+
##FD   JPT21-setSSH_Host.njs    |   9479|  7/07/21  1:48a |   136| v1.5.81008.01
##DESC     .--------------------+-------+-----------------+------+---------------+
#            This NodeJS script modifies the Host Alias configurations in the
#            ~/.ssh/config file
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2021 8020Data-JPT * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#            setSSH_Host        | ( )
#            fmtSSH_Config      | ( aHost_, aHostName, aUserID, aKeyFile )
#            getSSH_Cfgs        | ( aConfigFile )
#            putHost            | ( aLine, i )
#            sayHosts           | ( nQT_ )
#            sayHost            | ( aHost  )
#            fmtHostAlias       | ( aHostName_, aUserID_, aResource, aKeyOwner_, nWdt )
#            getHostAlias       | ( aHostName_ )
#            getHostUser        | ( aAccount )
#            sayMsg             | ( aMsg, bDebug1 )
#            getArg             | ( nArg )
#            fmtObj             | ( pObj )
#            ifExists           | ( aFilePath )
#            getFile            | ( aFilePath )
#            savFile            | ( aFilePath, aText )
#            getDir             | ( aDir, aFilter )
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(10705.02  7/05/21 RAM  2:00p| Check in Config file exists
# .(10705.03  7/05/21 RAM  3:00p| Split aHostName by _ into Args
# .(10705.04  7/05/21 RAM  4:00p| Keep aHostName global)
# .(10705.05  7/05/21 RAM  5:00p| Fix aHost Alias Name creation
# .(10705.08  7/05/21 RAM  8:00p| Make setSSH_Host async for await GetDir
# .(10705.09  7/05/21 RAM  9:00p| Display config after setting it
# .(10706.03  7/06/21 RAM  3:00p| Add blank line
# .(10707.03  7/07/21 RAM  3:00p| Need ifExists cover to deal with Windows filename
# .(10707.05  7/07/21 RAM  5:00p| Remove trailing blank lines, then add one
# .(10707.06  7/07/21 RAM  6:00p| Keep aUserID and aKeyOwner global
# .(10707.07  7/07/21 RAM  7:00p| Very Wierd. What are they in calling program?
# .(10707.08  7/08/21 RAM  9:15a| Sort SSH Configurations
# .(10715.01  7/15/21 RAM  1:00p| Added sayMsg( "", aMsg, bDebug)
# .(10715.02  7/15/21 RAM  2:00p| Remove Top Level names

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
\*/
            bDoit       =  false
            bDebug      =  false
            b1stMsg     =  0
            TheTime     =  new Date; TheTime = String(TheTime).replace( /GMT-[0-9]{4} /, '' ); // sayMsg( `TheTime: ${TheTime}'`, 2 )

            aHome       =  process.env.HOME ? process.env.HOME : process.env.USERPROFILE  // No trailing /
            aHome       =  aHome.replace( /C:/, '/C' ).replace( /\\/g, '/' ); // sayMsg( `setSSH_Host[  0]  aHome: '${aHome}'`, 2 )

//          ---------------------------------------------------------------------

      if ( 'test' != 'test' ) {
            process.argv[ 2 ] = 2
            }

               setSSH_Host( )                                                                               // .(10705.08.1)

async function setSSH_Host( ) {                                                                             // .(10705.08.2 RAM)

       var  nKeyNo      =  getArg( 1 );         //  sayMsg( `setSSH_Host[  1]  nKeyNo:  ${nKeyNo}, nLastArg: ${nLastArg}`, 1 )
       var  bPassWd     =  nKeyNo.match( /^[0-9]+$/ ) ? 0 : 1; if (bPassWd) { nLastArg--; nKeyNo = '' }
                                                //  sayMsg( `setSSH_Host[  1]  nKeyNo:  ${nKeyNo}, nLastArg: ${nLastArg}, bPassWd: ${bPassWd}`, 2 )

            aHostName   =  getArg( 2 )                                                                      // .(10705.04.1 RAM Keep it global)
            aUserID     =  getArg( 3 )                                                                      // .(10707.06.1 RAM Keep it global)
       var  aResource   =  getArg( 4 )
            aKeyOwner   =  getArg( 5 )                                                                      // .(10707.06.2 RAM Keep it global)
//          sayMsg( `setSSH_Host[  2]  nKeyNo: '${nKeyNo}', aHostName: '${aHostName}', aUserID: '${aUserID}', aResource: '${aResource}', aKeyOwner: '${aKeyOwner}', bDoit: ${bDoit}, bDebug: ${bDebug}`, 1)

        if (aHostName.match( /_/ )) {                                                                       // .(10705.03.1 RAM Beg)
       var  mNames      =  aHostName.split( /_/ )
            aHostName   =  mNames[0] ? mNames[0] : aHostName
            aUserID     =  mNames[1] ? mNames[1] : aUserID
            aResource   =  mNames[2] ? mNames[2] : aResource
            aKeyOwner   =  mNames[3] ? mNames[3] : aKeyOwner
            }                                                                                               // .(10705.03.1 End)
        if (aKeyOwner  == "") {
            aKeyOwner   =  aResource      // Assumes Host is s Server, not a Repo
            aResource   =  ""
            }
//          ---------------------------------------------------------------------

        if (bPassWd) {

//          sayMsg( `setSSH_Host[  3]  nKeyNo: '${nKeyNo}', aHostName: '${aHostName}', aUserID: '${aUserID}', aResource: '${aResource}', aKeyOwner: '${aKeyOwner}', bDoit: ${bDoit}, bDebug: ${bDebug}`, 2 )

        if (aHostName  == "") {
            sayMsg( "You must provde a Hostname for a Host Alias that uses a Password.", 2 )
            }
//          aKeyOwner   =  aResource
//          aKeyOwner   =  aUserID
//          aUserID     =  aResource
        var aHost2      =  fmtHostAlias( aHostName, aUserID, '', aKeyOwner )
        var aHost       =  aHost2.replace( /-account/, '' )

        var aKeyFile    =  ''
        var aMsg        = "SSH Password Alias"
            sayMsg( "", 3 )                                                                                 // .(10706.03.1 RAM)

        } else { // eif bPassWd == true
//          ---------------------------------------------------------------------

//          sayMsg( `setSSH_Host[  4]  nKeyNo: '${nKeyNo}', aHostName: '${aHostName}', aUserID: '${aUserID}', aResource: '${aResource}', aKeyOwner: '${aKeyOwner}', bDoit: ${bDoit}, bDebug: ${bDebug}`, 1 )

//     var  mKeys       =  getDir( `~/.ssh`,                /\.pub/ );    // sayMsg( `setSSH_Host[  5]  mKeys: '${aHome}/.ssh'`, 2 )
       var  mKeys = await  getDir( `${aHome}/.ssh`, '[0-9]_key.pub' );    // sayMsg( `setSSH_Host[  6]  mKeys: '${ fmtObj( mKeys ) }'`, 2 )

       var  aKeyFile    =  mKeys[ nKeyNo - 1 ];                           // sayMsg( `setSSH_Host[  7]  aKeyFile: '${ aKeyFile }'`, 1 )
      if (! aKeyFile)   {  sayMsg( `There is no '_key.pub' key file in '${aHome}/.ssh' for KeyNo, ${nKeyNo}`, 2 ) }

        if (aHostName  == "") {
            aHostName   =  aKeyFile.replace( /^.+@/, '' ).replace( /_a.+/, '' )

        if (aHostName.match( /_/ )) {                                                                       // .(10705.03.1 RAM Beg)
            mNames      =  aHostName.split( /_/ )
            aHostName   =  mNames[0] ? mNames[0] : aHostName
            aUserID     =  mNames[1] ? mNames[1] : aUserID
            aResource   =  mNames[2] ? mNames[2] : aResource
            aKeyOwner   =  getHostUser( aKeyFile.replace( /@.+/, '' ) )
            }                                                                                               // .(10705.03.1 End)
        if (aUserID    == "") {
            aUserID     =  aKeyFile.replace( /@.+/, '' )
            }
        if (aKeyOwner  == "") {
            aKeyOwner   =  aResource      // Assumes Host is a Server, not a Repo
            aResource   =  ""
            } }

//          sayMsg( `setSSH_Host[  8]  nKeyNo: '${nKeyNo}', aHostName: '${aHostName}', aUserID: '${aUserID}', aResource: '${aResource}', aKeyOwner: '${aKeyOwner}', bDoit: ${bDoit}, bDebug: ${bDebug}`, 1 )

        if (aUserID    == "") {
//          sayMsg( "You must provde a UserID.",   2 )
            aUserID     =  aKeyFile.replace( /@.+/,  '' )
            }
                                                                  sayMsg( `setSSH_Host[  9]  aHost:       ${aHost }, aHostName: '${ aHostName }'`,  )
       var  aHost2      =  fmtHostAlias( aHostName,  aUserID,  aResource,  aKeyOwner, 45 )
       var  aHost       =  aHost2.replace( /-account/, '' );   // sayMsg( `setSSH_Host[ 10]  aHost2:      ${aHost2}, aHostName: '${ aHostName }', aKeyOwner: '${ aKeyOwner }'`, 1 )

        if (aHost.match( /github/ )) {
//          aHostName   = 'github.com'
            aUserID     = 'git'
            }
       var  aMsg        = "SSH Keyfile Alias"

            } // eif bPassWd == false
//          ---------------------------------------------------------------------
                                                               // sayMsg( `setSSH_Host[ 11]  aHost:      ${ `'${aHost}'`.padEnd( 46 ) }, aHostName: '${aHostName}', aUserID: '${aUserID}'`, 1 )
                                                                  sayMsg( `setSSH_Host[ 12]  aKeyFile:   ${ `'${aKeyFile}'` }` )

       var  aConfigFile = `${aHome}/.ssh/config`;              // sayMsg( `setSSH_Host[ 13]  aConfigFile:   '${aConfigFile}'`,  1 )

       var  pConfig     =  fmtSSH_Config( aHost2, aHostName, aUserID, aKeyFile )
                                                               // sayMsg( `setSSH_Host[ 14]  pConfig:\n${ fmtObj( pConfig ) }`, 2 )
                                                               // sayMsg( `\n  - setSSH_Host[ 15] '${aHost}':\n${ pConfig[ aHost ] }` )
       var  pConfigs    =  getSSH_Cfgs( aConfigFile );            sayMsg( `\n  - setSSH_Host[ 16]  pConfigs.length: ${ Object.keys( pConfigs ).length }` )

            sayMsg( "", 3 )                                                                                 //#.(10706.03.1 RAM)
        if (pConfigs[ aHost ]) {
            sayMsg( `${ bDoit ? "" : "Not " }Replacing ${aMsg}, ${ `'${aHost}',`.padEnd(0) } in ${ aConfigFile}`, 1 )
            pConfig[ aHost ] += "\n"
        } else {
            sayMsg( `${ bDoit ? "" : "Not " }Adding    ${aMsg}, ${ `'${aHost}',`.padEnd(0) } to ${ aConfigFile }`, 1 )
            }

            pConfigs[  aHost ] = pConfig[ aHost ];              // sayMsg( `\n  - setSSH_Host[ 17]  pConfig:\n${ fmtObj( pConfig ) }`, 1 )
            pConfigs    =  srtConfigs( pConfigs )               // sayMsg( `\n  - setSSH_Host[ 17]  pConfig:\n${ fmtObj( pConfig ) }`, 1 )

            aHostLines = ""
            Object.keys( pConfigs ).forEach( ( aHost ) => { aHostLines += pConfigs[ aHost ] } )

        if (bDoit) {
//          sayMsg( `aHostLines:\n ${aHostLines}`, 1 )
            savFile( `${aHome}/.ssh/config`, aHostLines.replace( /[\n]+$/, '' ) + '\n' )                    // .(10707.05.1 RAM Added final \n)
        } else {
            sayMsg( "Add \"doit\" to the command to update SSH Config file.", 1 )
            }

            console.log( "\n  " + pConfig[ aHost ].replace( /\n+$/, '' ).replace( /\n/g, "\n ")  )          // .(10705.09.1 RAM)

            } // eof await setSSH_Host                                                                      // .(10705.08.3)
//---------------------------------------------------------------------------------------------------------------------

  function  fmtSSH_Config( aHost_, aHostName, aUserID, aKeyFile ) {

       var  aHost       =  aHost_.replace( /-account/, '' );
       var  aHost2      =  aHost                                                                            // .(10707.07.1 RAM Very Wierd. What are they in calling program?)
        if (aHost != aHost_) {
       var  aHost2      =  aHost + ' ' + aHost_
            }
       var  aConfig     = 'Host {Host}\n'
                        + '   HostName       {HostName}\n'
           + ( aKeyFile ? '   IdentityFile   {KeyFile}\n'
                        + '   IdentitiesOnly yes\n'       : '' )
                        + '   User           {UserID}\n'
                        + '   Port           22\n'
                        + '#  UpdatedOn      {UpdatedOn}\n'

            aConfig     =  aConfig.replace( /{Host}/      ,  aHost2    )
            aConfig     =  aConfig.replace( /{HostName}/  ,  aHostName )
            aConfig     =  aConfig.replace( /{KeyFile}/   ,  aHome + '/.ssh/' + aKeyFile.replace( /\.pub/, '' )  )
            aConfig     =  aConfig.replace( /{UserID}/    ,  aUserID   )
            aConfig     =  aConfig.replace( /{UpdatedOn}/ ,  TheTime  )

       var  pConfig     = { }
            pConfig[ aHost ] = aConfig
    return  pConfig
            }
//--------  ----------- = -- -------------------------------------

  function  getSSH_Cfgs( aConfigFile ) {
                                                               // sayMsg( `getSSH_Cfgs[  1]  aConfigFile: '${ aConfigFile }'`, 2 )
                                                               // sayMsg( `getSSH_Cfgs[  1]  Exists: '${ ifExists( aConfigFile ) }'`, 2 )
       var  aConfig     = ''                                                                                // .(10705.02.1)
//      if (require( 'fs' ).existsSync( aConfigFile )) { ... }                                              //#.(10705.02.2 RAM).(10707.03.1)
        if (ifExists( aConfigFile )) {                                                                      // .(10705.02.2 RAM).(10707.03.1 RAM)
       var  aConfig     =  getFile( aConfigFile ).replace( /[\n]+$/, '' ) + '\n'
            }                                                                                               // .(10705.02.3)
                                                               // sayMsg( `getSSH_Cfgs[  1]  aConfig: '${ aConfig }'`,  )
       var  mLines      =  aConfig.split( '\n' );                 sayMsg( `getSSH_Cfgs[  2]  mLines.length: ${ mLines.length }` )
       var  pConfigs    =  { }, aHost, aHostLines

            mLines.forEach( putHost )

        if (aHost) {                                              sayMsg( `getSSH_Cfgs[  3]  aHost: '${ aHost }'` )
            pConfigs[ aHost ] = aHostLines  // the last Host
            }
                                                   sayHosts( 9 ); sayMsg( `getSSH_Cfgs[  4]  pConfigs.length: ${ Object.keys( pConfigs ).length }` )
    return  pConfigs

//--------  ----------- = -- -------------------------------------

   function putHost( aLine, i ) {

        if (aLine.match( /^Host /)) {
        if (i > 2) {                                              sayMsg( `putHost[      1]  aHost: '${ aHost }'` )
            pConfigs[ aHost ] = aHostLines
            }
            aHost      = `${aLine} `.split( / / )[1]
            aHostLines = ''
            } // eif aLine.match( /^Host /)

            aHostLines += aLine + '\n'
            } // eof getHost
//--------  ----------- = -- -------------------------------------

   function sayHosts( nQT_ ) { nQT = nQT_
            Object.keys( pConfigs ).forEach( sayHost ); sayHost( "", nQT )
            }
//--------  ----------- = -- -------------------------------------

   function sayHost( aHost  ) {
            sayMsg( `\n  - sayHost[      1]  aHost '${ aHost }'`, nQT );
//          sayMsg( `\n  - sayHost[      1]  \n${ pConfigs[ aHost ].replace( /[\n]+$/, '' ) }`, nQT );
            } // sayHost
//--------  ----------- = -- -------------------------------------
            } // eof getSSH_Cfgs
//  ------  ----------- = -- -------------------------------------------------------

  function  srtConfigs( pConfigs ) {
       var  mConfigs =  Object.keys( pConfigs ).sort( srtConfig )
    return  mConfigs.map( aConfig => { return pConfigs[ aConfig ] } )
   function srtConfig( aConfig ) {
        var pConfig = pConfigs[ aConfig ]
     return true
            }
            }

  function  fmtHostAlias( aHostName_, aUserID_, aResource, aKeyOwner_, nWdt ) {
//          sayMsg(   `fmtHostAlias[ 1]  aHostName:  '${aHostName}', aUserID: '${aUserID}', aRepo: '${aResource}', aKeyOwner: '${aKeyOwner}'`, 1 )

            aHost       = ''
        if (aHostName_) {
            aHost       =                getHostAlias(  aHostName_ )
//          sayMsg(   `fmtHostAlias[ 2]  aHostAlias:  ${ aHost.padEnd( nWdt ) }, aHostName: '${aHostName}'`, 1 )
            }
            aUserID     =                getHostUser(   aUserID_ )
            aHost       = `${ aHost }-${ aUserID }`
//          sayMsg(   `fmtHostAlias[ 3]  aHostAlias:  ${ aHost.padEnd( nWdt ) }, aUserID:   '${aUserID}'` ,  1 )
        if (aResource) {
            aHost       = `${ aHost }-${ aResource }`
//          sayMsg(   `fmtHostAlias[ 4]  aHostAlias:  ${ aHost.padEnd( nWdt ) }, aRepo:     '${aResource}'`    )
            }
        if (aKeyOwner) {
            aKeyOwner   =                getHostUser(   aKeyOwner_ )
        if (aKeyOwner != aUserID) {
            aHost       = `${ aHost }-${ aKeyOwner }` }
        } else {
            aHost       = `${ aHost }-account`
            }
        if (aUserID == "") { // b1stMsg = 1
            sayMsg( "", "You must provide a HostUser ID", 2 )
            }
            sayMsg(   `fmtHostAlias[ 5]  aHostAlias:  ${ aHost.padEnd( nWdt ) }, aHostName: '${aHostName}'`, )
     return aHost
            }
//  ------  ----------- = -- -------------------------------------------------------

  function  getHostAlias( aHostName_ ) {
//                                                                sayMsg( `getHostAlias[ 1]  aHostName_: '${ aHostName_ }'`, 1 )

       var  pHostAliases= { '155.138.238.18'    : 'et218t'  // Can't find 15 digis
                          , '155.138.162.24'    : 'et217d'
                          , '140.82.113.2'      : 'github'
                          , '140.82.113.3'      : 'github'
                          , '140.82.113.4'      : 'github'
                          , '10.211.160.167'    : 'sc167t'
                          , 'githib.com'        : 'github'
                             }
       var  pHostNames  = { 'github'            : 'github.com'                                              // .(10628.04.1 RAM Beg).(10707.05.1 RAM Change variable name. Was pNames)
                          , 'sc167t'            : '10.211.160.167'
                          , 'et217d'            : '155.138.162.247'
                          , 'et218t'            : '155.138.238.182'
                          , 'vultr-formr0'      : '155.138.162.247'
                          , 'formr0-vultr'      : '155.138.162.247'
                          , 'vultr-formr1'      : '155.138.238.182'
                          , 'formr1-vultr'      : '155.138.238.182'
                             }

       var  mNames      =    aHostName_.split( /[:\/,]/ )                                                   //#.(10707.05.2 RAM)
//                                                                sayMsg( `getHostAlias[ 2]  aHostName:  '${ aHostName }', aHostAlias: '${ aHostAlias }', mNames.length: ${ mNames.length }`,   )

        if (mNames.length >= 2) {                                                                           // .(10705.05.3)
       var  aHostAlias  =  mNames[0] ? mNames[0] : ''
            aHostName   =  mNames[1] ? mNames[1] : ''

        if (aHostAlias.match( /^[0-9]{1,3}\.[0-9]/ )) {        // {IPAddress}:{Name}
            aHostAlias  =  mNames[1] ? mNames[1] : ''
            aHostName   =  mNames[0] ? mNames[0] : ''
            }
            aHostName   =  aHostName ? aHostName : pHostNames[ aHostAlias.toLowerCase() ]
            aHostName   =  aHostName.toLowerCase()

//          aHostAlias  =  aHostAlias.toLowerCase()
//          aHostAlias  =  aHostAlias.replace( /(\.com|\.net|\.us|.\app)$/, '')                             // .(10715.02.1 RAM Remove Top Level names)
//                                                                sayMsg( `getHostAlias[ 2]  aHostName:  '${ aHostName }', aHostAlias: '${ aHostAlias }', mNames.length: ${ mNames.length }`, 2 )
//  return  aHostAlias
            }                                                                                               // .(10628.04.2)

/*     var  nPos        =    aHostName.indexOf( ':' )                                                       //#.(10707.05.2 Beg)
        if (nPos > 0) {
            aHostAlias  =    aHostName.substr( 0, nPos )
        if (aHostAlias.match( /^[0-9]{1,3}-[0-9]/ )) {        // {IPAddress}:{Name}
            aHostAlias  =    aHostName.substr( nPos )
            aHostName   =    aHostName.substr( 0, nPos )
    return  aHostAlias
        } else {                                              // {Name}:{IPAddress}
            aHostAlias  =    aHostName.substr( 0, nPos )
            aHostName   =    aHostName.substr( nPos )
    return  aHostAlias
        }   }                                                                                               //#.(10707.05.2 End)
*/
//          aHostAlias  =  aHostAlias.toLowerCase()
//          aHostName   =  aHostName.toLowerCase()

        if (mNames.length == 1) {                                                                           // .(10705.05.3)
            aHostName   =                            pHostNames[ aHostName_ ]                               // .(10705.05.1 RAM).(10707.05.1)
                                                               // sayMsg( `getHostAlias[ 3]  aHostName:  '${ aHostName }'`, 1 )
            aHostName   =  aHostName  ?  aHostName : pHostNames[ aHostName_.toLowerCase() ]                 // .(10705.05.1 RAM).(10707.05.1)
                                                               // sayMsg( `getHostAlias[ 4]  aHostName:  '${ aHostName }'`, 1 )
            aHostName   =  aHostName  ?  aHostName :             aHostName_.toLowerCase()                    // .(10705.05.4)
                                                               // sayMsg( `getHostAlias[ 5]  aHostName:  '${ aHostName }'`, 1 )


//      if (aHostName.match( /^[0-9]{1,3}\.[0-9]/ )) {        // {IPAddress}:{Name}
            aHostAlias  =  pHostAliases[ aHostName.substr( 0, 14 ) ];
                                                               // sayMsg( `getHostAlias[ 6]  aHostName:  '${ aHostName }', aHostAlias: '${ aHostAlias }'`, 1 )
//          }
//          aHostAlias  =  aHostAlias ?  aHostAlias : aHostName.substr( 0, 6 )   ;
            }                                                                                               // .(10705.05.5)
                                                               // sayMsg( `getHostAlias[ 7]  aHostName:  '${ aHostName }', aHostAlias: '${ aHostAlias }'`, 1 )

            aHostAlias  =  aHostAlias ?  aHostAlias : aHostName_.toLowerCase()
            aHostAlias  =  aHostAlias.replace( /(\.com|\.net|\.us|.\app)$/, '')                             // .(10715.02.2 RAM Remove Top Level names)

        if (aHostName.match( /\./ ) == null) {
            sayMsg(  "",  `The Hostname, '${aHostName}', doesn't appear to be a valid Internet Domain Name or IP Address.`, 2 )
            }
    return  aHostAlias
            }
//  ------  ----------- = -- -------------------------------------------------------

  function  getHostUser( aAccount ) {
            aAccount    =    aAccount.toLowerCase()
       var  pAccounts   = { 'brucetroutman-gmail': 'bruce'
                          , 'brucetroutman'      : 'bruce'
                          , 'bruce.troutman'     : 'bruce'
                          , 'robinmattern'       : 'robin'
                          , 'robin.mattern'      : 'robin'
                          , 'suzeeparker'        : 'suzee'
                          , 'suzee.parker'       : 'suzee'
                          , 'bruce'              : 'bruce'
                          , 'robin'              : 'robin'
                          , 'suzee'              : 'suzee'
                             }
       var  aHostUser     =  pAccounts[ aAccount ]
            aHostUser     =  aHostUser ? aHostUser : `${aAccount}`.replace( /\.+/, '' )
                                                                 sayMsg( `getHostUser[  3]  aHostUser:  '${ aHostUser }'`, )
    return  aHostUser
            }
//  ------  ----------- = -- -------------------------------------------------------

  function  sayMsg( aMsg, bDebug1, n3rdArg ) {                                                          // .(10715.01.1 RAM Added sayMsg( "", aMsg, bDebug))
        if (aMsg  == 'set debug')   {    bDebug = bDebug1; return; }
        var bDebug1  = (typeof( bDebug1) != 'undefined') ? bDebug1 :
                     ( (typeof( bDebug ) != 'undefined') ? bDebug  : 0 )
            b1stMsg  = (typeof( b1stMsg) != 'undefined') ? b1stMsg : 1
        if (aMsg   == "") { b1stMsg = b1stMsg != 1; aMsg = bDebug1; bDebug1 = n3rdArg }                 // .(10715.01.2)
        if (b1stMsg == 1) { console.log( "" );  b1stMsg  = 0;      }
        if (bDebug1 == 0) {                                return; }
        if (bDebug1 == 1) { console.log( `  - ${aMsg}`  ); return; }
        if (bDebug1 == 2) { console.log( ` ** ${aMsg}\n`); process.exit(); }
//      if (bDebug1 == -1 && bDebug  == 1) { console.log(     `${aMsg}`  ); return; }
        if (bDebug1 == -1 || bDebug1 == 3) { console.log(     `${aMsg}`  ); return; }
            }
//  ------  ----------- = -- -------------------------------------------------------

  function  getArg( nArg ) {
//          sayMsg( `getArg[ 1]  process.argv:\n${ fmtObj( process.argv ) }`, 2 )

        if (nArg ==  1) {   nLastArg = 1 }
       var  aArg        =   String( process.argv[  nLastArg + nArg ] ); // sayMsg( `getArg[2]  nLastArg: ${nLastArg} + ${nArg}`, 1 )
//     if (!aArg) { return  aArg };                                     // sayMsg( `getArg[3]  aArg: '${ aArg }'`, 1 )  //#.(10707.05.1)
        if (aArg == 'undefined') { return  '' };                        // sayMsg( `getArg[3]  aArg: '${ aArg }', nLastArg: ${nLastArg}`, 1 )  // .(10707.05.1 RAM)

        if (aArg.match(  /doit|dont/i )) { bDoit   = aArg.match( /doit/i  ) != null; nLastArg++; // sayMsg( `bDoit:  ${bDoit},  nArg: ${ nLastArg  + nArg - 1 }`, 1 )
            aArg        =   process.argv[  nLastArg + nArg ] }

        if (aArg.match( /debug|dont/i )) { bDebug  = aArg.match( /debug/i ) != null; nLastArg++; // sayMsg( `bDoit:  ${bDoit},  nArg: ${ nLastArg  + nArg - 1 }`, 1 )
            aArg        =   process.argv[  nLastArg + nArg ] }

    return (typeof(aArg) != 'undefined') ? aArg : ''
            }
//  ------  ----------- = -- -------------------------------------------------------

  function  fmtObj( pObj ) {
    return  require( 'util' ).inspect( pObj, {depth: 99 } )
            }
//  ------  ----------- = -- -------------------------------------------------------

  function  ifExists( aFilePath ) {                                     // sayMsg( `getExists[    1]  aFilePath: '${aFilePath}'`, 1 )
      try { aFilePath   =  aFilePath.replace( /\/([CDE])\//, '$1:/'  ); // sayMsg( `getExists[    1]  aFilePath: '${aFilePath}'`, 1 )
    return  require( 'fs' ).existsSync( aFilePath )
        } catch( pErr ) {  sayMsg( "getExists[    2]: Err:\n" + pErr, 1 ); return '' }
            }
//  ------  ----------- = -- -------------------------------------------------------

  function  getFile( aFilePath ) {                                      // sayMsg( `getFile[      1]  aFilePath: '${aFilePath}'`, 1 )
      try { aFilePath   =  aFilePath.replace( /\/([CDE])\//, '$1:/'  );
    return  require( 'fs' ).readFileSync( aFilePath, 'ASCII' )
        } catch( pErr ) {  sayMsg( "getFile[      2]: Err:\n" + pErr, 1 ); return '' }
            }
//  ------  ----------- = -- -------------------------------------------------------

  function  savFile( aFilePath, aText ) {
      try { aFilePath   =  aFilePath.replace( /\/([CDE])\//, '$1:/'  ); // sayMsg( `savFile[      1]  aFilePath: '${aFilePath}'`, 1 )
    return  require( 'fs' ).writeFileSync( aFilePath, aText, 'ASCII' )
        } catch( pErr ) {  sayMsg( "savFile[      2]: Err:\n" + pErr, 1 ) }
            }
//  ------  ----------- = -- -------------------------------------------------------

async function getDir( aDir, aFilter ) {                                                                    // .(10705.08.4)
       var  aDir   =  aDir.replace( /\/([CDE])\//, '$1:/' );             // sayMsg( `getDir[ 1]  aDir: '${aDir}'`, 1 )

      var { promisify } = require( 'util' );                                                                // .(10705.08.5 Beg)
       var  exec   =  promisify( require( 'child_process' ).exec )
       var  aCmd   = `rdir -s 2 "${aDir}" ${ aFilter }`;                // sayMsg( `getDir[ 2]  aCmd: '${aCmd}'`, 2 )
       var  pResult=  await exec( aCmd )
       var  mFiles =  pResult.stdout.split( "\n" )
//          mFiles =  mFiles.filter( aFile => { return aFile.match( /_key/ ) != null } )
            mFiles =  mFiles.filter( aFile => { return aFile.match( aFilter ) != null } )
            mFiles =  mFiles.map(    aFile => { return aFile.replace( /.+\.ssh\//, '' ) } )                 // .(10705.08.5 End)
//          sayMsg(  "getDir[ 3]  mFiles:\n" + mFiles.join( "\n" ), 1 )
/*
       var  mFiles =  require( 'fs' ).readdirSync( aDir  )
        if (aFilter) {
       var  pRE    =  new RegExp( aFilter )
            mFiles =  mFiles.filter( ( aFile ) => { return aFile.match( pRE ) } )
            } */
    return  mFiles
            }
//---------------------------------------------------------------------------------------------------------------------

/*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
\*/


//          sayMsg( "set debug", 1 ); b1stMsg = 0

//          sayMsg( "set debug", 1 ); console.log( `bDebug: ${bDebug}` )
//          sayMsg( "hello"        )
//          sayMsg( "hello 0",   0 )
//          sayMsg( "hello 1",   1 )
//          sayMsg( "hello -1", -1 )
//          sayMsg( "hello 2",   2 )
