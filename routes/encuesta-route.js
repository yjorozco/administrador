const express= require('express');
const { procesarEncuesta } = require('../controllers/EncuestasController');
const router = express.Router();
const  { check } = require('express-validator');
const ACL = require('../middleware/acl');


router.post('/', ACL('usuario_procesar_encuestas'), [check('fecha').not().isEmpty().trim().isDate(),check('hora').not().isEmpty().trim().escape(),check('respuestas').not().isEmpty()], procesarEncuesta);

module.exports = router;