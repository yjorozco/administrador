
const express = require('express');
const bodyParser = require('body-parser');
const passport = require("passport");
const cors = require('cors');
const helmet = require("helmet");

const app = express();
app.use(cors({ 
  'allowedHeaders': ['sessionId', 'Content-Type', 'x-requested-with','authorization'],
  'exposedHeaders': ['sessionId'],
  'origin': '*',
  'methods': 'GET,HEAD,PUT,PATCH,POST,OPTIONS,DELETE',
  'preflightContinue': false, 
  'credentials': false 
}));
app.use(helmet());
app.use(bodyParser.json());


require('./auth/passport');

const rolesRouter = require('./routes/roles-route');
const encuestaRouter = require('./routes/encuesta-route');
const permisosRouter = require('./routes/permisos-route');
const usuariosRouter = require('./routes/usuarios-route');
const usuariosFront = require('./routes/usuario-front-route');
const geografiaRouter = require('./routes/geografia-route');
const preguntasRouter = require('./routes/preguntas-route');
const auth = require('./auth/auth');
const path = require('path');

const dir = path.join(__dirname, 'uploads');

app.use('/uploads',  passport.authenticate('jwt', {session: false}), express.static(dir));
app.use('/api/roles', passport.authenticate('jwt', {session: false}), rolesRouter);
app.use('/api/encuestas', passport.authenticate('jwt', {session: false}), encuestaRouter);
app.use('/api/permisos', passport.authenticate('jwt', {session: false}), permisosRouter);
app.use('/api/usuarios', passport.authenticate('jwt', {session: false}), usuariosRouter);
app.use('/api/front', usuariosFront);
app.use('/api/geografia', passport.authenticate('jwt', {session: false}), geografiaRouter);
app.use('/api/preguntas', passport.authenticate('jwt', {session: false}), preguntasRouter);
app.use('/api/auth', auth);



app.use((error, req, res, next) => {
    res.status(error.code || 500)
    res.json({ message: error.message } || 'ocurrio un error inesperado!');
})

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Server started on port ${PORT}`));