const express= require('express');
const { agregarRol, getTodosRoles, getRolPorId, actualizarRol,eliminarRol } = require('../controllers/RolesController');
const router = express.Router();
const  { check } = require('express-validator');
const ACL = require('../middleware/acl');

router.post('/', ACL('admin_crear_roles'), [check('nombre').not().isEmpty().trim().escape()], agregarRol);
router.get('/', ACL('admin_buscar_roles'),  getTodosRoles);
router.get('/:id', ACL('admin_buscar_roles_id'), getRolPorId);
router.delete('/:id', ACL('admin_eliminar_roles'), eliminarRol);
router.patch('/:id', ACL('admin_modificar_roles'), [check('nombre').not().isEmpty().trim().escape()], actualizarRol);

module.exports = router;