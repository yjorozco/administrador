const express= require('express');
const HttpError = require('../models/Error');
const { procesarEncuesta, consultarEncuesta } = require('../controllers/EncuestasController');
const router = express.Router();
const  { check } = require('express-validator');
const ACL = require('../middleware/acl');


router.post('/', ACL('usuario_procesar_encuestas'), [check('ip').not().isEmpty().trim().escape(), check('longitud').not().isEmpty().trim().escape(), check('latitud').not().isEmpty().trim().escape(),check('respuestas').not().isEmpty()], procesarEncuesta);

router.get('/', ACL('usuario_ver_encuestas'), consultarEncuesta);

module.exports = router;