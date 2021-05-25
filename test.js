const axios = require('axios');

const URL = 'https://desarrollofunvisis.cnti.gob.ve/api';


let token = null;
let preguntas = null;
axios.post(URL + '/auth/login', {
  correo: 'jalvarado@cnti.gob.ve',
  password: '123456'
})
  .then(function (response) {
    token = response.data.token;
    console.log(token);
    axios.get(URL + '/preguntas',
      {
        headers: {
          "Content-type": "application/json",
          "Authorization": `Bearer ${token}`,
        }
      }
    )
      .then(function (response) {
        console.log(response.data);
      })
      .catch(function (error) {
        console.log(error);
      });
  })
  .catch(function (error) {
    console.log(error);
  });


console.log(preguntas);