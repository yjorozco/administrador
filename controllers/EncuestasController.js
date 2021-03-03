const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const db = require('../database/asociaciones');
const  dateFormat = require('dateformat');

exports.procesarEncuesta = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await db.sequelize.transaction();

    const { user, fecha, hora, respuestas, localizacion } = req.body;

    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }

        const suma = respuestas.reduce((a, b) => {
            a + b
        }, 0);
        const numero = respuestas.length;
        const intensidadValor = Math.round(suma/numero);
        const intensidad = db.Intensidades.findAll(
           { where: { 'valor': intensidadValor}}
        )
        let fechaSismo = new Date(fecha+' '+hora);
        fechaSismo =  dateFormat(fechaSismo, "yyyy-mm-dd h:MM:ss");
        const encuestas = await db.Encuestas.create({
            'id_usuarios': user.id,
            'fecha':fechaSismo,
            'intensidad': intensidad.nombre

        }, {
            fields: [
                'id_usuarios',
                'fecha',
                'intesidad'
            ], transaction: t
        })   
        
        for(respuesta of respuestas){
            let db.Intensidades.findOne({
                where: {
                    id_intensidad
                }
            })
            await db.EncuestasDetalles.create({
                'id_encuestas': encuestas.id,
                'id_preguntas':fechaSismo,
                'id_intensidades': intensidad.nombre
    
            }, {
                fields: [
                    'id_encuestas',
                    'id_preguntas',
                    'id_intensidades'
                ], transaction: t
            })  
        }

        //await usuario.setEncuestasDetalles(roles, { fields: ["id_encuestas", "id_preguntas","id_intesidades"], transaction: t });
        await t.commit();
        res.status(201).json({ mensaje: 'usuario creado' });
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