const HttpError = require('../models/Error');
const nodemailer = require("nodemailer");
const enviarCorreo = async (correo, asunto, cuerpo) => {

    try {
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
            to: correo,
            subject: asunto,
            text: cuerpo
        });
        console.log(info)
    } catch (e) {
        console.log(e);
        return new Error('Error al enviar el correo');

    }
}

module.exports = enviarCorreo;