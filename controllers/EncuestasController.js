const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const db = require('../database/asociaciones');
const dateFormat = require('dateformat');


exports.procesarEncuesta = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await db.sequelize.transaction();
    const { respuestas, ip, longitud, latitud } = req.body;
    let usuario = await req.user;

    const intensidades = Object.values(respuestas);

    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }

        let suma = 0;
        for (const respuesta in respuestas) {
            let intensidad = await db.Intensidades.findOne({
                where: {
                    id: respuestas[respuesta]
                }
            })
            suma += await intensidad.valor;
        }

        const promedio = Math.round(suma / intensidades.length);

        const intentidadObject = await db.Intensidades.findOne({
            where: {
                valor: promedio
            }
        })


        const encuestas = await db.Encuestas.create({
            'id_usuarios': usuario.id,
            'intensidad': intentidadObject.nombre,
            ip,
            'longitud': parseFloat(longitud),
            'latitud': parseFloat(latitud)
        }, {
            fields: [
                'id_usuarios',
                'intensidad',
                'ip',
                'longitud',
                'latitud'
            ], transaction: t
        })
        const id_encuestas = await encuestas.id;
        for (const respuesta in respuestas) {
            let preguntasIntensidades = await db.PreguntasIntensidades.findOne({
                where: {
                    'id_preguntas': parseInt(respuesta),
                    'id_intensidades': parseInt(respuestas[respuesta])
                }
            })

            if (preguntasIntensidades) {
                await db.EncuestasDetalles.create({
                    id_encuestas,
                    'id_preguntas_intensidades': preguntasIntensidades.id
                }, {
                    fields: [
                        'id_encuestas',
                        'id_preguntas_intensidades'
                    ], transaction: t
                });
            }else{
               throw new Error();
            }
        }        
        await t.commit();
        res.status(201).json({ mensaje: 'encuesta creada' });
    } catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('No se puede crear la encuesta', 500);
        return next(error)
    }

}


exports.consultarEncuesta = async (req, res, next) => {
    try {
        const usuario = req.user;
        const encuestas = await db.Encuestas.findAll({
            attributes: { exclude: ['password', 'id_usuarios', 'pais', 'ciudad', 'estado', 'codigo'] },
            include: [{ model: db.EncuestasDetalles, as: 'EncuestasDetalles', attributes: { exclude: ['id_encuestas', 'id_preguntas_intensidades'] }, include: [{ model: db.PreguntasIntensidades, as: 'PreguntasIntensidades', include: [{ model: db.Preguntas, as: 'Preguntas' }, { model: db.Intensidades, as: 'Intensidades' }] }] }, { model: db.Usuarios, as: 'Usuarios', attributes: { exclude: ['password', 'codigo_activacion', 'activo'] } }],
            where: {
                id_usuarios: usuario.id
            }
        });
        res.status(200).json({
            encuestas
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('ocurrio un error al encontrar las encuestas', 500);
        return next(error)
    }
}