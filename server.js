
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const passport = require("passport");
require('./auth/passport');
//const path = require('path');
//const HttpError = require('./models/Error');
const rolesRouter = require('./routes/roles-route');
const permisosRouter = require('./routes/permisos-route');
const usuariosRouter = require('./routes/usuarios-route');
const usuariosFront = require('./routes/usuario-front-route');
const auth = require('./auth/auth');


app.use(bodyParser.json());


/*app.use('/uploads/images', express.static(path.join('uploads', 'images')));
if (process.env.NODE_ENV === 'production') {
    app.use(express.static('client/build'));
    app.get('*', (req, res) => {
        res.sendFile(path.resolve(__dirname, 'client', 'build', 'index.html'));
    });
} else {
    app.use(express.static('client/public'));
    app.get('*', (req, res) => {
        res.sendFile(path.resolve(__dirname, 'client', 'public', 'index.html'));
    });
}/*



/*app.use((req, res, next)=>{
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
    res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PATCH,DELETE');
    next();
});*/

app.use('/api/roles', passport.authenticate('jwt', {session: false}), rolesRouter);
app.use('/api/permisos', passport.authenticate('jwt', {session: false}), permisosRouter);
app.use('/api/usuarios', passport.authenticate('jwt', {session: false}), usuariosRouter);
app.use('/api/front', usuariosFront);
app.use('/api/auth', auth);

//app.use('/api/auth', autenticacion);
//app.use('/api/users', usersRouters);

/*app.use((req, res, next)=>{
    res.sendFile(path.resolve(__dirname, 'public', 'index.html'));
})*/

/*app.use((req, res, next)=>{
    const error = new HttpError('Could not find this route', 404);
    throw error;
})*/



/*app.use((error, req, res, next) => {
      if(req.file){
          fs.unlink(req.file.path, (err)=>{
              console.log(err);
          });
      }
    if (res.headerSent) {
        return next(error);
    }
    res.status(error.code || 500)
    res.json({ message: error.message } || 'An unknow error occurred!');
})*/

app.use((error, req, res, next) => {
    res.status(error.code || 500)
    res.json({ message: error.message } || 'An unknow error occurred!');
})

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Server started on port ${PORT}`));