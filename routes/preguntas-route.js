const express= require('express');
const { getPreguntas } = require('../controllers/PreguntasController');
const router = express.Router();
const ACL = require('../middleware/acl');


router.get('/', ACL('usuario_buscar_preguntas'), getPreguntas);

module.exports = router;