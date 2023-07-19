/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/

// 'use strict';

// const express = require('express');
   import express from 'express';

// Constants
     const  aPORT           =  3001;
     const  aHOST           = 'localhost'                           // .(30717.01.1 Was: '0.0.0.0')
     const  aURI            =  import.meta.url;                     // console.log( "aURI", aURI ); process.exit()
     const  aOS             = (typeof(process) != 'undefined' ) ? (`${process.argv[1]}`.match( /^[a-z]:/i ) ? 'windows' : 'linux' ) : 'browser'
     const  __filename      =  aURI.replace( /^.+\//, "" )
     const  __dirname       =  aURI.replace( `/${__filename}`, '' ).replace( 'file:///', aOS == 'linux' ? '/' : '')  // .(30322.05.1 RAM Put '/' back in)

     const  pApp            =  express();

            pApp.use( express.static( 'library/3_bonus/' ) );

            pApp.get('/', ( pReq, pRes ) => {
//          pRes.send('Hello remote world index.mjs from VSCode!\n');
//          pRes.send('Hello remote world in index.mjs from TextPad!\n');
            pRes.sendFile( `${__dirname}/library/3_bonus/index.html` )
});

            pApp.listen( aPORT, aHOST );

            console.log( `Running on http://${aHOST}:${aPORT}` );
