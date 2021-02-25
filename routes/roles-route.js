const express= require('express');
const { agregarRol, getTodosRoles, getRolPorId, actualizarRol,eliminarRol } = require('../controllers/RolesController');
const router = express.Router();
const  { check } = require('express-validator');


router.post('/', [check('nombre').not().isEmpty().trim().escape()], agregarRol);
router.get('/', getTodosRoles);
router.get('/:id', getRolPorId);
router.delete('/:id', eliminarRol);
router.patch('/:id', [check('nombre').not().isEmpty().trim().escape()], actualizarRol);

module.exports = router;