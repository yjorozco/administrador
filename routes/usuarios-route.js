const express= require('express');
const { agregarUsuario, getTodosUsuarios, getUsuarioPorId, actualizarUsuario, eliminarUsuario } = require('../controllers/UsuariosController');
const router = express.Router();
const  { check } = require('express-validator');

router.post('/', [check('nombre').not().isEmpty().trim().escape(),check('apellido').not().isEmpty().trim().escape(),check('foto').not().isEmpty().trim().escape(),check('direccion').not().isEmpty().trim().escape(),check('correo').normalizeEmail().isEmail(), check('password').not().isEmpty().trim().escape()], agregarUsuario);
router.get('/', getTodosUsuarios);
router.get('/:id', getUsuarioPorId);
router.delete('/:id', eliminarUsuario);
router.patch('/:id', [check('nombre').not().isEmpty().trim().escape(),check('apellido').not().isEmpty().trim().escape(),check('foto').not().isEmpty().trim().escape(),check('direccion').not().isEmpty().trim().escape(),check('correo').normalizeEmail().isEmail(), check('password').trim().escape()], actualizarUsuario);

module.exports = router;