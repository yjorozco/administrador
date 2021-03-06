const express= require('express');
const {  registrarUsuario, recuperarPassword, activarUsuario } = require('../controllers/UsuarioFrontController');
const router = express.Router();
const  { check } = require('express-validator');

router.post('/registro', [check('nombre').not().isEmpty().trim().escape(),check('apellido').not().isEmpty().trim().escape(),check('direccion').not().isEmpty().trim().escape(),check('correo').escape().trim().isEmail(), check('password').not().isEmpty().trim().escape()], registrarUsuario);
router.post('/cambio', [check('correo').escape().trim().isEmail()], recuperarPassword);
router.post('/codigo-activacion', [check('codigo_activacion').not().isEmpty().trim().escape()], activarUsuario);
module.exports = router;