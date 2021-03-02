const express= require('express');
const { getPaises, getEstadosPorPais, getCiudadesPorPaisEstado } = require('../controllers/GeografiaController');
const router = express.Router();
const  { check } = require('express-validator');
const ACL = require('../middleware/acl');


router.get('/', ACL('usuario_buscar_geografia'), getPaises);
router.get('/:pais', ACL('usuario_buscar_geografia'), getEstadosPorPais);
router.get('/:pais/:provincia', ACL('usuario_buscar_geografia'), getCiudadesPorPaisEstado);

module.exports = router;