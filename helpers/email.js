const HttpError = require('../models/Error');
const nodemailer = require("nodemailer");
const enviarCorreo = async (correo, asunto, cuerpo) => {

    try {
        process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

        let transporter = nodemailer.createTransport({
            host: "",
            port: 25,
            secure: true, // upgrade later with STARTTLS          
            auth: {
                user: '',
                pass: '',
            },
        });

        let info = await transporter.sendMail({
            from: '',
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