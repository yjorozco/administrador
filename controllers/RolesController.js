const Roles = require('../models/Roles');
const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');


exports.getTodosRoles = async (req, res, next) => {
    try {
        const roles = await Roles.findAll();
        res.status(200).json({
            roles
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('Ocurrio un error al encontrar los roles', 422);
        return next(error)
    }
}

exports.agregarRole = async (req, res, next) => {
    const errors = validationResult(req);
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        const { nombre } = req.body;
        const nuevoRol = await Roles.create({
            nombre
        }, {
            fields: [
                'nombre'
            ]
        })
        res.status(201).json({ mensaje: 'rol creado', rol: nuevoRol });
    } catch (e) {
        console.log(e);
        const error = new HttpError('No se puede crear el rol', 422);
        return next(error)

    }

}

exports.getRolPorId = async (req, res, next) => {
    const id = await req.params.id;
    let rol;
    try {
        rol = await Roles.findOne({
            where: {
                id
            }
        })
    } catch (err) {
        const error = new HttpError('hay un error, no se puede encontrar el rol', 500);
        return next(error);
    }
    if (!rol) {
        const error = next(new HttpError('no se puede encontrar el rol con el id suministrado', 404));
        return next(error);
    }
    res.status(200).json({ rol });
}

exports.actualizarRol = async (req, res, next) => {
    const { id } = await req.params;
    const { nombre } = req.body;
    let rol
    try {
        rol = await Roles.findOne({
            attributes: ['nombre', 'id'],
            where: {
                id
            }
        })

    } catch (e) {
        const error = new HttpError('hay un error, no se puede encontrar el rol', 500);
        return next(error);
    }
    if (!rol) {
        const error = next(new HttpError('no se puede encontrar el rol con el id suministrado', 404));
        return next(error);
    }
    try {
        rol = await Roles.update({
            nombre
        },
            {
                where: { id }
            })
        return res.status(201).json({
            message: "Rol actualizado",
            rol
        })
    } catch (err) {
        const error = new HttpError('hay un error, no se puede encontrar el rol', 500);
        return next(error);
    }
}

exports.eliminarRol = async (req, res, next) => {
    try {
        const { id } = await req.params;
        const cantidadEliminada = await Roles.destroy({
            where: {
                id
            }
        })
        res.json({
            message: 'Rol eliminado de forma satisfactoria',
            count: cantidadEliminada
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('el rol no se puede eliminar', 500);
        return next(error);
    }
}


