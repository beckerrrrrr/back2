/*********************************************************************************************************
 * Objetivo: Nesta primeira etapa você foi convidado a criar uma API com apenas 02 Endpoints do tipo GET. 
 * Nome: beckerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
 * Data: 25/01/2024
 * Versão: 1.0.0
 *********************************************************************************************************/ 

/*
    Para realizar o acesso a Banco de Dados precisamos instalar algumas bibliotecas:

        - SEQUELIZE     - É uma biblioteca mais antiga
        - PRISMA ORM    - É uma biblioteca mais atual (será utilizado no projeto)
        - FASTFY ORM    - É uma biblioteca mais atual

        para instalar o PRISMA:
            - npm install prisma --save  (Irá realizar a conexão com BD)
            - npm install @prisma/client --save (Irá executar os scripts SQl no BD)

        Após a instalação das bibliotecas, devemos inicializar o prisma no projeto:
            - npx prisma init (Irá inicializar o PRISMA)

        Para reinstalar o prisma e atualizar as dependências:   
            - npm i (Irá atualizar todas as dependências)
            - no package.json caso não queira atualizar todas as dependências basta tirar o "^" do @prisma/client

        Caso troque de máquina e sincronizar o Banco de Dados novamente: 
            - npx prisma generate (Serve para ressincronizar o Banco de Dados)

 */

//Importar as bibliotecas do projeto
const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const funcoes = require('./Controller/funcoes.js')

const app = express()
app.use((request, response, next) => {

    response.header('Access-Control-Allow-Origin', '*')
    response.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
    app.use(cors())
    next()

})

/*  Importar os arquivos da controller do projeto */
    const controllerFilmes = require('./Controller/controller_filme.js');
 

/* Criando um objeto para controlar a chegada dos dados da requisição em formato JSON */
    const bodyParserJSON = bodyParser.json();


//EndPoint: Versão 1.0 - retorna todos os filmes do arquivo filmes.js pelo ID
          //Periodo de funcionamento: 01/2024 até 02/2024
app.get('/v1/ACMEFilmes/filmes', cors(), async function(request, respose, next) {

    respose.json(funcoes.getListarTodosFilmes())
    respose.status(200)

})

//EndPoint: Versão 1.0 - retorna todos os filmes do arquivo filmes.js pelo ID
          //Periodo de funcionamento: 01/2024 até 02/2024
app.get('/v1/ACMEFilmes/filme/:id', cors(), async function(request, response, next) {
    
    let idFilme = request.params.id

    response.json(funcoes.getDadosFilmes(idFilme))
    
    response.status(200)
})

//EndePoint: Versão 2.0 - retorna todos os filmes do Banco de Dados
           //Periodo de funcionamento: 02/2024
app.get('/v2/ACMEFilmes/filmes', cors(), async function(request, response) {

    //Chama a função da controller para retornar os filmes
    let dadosFilmes = await controllerFilmes.getListarFilmes();

    //Validação para retornar o JSON dos filmes ou retornar 404
    if(dadosFilmes) {
        response.json(dadosFilmes);
        response.status(200);
    }else {
        response.json({message: 'Nenhum requisito foi encontrado'});
        response.status(404);
    }
})

//EndPoint: Retorna o filme filtrando pelo ID
app.get('/v2/ACMEFilmes/filme/:id', cors(), async function(request, response) {

    //Recebe o ID da requisição
    let idFilme = request.params.id;

    //Encaminha o ID para a controller buscar o filme
    let dadosFilme = await controllerFilmes.getBuscarFilme(idFilme);

    response.status(dadosFilme.status_code);
    response.json(dadosFilme);
})

app.get('/v2/ACMEFilmes/filmes/filtro', cors(), async function(request, response) {

    let filtro = request.query.nome;

    let dadosFilmes = await controllerFilmes.getFilmesNome(filtro);

    response.status(dadosFilmes.status_code);
    response.json(dadosFilmes);
})

app.post('/v2/ACMEFilmes/filme', cors(), bodyParserJSON, async function(request, response){

    //recebe o content type da requisisão
    let contentType = request.headers['content-type'];

    //Recebe todos os dados encaminhados na requisição pelo body
    let dadosBody = request.body;

    //Encaminha os dados para o controller enviar para o DAO
    let resultDadosNovoFilme = await controllerFilmes.setInserirNovoFilme(dadosBody, contentType);
    
    response.status(resultDadosNovoFilme.status_code);
    response.json(resultDadosNovoFilme);
})

app.put('/v2/ACMEFilmes/update/:id', cors(), bodyParserJSON, async function(request, response){

    let idFilme = request.params.id

    let contentType = request.headers['content-type'];

    let dadosBody = request.body;

    let updateFilme = await controllerFilmes.setAtualizarFilme(idFilme, dadosBody, contentType);

    response.status(updateFilme.status_code);
    response.json(updateFilme);
})

app.delete('/v2/ACMEFilmes/deleteFilme/:id', cors(), bodyParserJSON, async function(request, response){

    let idFilme = request.params.id;

    let dadosFilme = await controllerFilmes.setExcluirFilme(idFilme);

    response.status(dadosFilme.status_code);
    response.json(dadosFilme);
})

//Executa a API e faz ela ficar aguardando requisições
app.listen('8080', function() {
    console.log('API funcionando!!')
})