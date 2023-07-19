       var  oracledb  = require(  'oracledb' );

       var  pConfig = 
                 {  user          :  'basic'     // pEnv.DB_UserId
                 ,  password      :  'testdba'   // pEnv.DB_Password
                 ,  connectString : "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.211.160.173)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SID=DEV)))"
                    };
  
          ( async function( ) { 

       var  pDB     =  await connect( pConfig ) 
            console.log( pDB )
       var  pResult =  await pDB.execute( "select count(*) from AGENCY_INFO" )
            console.log( "metaData[0]", pResult.metaData[0] )
            console.log( "    rows[0]", pResult.rows[0] )

            } )( )

     async  function connect( pConfig ) { 
//                     await oracledb.initOracleClient( { libDir: "C:/oracle/instantclient_19_3" } );
       var  pDB     =  await oracledb.getConnection( pConfig )  
    return  pDB 
            }

/*
Uncaught Error Error: DPI-1047: Cannot locate a 64-bit Oracle Client library: "The specified module could not be found". See https://oracle.github.io/node-oracledb/INSTALL.html for help
Node-oracledb installation instructions: https://oracle.github.io/node-oracledb/INSTALL.html
You must have 64-bit Oracle Client libraries in your PATH environment variable.
If you do not have Oracle Database on this computer, then install the Instant Client Basic or Basic Light package from https://www.oracle.com/database/technologies/instant-client/winx64-64-downloads.html
A Microsoft Visual Studio Redistributable suitable for your Oracle client library version must be available.  at processTicksAndRejections (internal/process/task_queues:95:5)
Process exited with code 1
*/
     