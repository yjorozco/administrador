const express = require('express');
const { agregarUsuario, getTodosUsuarios, getUsuarioPorId, actualizarUsuario, eliminarUsuario, cambiarPassword, salvarImagen } = require('../controllers/UsuariosController');
const router = express.Router();
const ACL = require('../middleware/acl');
const { check } = require('express-validator');
const upload = require('../helpers/upload');

router.post('/', ACL('admin_crear_usuarios'), [check('nombre').not().isEmpty().trim().escape(), check('apellido').not().isEmpty().trim().escape(), check('foto').not().isEmpty().trim().escape(), check('direccion').not().isEmpty().trim().escape(), check('correo').normalizeEmail().isEmail(), check('password').not().isEmpty().trim().escape()], agregarUsuario);
router.get('/', ACL('admin_buscar_usuarios'), getTodosUsuarios);
router.get('/:id', ACL('admin_buscar_usuarios_id'), getUsuarioPorId);
router.delete('/:id', ACL('admin_eliminar_usuarios'), eliminarUsuario);
router.patch('/:id', ACL('admin_modificar_usuarios'), [check('nombre').not().isEmpty().trim().escape(), check('apellido').not().isEmpty().trim().escape(), check('direccion').not().isEmpty().trim().escape(), check('correo').normalizeEmail().isEmail(), check('password').trim().escape()], actualizarUsuario);
router.post('/cambio', ACL('admin_cambiar_password'), [check('correo').not().isEmpty().trim().escape(), check('password').not().isEmpty().trim().escape()], cambiarPassword);
router.post('/salvar-imagen', ACL('usuario_salvar_imagen'), upload.single('imagen'), salvarImagen)
module.exports = router;