import Agencies from './Agencies_APIs_u2.06.mjs'

       var  pApp       =  express()                  
       var  aAPI_Host

       var  pServer    =  new Ageencies( pApp )      

      var { aAPI_Host_: aAPI_Host, bQuiet_: bQuiet } = init( pApp, bQuiet, aAPI );  

            pServer.setRoutes(  aAPI_Host )                                         

            start( pApp, nPort, aAPI_Host , 'agencies/test' )  

export default new Agencies 

