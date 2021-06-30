const express= require('express');
const { getPreguntas,ingresarPreguntas,actualizarPreguntas, getIntensidades, getPreguntasPorId } = require('../controllers/PreguntasController');
const router = express.Router();
const ACL = require('../middleware/acl');
const  { check } = require('express-validator');

router.get('/', ACL('usuario_buscar_preguntas'), getPreguntas);
router.get('/:id', ACL('usuario_buscar_preguntas'), getPreguntasPorId);
router.post('/', ACL('usuario_agregar_preguntas'), [check('nombre').not().isEmpty().trim().escape(), check('orden').not().isEmpty().trim().escape(), check('habilitada').not().isEmpty().trim().escape()],ingresarPreguntas);
router.patch('/:id', ACL('usuario_modificar_preguntas'),[check('nombre').not().isEmpty().trim().escape(), check('orden').not().isEmpty().trim().escape(), check('habilitada').not().isEmpty().trim().escape()], actualizarPreguntas);
router.get('/intensidades', ACL('usuario_buscar_intensidades'), getIntensidades);
module.exports = router;