const express= require('express');
const { agregarPermiso, getTodosPermisos, getPermisoPorId, actualizarPermiso, eliminarPermiso } = require('../controllers/PermisosController');
const router = express.Router();
const  { check } = require('express-validator');
const ACL = require('../middleware/acl');

router.post('/', ACL('admin_crear_permisos'), [check('nombre').not().isEmpty().trim().escape()], agregarPermiso);
router.get('/', ACL('admin_buscar_permisos'), getTodosPermisos);
router.get('/:id', ACL('admin_buscar_permisos_id'), getPermisoPorId);
router.delete('/:id', ACL('admin_eliminar_permisos'),  eliminarPermiso);
router.patch('/:id', ACL('admin_actualizar_permisos'), [check('nombre').not().isEmpty().trim().escape()], actualizarPermiso);

module.exports = router;