// ------------------------------------------------------------------------------------------

   import  { Sequelize } from  'sequelize';                        // .(30610.03.1 RAM ES6 way).

function dbConnect( dbConfig, aCheckDB ) {                         // .(30610.03.2 RAM Pass as arg).(10121.02.3 RAM A connection for each Table?).(10928.02.1 RAM Add CheckDB option)         
// 
// const    Sequelize =  require( 'sequelize' );                   //#.(30610.03.1)

// const    dbConfig  =  getDbConfig( aDBSN )                      //#.(30610.03.2).(10220.01.1 RAM Move function into this script)

//          -------------------------------------------------------------------------

//          dbConfig.POOL          =   dbConfig.POOL               //#.(30610.03.3 Beg).(10220.02.1 Beg RAM Make POOL optional)
//                                 ?   dbConfig.POOL 
            dbConfig.POOL          = { min    : dbConfig.Pool_Min     ? dbConfig.Pool_Min     : 0
                                     , max    : dbConfig.Pool_Max     ? dbConfig.Pool_Max     : 5
                                     , idle   : dbConfig.Pool_Idle    ? dbConfig.Pool_Idle    : 10000
                                     , acquire: dbConfig.Pool_Acquire ? dbConfig.Pool_Acquire : 30000
                                       }                           // .(10220.02.1 End)
            
            dbConfig.Logging       =   dbConfig.DB_Logging         // .(10220.04.1 Beg RAM Add Logging option)
                                   ?   dbConfig.DB_Logging + ''
                                   :  'false'  
                                                                  
            dbConfig.Logging       =  (dbConfig.Logging == 'false'   ) ? false                      : dbConfig.Logging          // .(30621.01.1 RAM Fix Logger var)                  
            dbConfig.Logging       =  (dbConfig.Logging == 'true'   ) ? console.log                 : dbConfig.Logging                                      
            dbConfig.Logging       =  (dbConfig.Logging == 'custom' ) ? function( str ) { a = str } : dbConfig.Logging                                      
                                                                   // .(30610.03.3 End).(10220.04.1 End)

//          -------------------------------------------------------------------------

     try {
     var    dbOptions =
             {  host               :   dbConfig.DB_Host            // .(30610.03.4 Beg)
             ,  dialect            :   dbConfig.DB_Dialect         // .(10220.02.2 RAM Change to Uppercase)

//           ,  logging            :   console.log
//           ,  logging            :   function( str ) { console.log( str ) }, // do your own logging
//           ,  logging            :   function( str ) { a = str }
             ,  logging            :   dbConfig.Logging            // .(30610.03.4 End).(10220.04.2)
                
             ,  pool:                                              
                {  min             :   dbConfig.POOL.min
                ,  max             :   dbConfig.POOL.max           // .(10220.02.3 Beg)
                ,  idle            :   dbConfig.POOL.idle          // .(10220.02.3 End)
                ,  acquire         :   dbConfig.POOL.acquire
                   }
                }  // eob dbOptions 
//          -----------------------------------------------------------------

            dbOptions.dialectOptions =  { }                        // .(30610.03.5).
       if ( dbConfig.DB_DialectOptions) {                          // .(30610.03.5).
            dbOptions.dialectOptions = dbConfig.DB_DialectOptions  // .(30610.03.5).
            }

       if ( dbConfig.DB_ConnectString) {                           // .(30610.03.6 RAM Beg)
            dbOptions.dialectOptions.connectString = dbConfig.DB_ConnectString 
            }                                                      // .(30610.03.7 End)
//          -----------------------------------------------------------------

        var sequelize              =   new Sequelize (             // .(30610.03.4 RAM sequelize.config.logging not set??)
                dbConfig.DB_Database                               // .(30610.03.7)
             ,  dbConfig.DB_UserId                                 // .(30610.03.8)
             ,  dbConfig.DB_Password                               // .(30610.03.9)
             ,  dbOptions
                )
        } catch( e ) {
            console.log( `dbConnect[ 8] ** Error: the file, '${aConfigFile} contains invalid Sequelize options.` )
            process.exit()
//          throw `Error: dbConnect[ 8] ** Error: the file, '${aConfigFile} contains invalid Sequelize options.`      
            }        
//          -------------------------------------------------------------------------

        if (dbConfig.DB_DBSN) {                                    // .(30610.03.10 RAM Optional)
            sequelize.config.DBSN  =  dbConfig.DB_DBSN             // .(30610.03.11).(10110.01.3).(10220.03.1 RAM aDBSN is also in sequelize.config.DBSN)
            }                                                      // .(30610.03.12)

        if (aCheckDB == 'checkDB') {                               // .(10928.02.2 Beg RAM Check DB Connection)  
            chkConnect( sequelize )
            }                                                      // .(10928.02.1 End)  
//          -------------------------------------------------------------------------

  return {  pDB                    :  sequelize                    // .(30610.03.13).(10110.01.4)
         ,  Sequelize              :  Sequelize }

            } 

//    module.exports               =  dbConnect                    //#.(10121.02.3)
//          }                                                      //#.(10121.02.3)

// ------------------------------------------------------------------------------------------

//    module.exports = dbConnect                                   //#.(30610.03.13).(10121.02.3)
      export { dbConnect }                                         // .(30610.03.13)

// -------------------------------------------------

async function chkConnect( pDB ) {                                 // .(10928.02.4 Beg RAM Added).(21208.01.1 RAM It's an Object)

      var aDBSN  =  pDB.config.DBSN 
          aDBSN  =  aDBSN ? aDBSN : `${pDB.config.host}/${pDB.config.database}` 
    try { 
          await pDB.authenticate()  // sequelize.authenticate()
//        await pDB.query( 'select count(*) from agencies' )
        } catch( pErr ) {
            console.log( `  dbConnect[10] ** Error: Can't connect to DBSN: ${aDBSN}. **\n                   `, pErr.message ) // .(21208.01.2)
            process.exit()
        }   } 
// -------------------------------------------------

