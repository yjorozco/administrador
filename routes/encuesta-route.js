const express= require('express');
const { procesarEncuesta } = require('../controllers/EncuestasController');
const router = express.Router();
const  { check } = require('express-validator');
const ACL = require('../middleware/acl');


router.post('/', ACL('usuario_procesar_encuestas'), procesarEncuesta);

module.exports = router;