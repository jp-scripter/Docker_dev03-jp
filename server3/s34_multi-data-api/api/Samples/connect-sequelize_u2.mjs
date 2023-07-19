   import { dbConnect }   from    './assets/MJSs/db.connect_u4.01.mjs';   

   import { getEnv    }   from    './assets/MJSs/formr_utility-fns_u1.06.mjs';   

//          console.log( getEnv ) 
//          process.env.NODE_NO_WARNINGS = 1;      // No worki, nor does DB_Logging = false 

//     var  pEnv =  await getEnv(  'api/.env'  )   // not found  
       var  pEnv =  await getEnv( '.env', true )   // Just the contents of .env 
//     var  pEnv =  await getEnv(  '',    true )   // Just the contents of .env 
//     var  pEnv =  await getEnv( )                // All environment vars plus .env 

            console.log( pEnv )
  
//        ( async function( ) { 

      var { Sequelize,   pDB } = dbConnect( pEnv ) // , 'checkDB' ) 
            console.log( pDB )
       var  pResult =  await pDB.query( "select count(*) from AGENCY_INFO" )
            console.log( "metaData[0]", pResult[1][0] )
            console.log( "    rows[0]", pResult[0][0] )

//          } )( )
     