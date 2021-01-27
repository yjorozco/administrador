const express= require('express');
const { agregarPermiso, getTodosPermisos, getPermisoPorId, actualizarPermiso, eliminarPermiso } = require('../controllers/PermisosController');
const router = express.Router();
const  { check } = require('express-validator');


router.post('/', [check('nombre').not().isEmpty().trim().escape()], agregarPermiso);
router.get('/', getTodosPermisos);
router.get('/:id', getPermisoPorId);
router.delete('/:id', eliminarPermiso);
router.patch('/:id', [check('nombre').not().isEmpty().trim().escape()], actualizarPermiso);

module.exports = router;