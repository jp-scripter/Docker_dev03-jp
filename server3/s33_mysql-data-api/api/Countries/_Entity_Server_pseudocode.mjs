
GET  https://{host}/{_Entity}
GET  https://{host}/{_Entity}?id={id}
GET  https://{host}/{_Entity}?id={id,id,..}
GET  https://{host}/{_Entity}?{column}={value}
GET  https://{host}/{_Entity}?{column}={value,value,..}

POST https://{host}/{_Entity}?action=insert&id={id}
GET  https://{host}/{_Entity}?action=select&id={id}
POST https://{host}/{_Entity}?action=update&id={id}
GET  https://{host}/{_Entity}?action=delete&id={id}

GET  https://{host}/{_Entity}?action=insert&{column}={value}&{column}={value}...
GET  https://{host}/{_Entity}?action=select&id={id,id,..}&{column}={value}&{column}={value,value,..}...
GET  https://{host}/{_Entity}?action=update&id={id,id,..}&{column}={value}&{column}={value}...
GET  https://{host}/{_Entity}?action=delete&id={id,id,..}&{column}={value}&{column}={value,value,..}...



//========  ===========================================  ========================================================================================

this._Entity1_getRoute = function( ) {

       pApp.get( `${aAPI_Host}/entity1`,          async  function(                  pReq, pRes ) {
            ...
            }
//   -----  ------------------  =  --------------------  -------------------------  -------------------, ------------
         };
//--------  -------------------------------------------  -----------------------------  ------------------  ----------------------------


//========  ===========================================  ========================================================================================

this._Entity2_getRoute = function( ) {

       pApp.get( `${aAPI_Host}/entity2`,                _Entity2_getRoute_Handler )

//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------

     async  function                                    _Entity2_getRoute_Handler(  pReq, pRes ) {
            ...
            }
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------
         };
//--------  -------------------------------------------  -----------------------------  ------------------  ----------------------------


//========  ===========================================  ========================================================================================

this._Entity3_getRoute = function( ) {

            setRoute( pApp, 'get',  '/_entity3',         JSON_getRoute_Handler1                          )

//   -----  ------------------  =  --------------------  -------------------------  -------------------, ------------

     async  function                                     JSON_getRoute_Handler1(    pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            } // eof JSON_getRoute_Handler1
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------
         }; // eof _Entity3_getRoute
//--------  -------------------------------------------  -----------------------------  ------------------  ----------------------------


//========  ===========================================  ========================================================================================

this._Entity4_getRoute = function( ) {

            setRoute( pApp, 'get',  '/_entity4',         JSON_getRoute_Handler,     aSQL                )
            setRoute( pApp, 'get',  '/_entity4',         JSON_getRoute_Handler,    `SELECT * FROM _Entity` )
            setRoute( pApp, 'get',  '/_entity4',         JSON_getRoute_Handler,     fmtSQL,  pValidArgs )
            setRoute( pApp, 'get',  '/_entity4',         JSON_getRoute_Handler,     pValidArgs,  fmtSQL )
            setRoute( pApp, 'get',  '/_entity4',         JSON_getRoute_Handler,     pValidArgs, (pArgs) => { return fmtSQL( pArgs ) } )
            setRoute( pApp, 'get',  '/_entity4',         JSON_getRoute_Handler,   { id: /[0-9]+/ }, `SELECT * FROM _Entity WHERE id = ${pArgs.id}` )

         }; // eof _Entity3_getRoute
//--------  -------------------------------------------  -----------------------------  ------------------  ----------------------------

     async  function                                     JSON_getRoute_Handler(     pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            } // eof JSON_getRoute_Handler
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------


//========  ===========================================  ========================================================================================

this._Entity5_getRoute = function( ) {

            setRoute( pApp, 'get',  '/_entity5',        _Entity5_getRoute_Handler                                                     )
            setRoute( pApp, 'get',  '/_entity5',        _Entity5_getRoute_Handler   pValidArgs, (pArgs) => { return fmtSQL( pArgs ) } )
            setRoute( pApp, 'get',  '/_entity5',        _Entity5_getRoute_Handler, {id: /[0-9]+/},  `SELECT * FROM _Entity WHERE id = ${pArgs.id}` )

//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------

     async  function                                    _Entity5_getRoute_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSQL   ) {
            ...
            } // eof _Entity5_getRoute_Handler
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------
        }   // eof _Entity5_getRoute
//--------  -------------------------------------------  -----------------------------  ------------------  ----------------------------


//========  ===========================================  ========================================================================================

this._Entity6_postRoute = function( ) {

            setRoute( pApp, 'post', '/_entity6',        _Entity6_postRoute_Handler                          )
            setRoute( pApp, 'post', '/_entity6',        _Entity6_postRoute_Handler, pValidArgs              )
            setRoute( pApp, 'post', '/_entity6',        _Entity6_postRoute_Handler, pValidArgs,  fmtSQL     )
            setRoute( pApp, 'post', '/_entity6',        _Entity6_postRoute_Handler, fmtSQL,      pValidArgs )

//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------

     async  function                                    _Entity6_postRoute_Handler( pReq, pRes, aRoute, pValidArgs, fmtSQL ) {
            ...
            } // eof _Entity6_postRoute_Handler
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------
        }   // eof _Entity6_postRoute
//--------  -------------------------------------------  -----------------------------  ------------------  ----------------------------








//========  ===========================================  ========================================================================================

this._Entity_getRoute = function( ) {

        var aAction = chkAction( pReq )
            setRoute( pApp, 'get',  '/_entity',         _Entity_getRoute_Handlers,              aAction )

//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------

     async  function                                    _Entity_getRoute_Handlers(  pReq, pRes, aAction ) {
          switch( aAction ) {
            case 'insert':                              _Entity_getInsert_Handler(  pReq, pRes, aRoute, pValidArgs, fmtInsertSQL ); break;
            case 'select':                              _Entity_getSelect_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSelectSQL ); break;
            case 'update':                              _Entity_getUpdate_Handler(  pReq, pRes, aRoute, pValidArgs, fmtUpdateSQL ); break;
            case 'delete':                              _Entity_getDelete_Handler(  pReq, pRes, aRoute, pValidArgs, fmtDeleteSQL ); break;
              }
            } // eof _Entity_getRoute_Handlers
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------

     async  function                                    _Entity_getInsert_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSQL ) {
            ...
            } // eof _Entity_getInsert_Handler
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------

     async  function                                    _Entity_getSelect_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSQL ) {
            ...
            } // eof _Entity_getSelect_Handler
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------

     async  function                                    _Entity_getUpdate_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSQL ) {
            ...
            } // eof _Entity_getUpdate_Handler
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------

     async  function                                    _Entity_getDelete_Handler(  pReq, pRes, aRoute, pValidArgs, fmtSQL ) {
            ...
            } // eof _Entity_getDelete_Handler
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------
         }  // eof _Entity_getRoute
//--------  -------------------------------------------  -----------------------------  ------------------  ----------------------------


//========  ===========================================  ========================================================================================

this._Entity_postRoute = function( ) {

        var aAction = chkAction( pReq )

            setRoute( pApp, 'post', '/_entity',         _Entity_postRoute_Handlers,             aAction )

     async  function                                    _Entity_postRoute_Handlers( pReq, pRes, aAction ) {
          switch( aAction ) {
            case 'insert':                              _Entity_postInsert_Handler( pReq, pRes, aRoute, pValidArgs, fmtInsertSQL ); break;
            case 'update':                              _Entity_postUpdate_Handler( pReq, pRes, aRoute, pValidArgs, fmtUpdateSQL ); break;
              }
            } // eof _Entity_postRoute_Handlers
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------

     async  function                                    _Entity_postInsert_Handler( pReq, pRes, aRoute, pValidArgs, fmtSQL ) {
            ...
            } // eof _Entity_postInsert_Handler
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------


//--------  -------------------------------------------  -----------------------------  ------------------  ----------------------------

     async  function                                    _Entity_postUpdate_Handler( pReq, pRes, aRoute, pValidArgs, fmtSQL) {
            ...
            } // eof _Entity_postUpdate_Handler
//   -----  ------------------  =  --------------------  -------------------------  ------------------, ----------, ------------
         }  // eof _Entity_postRoute
//--------  -------------------------------------------  -----------------------------  ------------------  ----------------------------


//========  ===========================================  ========================================================================================


