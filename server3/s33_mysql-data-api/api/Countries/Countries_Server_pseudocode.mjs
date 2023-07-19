


GET  https://{host}/{_dataset}
GET  https://{host}/{_dataset}?id={id}
GET  https://{host}/{_dataset}?action=insert&id={id}
GET  https://{host}/{_dataset}?action=select&id={id}
GET  https://{host}/{_dataset}?action=update&id={id}
GET  https://{host}/{_dataset}?action=delete&id={id}

POST https://{host}/{_dataset}?action=insert&id={id}
POST https://{host}/{_dataset}?action=update&id={id}

GET  https://{host}/{_dataset}
GET  https://{host}/{_dataset}?id={id}
GET  https://{host}/{_dataset}?id={id,id,..}
GET  https://{host}/{_dataset}?{column}={value}
GET  https://{host}/{_dataset}?{column}={value,value,..}

GET  https://{host}/{_dataset}?action=insert&{column}={value}&{column}={value}...
GET  https://{host}/{_dataset}?action=select&id={id,id,..}&{column}={value}&{column}={value,value,..}...
GET  https://{host}/{_dataset}?action=update&id={id,id,..}&{column}={value}&{column}={value}...
GET  https://{host}/{_dataset}?action=delete&id={id,id,..}&{column}={value}&{column}={value,value,..}...



-----------------------------------------------------------------------------------------------------------------

this._DataSet_getRoute = function( ) {
       pApp.get( `${aAPI_Host}${aRoute}`,         async  function(                           pReq, pRes ) {

this._DataSet_getRoute = function( ) {
       pApp.get( `${aAPI_Host}${aRoute}`,               _DataSet_getRoute_Handler )
     async  function                                    _DataSet_getRoute_Handler(           pReq, pRes ) {

-----------------------------------------------------------------------------------------------------------------

this._DataSet_getRoute = function( ) {
            setRoute( pApp, 'get',  '/_dataset',         JSON_getRoute_Handler                          )
            }
-----------------------------------------------------------------------------------------------------------------

this._DataSet_getRoute = function( ) {
            setRoute( pApp, 'get',  '/_dataset',         JSON_getRoute_Handler,     aSQL                )
            setRoute( pApp, 'get',  '/_dataset',         JSON_getRoute_Handler,    `SELECT * FROM _dataset` )
            setRoute( pApp, 'get',  '/_dataset',         JSON_getRoute_Handler,     fmtSQL,  pValidArgs )
            setRoute( pApp, 'get',  '/_dataset',         JSON_getRoute_Handler,     pValidArgs,  fmtSQL )
            setRoute( pApp, 'get',  '/_dataset',         JSON_getRoute_Handler,     pValidArgs, (pArgs) => { return fmtSQL( pArgs ) } )
            setRoute( pApp, 'get',  '/_dataset',         JSON_getRoute_Handler,    {id: /[0-9]+/},  `SELECT * FROM _dataset WHERE id = ${pArgs.id}` )
            }
-----------------------------------------------------------------------------------------------------------------

this._DataSet_getRoute = function( ) {
            setRoute( pApp, 'get',  '/_dataset',        _DataSet_getRoute_Handler                                                     )
            setRoute( pApp, 'get',  '/_dataset',        _DataSet_getRoute_Handler   pValidArgs, (pArgs) => { return fmtSQL( pArgs ) } )
            setRoute( pApp, 'get',  '/_dataset',        _DataSet_getRoute_Handler, {id: /[0-9]+/},  `SELECT * FROM _dataset WHERE id = ${pArgs.id}` )

     async  function                                    _DataSet_getRoute_Handler(  aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            }
        }
-----------------------------------------------------------------------------------------------------------------

this._DataSet_postRoute = function( ) {
            setRoute( pApp, 'post', '/_Dataset',        _DataSet_postRoute_Handler                          )
            setRoute( pApp, 'post', '/_Dataset',        _DataSet_postRoute_Handler, pValidArgs              )
            setRoute( pApp, 'post', '/_Dataset',        _DataSet_postRoute_Handler, pValidArgs,  fmtSQL     )
            setRoute( pApp, 'post', '/_Dataset',        _DataSet_postRoute_Handler, fmtSQL,      pValidArgs )

     async  function                                    _DataSet_postRoute_Handler( aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            }
        }
-----------------------------------------------------------------------------------------------------------------

     async  function                                     JSON_getRoute_Handler(     aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {

-----------------------------------------------------------------------------------------------------------------





//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------

this.Countries1_getRoute = function( ) {
       pApp.get( `${aAPI_Host}/countries1`,       async  function(                              pReq, pRes    ) {
            ...
            }
//   -----  -------------------------------------------  ----------------------------  ---------------------------
         }
//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------

this.Countries2_getRoute = function( ) {
       pApp.get( `${aAPI_Host}/countries2`,              Countries_getRoute_Handler )
     async  function                                     Countries_getRoute_Handler(            pReq, pRes    ) {
            ...
            }
//   -----  -------------------------------------------  ----------------------------  ---------------------------
         }
//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------

this.Countries3_getRoute = function( ) {
            setRoute( pApp, 'get',  '/contries3',        JSON_getRoute_Handler1                                )
            }
//   -----  -------------------------------------------  ---------------------------  ---------------------------, ----------, -----------------------

     async  function                                     JSON_getRoute_Handler1(       aMethod, pReq, pRes, aRoute ) {
            ...
            }
//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------

this.Countries4_getRoute = function( ) {
            setRoute( pApp, 'get',  '/countries4',       JSON_getRoute_Handler,        aSQL                    )
            setRoute( pApp, 'get',  '/countries4',       JSON_getRoute_Handler,       `SELECT * FROM _dataset` )
            setRoute( pApp, 'get',  '/countries4',       JSON_getRoute_Handler,        fmtSQL,  pValidArgs     )
            setRoute( pApp, 'get',  '/countries4',       JSON_getRoute_Handler,        pValidArgs,  fmtSQL     )
            setRoute( pApp, 'get',  '/countries4',       JSON_getRoute_Handler,        pValidArgs, (pArgs) => { return fmtSQL( pArgs ) } )
            setRoute( pApp, 'get',  '/countries4',       JSON_getRoute_Handler,       {id:/[0-9]+/}, `SELECT * FROM _dataset WHERE id = ${pArgs.id}` )
            }
//   -----  -------------------------------------------  ----------------------------  ---------------------------, ----------, -----------------------

     async  function                                     JSON_getRoute_Handler(        aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            }
//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------

this.Countries5_getRoute = function( ) {
            setRoute( pApp, 'get',  '/countries5',       Countries5_getRoute_Handler                           )
            setRoute( pApp, 'get',  '/countries5',       Countries5_getRoute_Handler,  pValidArgs              )
            setRoute( pApp, 'get',  '/countries5',       Countries5_getRoute_Handler,  pValidArgs,  fmtSQL     )
            setRoute( pApp, 'get',  '/countries5',       Countries5_getRoute_Handler,  fmtSQL,      pValidArgs )

//   -----  -------------------------------------------  ----------------------------  ---------------------------, ----------, -----------------------

     async  function                                     Countries5_postRoute_Handler( aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            }
//   -----  -------------------------------------------  ---------------------------  ---------------------------, ----------, -----------------------
        }
//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------

this.Countries5_postRoute = function( ) {
            setRoute( pApp, 'post', '/countries5',       Countries5_postRoute_Handler                          )
            setRoute( pApp, 'post', '/countries5',       Countries5_postRoute_Handler, pValidArgs              )
            setRoute( pApp, 'post', '/countries5',       Countries5_postRoute_Handler, pValidArgs,  fmtSQL     )
            setRoute( pApp, 'post', '/countries5',       Countries5_postRoute_Handler, fmtSQL,      pValidArgs )

//   -----  -------------------------------------------  ----------------------------  ---------------------------, ----------, -----------------------

     async  function                                     Countries5_postRoute_Handler( aMethod, pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            }
//   -----  -------------------------------------------  ---------------------------  ---------------------------, ----------, -----------------------
        }
//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------

this.Countries_getRoute = function( ) {

        var aAction = chkAction( pReq )
            setRoute( pApp, 'get', '/countries',         Countries_getRoute_Handler,               aAction )

     async  function                                     Countries_getRoute_Handler(   pReq, pRes, aAction ) {
          switch( aAction ) {
            case 'insert':                               Countries_getInsert_Handler(  pReq, pRes, aRoute, pValidArgs, fmtInsertSQL ); break;
            case 'select':                               Countries_getSelect_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSelectSQL ); break;
            case 'update':                               Countries_getUpdate_Handler(  pReq, pRes, aRoute, pValidArgs, fmtUpdateSQL ); break;
            case 'delete':                               Countries_getDelete_Handler(  pReq, pRes, aRoute, pValidArgs, fmtDeleteSQL ); break;
              }
            } // eof Countries_getRoute_Handle
//   -----  -------------------------------------------  ----------------------------  -----------------, ----------, -----------------------

     async  function                                     Countries_getInsert_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            } // eof Countries_getInsert_Handler
//   -----  -------------------------------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function                                     Countries_getSelect_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            } // eof Countries_getSelect_Handler
//   -----  -------------------------------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function                                     Countries_getUpdate_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            } // eof Countries_getUpdate_Handler
//   -----  -------------------------------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function                                     Countries_getDelete_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            } // eof Countries_getDelete_Handler
//   -----  -------------------------------------------  ----------------------------  ------------------, ----------, -----------------------

         }  // eof Countries_getRoute
//--------  -------------------------------------------  ----------------------------------------------------------------------------------------------

this.Countries_postRoute = function( ) {

        var aAction = chkAction( pReq )

            setRoute( pApp, 'get', '/countries',        Countries_postRoute_Handler,               aAction )
     async  function                                    Countries_postRoute_Handler(   pReq, pRes, aAction ) {
          switch( aAction ) {
            case 'insert':                              Countries_postInsert_Handler(  pReq, pRes, aRoute, pValidArgs, fmtInsertSQL ); break;
            case 'update':                              Countries_postUpdate_Handler(  pReq, pRes, aRoute, pValidArgs, fmtUpdateSQL ); break;
              }
            } // eof Countries_postRoute_Handle
//   -----  -------------------------------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function                                     Countries_postInsert_Handler( pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            } // eof Countries_postInsert_Handler
//   -----  -------------------------------------------  ----------------------------  ------------------, ----------, -----------------------

     async  function                                     Countries_postUpdate_Handler( pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            } // eof Countries_postUpdate_Handler
//   -----  -------------------------------------------  ----------------------------  ------------------, ----------, -----------------------
         }  // eof Countries_postRoute
//--------  -------------------------------------------  --------------------------------------------------------------------------------------------------------



