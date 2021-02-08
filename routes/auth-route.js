const express= require('express');
const { auth } = require('../controllers/AuthController');
const router = express.Router();
const  { check } = require('express-validator');


router.post('/login', [check('correo').not().isEmpty().trim().isEmail(), check('password').not().isEmpty().trim().escape()], auth);


module.exports = router;