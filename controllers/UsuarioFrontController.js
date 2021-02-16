const Usuarios = require('../models/Usuarios');
const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const UsuariosRoles = require('./../models/UsuariosRoles')
const sequelize = require('../database/database');
const bcrypt = require('bcrypt');
const Roles = require('../models/Roles');
const nodemailer = require("nodemailer");
const cryptoRandomString = require('crypto-random-string');


exports.registrarUsuario = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await sequelize.transaction();
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        const {
            nombre,
            apellido,
            foto,
            direccion,
            telefono,
            correo,
            password
        } = req.body;
        
        const passwordHash = await bcrypt.hash(password, 10);
        const usuario = await Usuarios.create({
            nombre,
            apellido,
            foto,
            direccion,
            telefono,
            correo,
            'password':passwordHash
        }, {
            fields: [
                'nombre',
                'apellido',
                'foto',
                'direccion',
                'telefono',
                'correo',
                'password'
            ], transaction: t
        })
        const roles = await Roles.findOne({
            where: {
                nombre:'Usuario'
            }
        })
        const usuariosRoles = await UsuariosRoles.create({
            id_usuarios: usuario.id,
            id_roles: roles.id
        }, {
            fields: [
                'id_usuarios',
                'id_roles'
            ], transaction: t
        })

        await t.commit();
        res.status(201).json({ mensaje: 'usuario creado', usuario });
    } catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('No se puede crear el usuario', 422);
        return next(error)

    }

}


exports.recuperarPassword =  async (req, res, next) => {
    const errors = validationResult(req);
    const t = await sequelize.transaction();
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }

        const nuevoPassword = cryptoRandomString({length: 10});
        const {
            correo
        } = req.body;
        const usuario = await Usuarios.findOne({
            where: {
                correo
            }
        })
        if(!usuario){
            const error = new HttpError('usuaro no existe', 404);
            return next(error);
        }
        const nuevoPasswordHash = await bcrypt.hash(nuevoPassword, 10);
        await Usuarios.update({password:nuevoPasswordHash},
            {
                where: { id:usuario.id },
                transaction: t
            });
        
        process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";
        
        let transporter = nodemailer.createTransport({
          service: 'gmail',
          auth: {
            user: 'yamiloro@gmail.com', 
            pass: 'Sistemas10009973.', 
          },
        });
      
        let info = await transporter.sendMail({
          from: '"yamiloro@gmail.com',
          to: usuario.correo, 
          subject: "Recuperación de Contraseña", 
          text: "Su nueva contraseña es " + nuevoPassword
        });

        await t.commit();
        return res.status(200).json({
            message: "Password cambiado",
            
        })
        
    }catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('No se puede actualizar el password', 422);
        return next(error)
    }
}