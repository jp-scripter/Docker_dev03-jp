// const { Sequelize } = require('sequelize');
//import { Sequelize }   from    'sequelize' ;

//import { oracledb  }   from    'oracledb'  ;
//   var   oracledb  = require(  'oracledb' );
//  import * as oracledb   from    'oracledb';

    import { getEnv    }   from    './assets/MJSs/formr_utility-fns_u1.06.mjs';   
//   var  getEnv = require( './assets/MJSs/formr_utility-fns_u1.06.mjs' ) 

    import { dbConnect }   from    './assets/MJSs/db.connect_u4.01.mjs';   

//   console.log( getEnv ) 


import { createRequire } from 'module';
    var  require  =  createRequire( import.meta.url );      

    var  oracledb =  require( 'oracledb' )



// Option 1: Passing a connection URI
/* const sequelize = new Sequelize(
       'oracle://basic:testdba@10.211.160.173:1521/dev'
        );
*/
// Option 2: Passing parameters separately
/* const sequelize = new Sequelize(<servicename>, <username>, <password>, {
        host: <ip>,
        port: <port>,
        dialect: 'oracle'
        });
*/         

// Option 3: Passing connection string, username, password
/* const sequelize = new Sequelize({
        dialect: 'oracle',
        username: <username>,
        password: <password>,
        dialectOptions: { connectString: <connection string> }
        });
*/ 

//     var  pEnv =  await getEnv(  'api/.env'  )   // not found  
       var  pEnv =  await getEnv( '.env', true )   // Just the contents of .env 
//     var  pEnv =  await getEnv(  '',    true )   // Just the contents of .env 
//     var  pEnv =  await getEnv( )                // All environment vars plus .env 

            console.log( pEnv )

//    var { Sequelize,  pDB } =  dbConnect( pEnv , 'checkDB' ) 

       var  pConfig = 
                 {  user          :  pEnv.DB_UserId
                 ,  password      :  pEnv.DB_Password
                 ,  connectString : "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.211.160.173)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SID=DEV)))"
                    } ;
  
//        ( async function( ) { 
       var  pDB     = await connect( pConfig ) 
            console.log( pDB )
       var  pResult =  await pDB.execute( "select count(*) from AGENCY_INFO" )
            console.log( "metaData[0]", pResult.metaData[0] )
            console.log( "rows[0]", pResult.rows[0] )
//          } )( )

     async  function connect( pConfig ) { 
       var  pDB     =  await oracledb.getConnection( pConfig )  
    return  pDB 
            }


//     var [results, metadata] = await pDB.query( "select count(*) from AGENCY_INFO");

// Results will be an empty array and metadata will contain the number of affected rows.

//   console.log( results )



     