/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/

// 'use strict';

// const express = require('express');
   import express from 'express';

// Constants
const PORT = 3001;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
//  res.send('Hello remote world index.mjs from VSCode!\n');
    res.send('Hello remote world in index.mjs from TextPad!\n');

});

  app.listen(PORT, HOST);

  console.log(`Running on http://${HOST}:${PORT}`);
