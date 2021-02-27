const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const db = require('../database/asociaciones');

exports.getTodosPermisos = async (req, res, next) => {
    try {
        const permisos = await db.Permisos.findAll();
        res.status(200).json({
            permisos
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('Ocurrio un error al encontrar los permisos', 500);
        return next(error)
    }
}

exports.agregarPermiso = async (req, res, next) => {
    const errors = validationResult(req);
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        const { nombre } = req.body;
        const permiso = await db.Permisos.create({
            nombre
        }, {
            fields: [
                'nombre'
            ]
        })
        res.status(200).json({ mensaje: 'permiso creado' });
    } catch (e) {
        console.log(e);
        const error = new HttpError('No se pueden crear los permiso', 500);
        return next(error)

    }

}

exports.getPermisoPorId = async (req, res, next) => {
    const id = await req.params.id;
    let permiso;
    try {
        permiso = await db.Permisos.findOne({
            where: {
                id
            }
        })
    } catch (err) {
        const error = new HttpError('hay un error, no se puede encontrar el permiso', 500);
        return next(error);
    }
    if (!permiso) {
        const error = next(new HttpError('no se puede encontrar el permiso con el id suministrado', 404));
        return next(error);
    }
    res.status(200).json({ permiso });
}

exports.actualizarPermiso = async (req, res, next) => {
    const { id } = await req.params;
    const { nombre } = await req.body;
    let permiso;
    const errors = validationResult(req);
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        permiso = await db.Permisos.findOne({
            attributes: ['nombre', 'id'],
            where: {
                id
            }
        })
    } catch (e) {
        const error = new HttpError('hay un error, no se puede encontrar el permiso', 500);
        return next(error);
    }
    if (!permiso) {
        const error = next(new HttpError('no se puede encontrar el permiso con el id suministrado', 404));
        return next(error);
    }
    try {
        cantidad = await db.Permisos.update({
            nombre
        },
            {
                where: { id }
            })
        return res.status(200).json({
            message: "Permiso actualizado"
        })
    } catch (err) {
        const error = new HttpError('hay un error, no se puede actualizar el permiso', 500);
        return next(error);
    }

}

exports.eliminarPermiso = async (req, res, next) => {
    try {
        const { id } = await req.params;
        const cantidadEliminada = await db.Permisos.destroy({
            where: {
                id
            }          
        })
        res.json({
            message: 'Permiso eliminado de forma satisfactoria'
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('el permiso no se puede eliminar', 500);
        return next(error);
    }
}