const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const db = require('../database/asociaciones');
const Sequelize = require('sequelize');



exports.getPreguntas = async (req, res, next) => {
    try {
        const preguntas = await db.Preguntas.findAll({
            include: [{ model: db.Intensidades, as: 'Intensidades' }],
            order: [['orden', 'ASC'], [Sequelize.literal('"Intensidades"."valor"'), 'ASC']]
        });
        res.status(200).json({
            preguntas
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('ocurrio un error al encontrar las preguntas', 500);
        return next(error)
    }
}

exports.getIntensidades = async (req, res, next) => {
    try {
        const intensidades = await db.Intensidades.findAll({
            order: [["valor", 'ASC']]
        });
        res.status(200).json({
            intensidades
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('ocurrio un error al encontrar las intensidades', 500);
        return next(error)
    }

}

exports.ingresarPreguntas = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await db.sequelize.transaction();
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        let {
            nombre,
            orden,
            habilitada,
            intensidades } = await req.body;


        const preguntas = await db.Preguntas.create({
            nombre,
            orden,
            habilitada

        }, {
            include: [{ model: db.Intensidades, as: 'Intensidades' }],
            fields: [
                'nombre',
                'orden',
                'habilitada'
            ], transaction: t
        })
        if (intensidades){
            const id_preguntas =  preguntas.id;
            for (i = 0; i < intensidades.length; i++) {
                let id_intensidades=intensidades[i][0];
                let nombre=intensidades[i][1];
                await db.PreguntasIntensidades.create({
                    id_preguntas,
                    id_intensidades,
                    nombre                
                }, {
                    fields: [
                        'id_preguntas',
                        'id_intensidades',
                        'nombre'   
                    ], transaction: t
                })
            }
        }
        await t.commit();
        res.status(201).json({ mensaje: 'pregunta creada' });
    } catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('No se puede crear la pregunta', 500);
        return next(error)

    }

}

exports.actualizarPreguntas = async (req, res, next) => {
    try {
        const { id } = await req.params;
        const errors = validationResult(req);
        const t = await db.sequelize.transaction();
        let pregunta;
        const {
            nombre,
            orden,
            habilitada,
            intensidades } = await req.body;

        try {
            if (!errors.isEmpty()) {
                console.log(errors);
                next(new HttpError('Datos invalidos', 422));
            }
            pregunta = await db.Preguntas.findOne({
                attributes: [
                    'nombre',
                    'orden',
                    'habilitada'
                ],
                where: {
                    id
                }
            })

        } catch (e) {
            const error = new HttpError('hay un error, no se puede encontrar la pregunta', 500);
            return next(error);
        }
        if (!pregunta) {
            const error = next(new HttpError('no se puede encontrar la pregunta con el id suministrado', 404));
            return next(error);
        }
        try {

            let cuerpo = {
                nombre,
                orden,
                habilitada
            }

            await db.Preguntas.update(cuerpo,
                {
                    where: { id },
                    transaction: t
                });
            pregunta = await db.Preguntas.findOne({ where: { id: id }, include: [{ model: db.Intensidades, as: 'Intensidades' }], transaction: t });

            let encuestaDetalle = null;
            if (pregunta) {
                const preguntaIntensidad = await db.PreguntasIntensidades.findOne({ where: { id_preguntas: pregunta.id } });
                encuestaDetalle = await db.EncuestasDetalles.findOne({ where: { id_preguntas_intensidades: preguntaIntensidad.id } });
            }

            if (!encuestaDetalle && intensidades && pregunta) {
                await pregunta.removeIntensidades(pregunta.Intensidades, { transaction: t });
                const id_preguntas =  pregunta.id;
                for (i = 0; i < intensidades.length; i++) {
                    let id_intensidades=intensidades[i][0];
                    let nombre=intensidades[i][1];
                    await db.PreguntasIntensidades.create({
                        id_preguntas,
                        id_intensidades,
                        nombre                
                    }, {
                        fields: [
                            'id_preguntas',
                            'id_intensidades',
                            'nombre'   
                        ], transaction: t
                    })
                }
                //await pregunta.addIntensidades(intensidades, { fields: ["id_preguntas", "id_intensidades", "nombre"], transaction: t });
                await t.commit();
                return res.status(200).json({
                    message: "Pregunta actualizada",

                })
            }

            await t.commit();
            return res.status(200).json({
                message: "Pregunta actualizada, las intensidades no puede actualizarse por que ya fueron usadas en encuestas",

            })


        } catch (e) {
            try {
                await t.rollback();
            } catch (e) {
                console.log(e);
            }
            console.log(e);
            const error = new HttpError('hay un error, no se puede actualzar la pregunta', 500);
            return next(error);
        }


    } catch (e) {
        console.log(e);
        const error = new HttpError('ocurrio un error al encontrar la pregunta', 500);
        return next(error)
    }

}