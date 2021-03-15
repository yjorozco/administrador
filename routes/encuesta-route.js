const express= require('express');
const HttpError = require('../models/Error');
const { procesarEncuesta, consultarEncuesta } = require('../controllers/EncuestasController');
const router = express.Router();
const  { check } = require('express-validator');
const ACL = require('../middleware/acl');


router.post('/', ACL('usuario_procesar_encuestas'), [check('fecha').not().isEmpty().trim().custom(fecha => {   
    const expresion = /^\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(\.\d+)?(([+-]\d\d:\d\d)|Z)?$/i;
    console.log(fecha.match(expresion));
    return fecha.match(expresion);
  }),check('hora').not().isEmpty().trim().escape(),check('respuestas').not().isEmpty()], procesarEncuesta);

router.get('/', ACL('usuario_ver_encuestas'), consultarEncuesta);

module.exports = router;