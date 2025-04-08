<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/GreatApe77/jim-hats">
    <img src="./docs/assets/jim-hats-mobile-logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Jim Hats</h3>

  <p align="center">
    Versão mobile do aplicativo Jim Hats
    <br />
    <a href="./docs/index.md"><strong>Veja a documentação detalhada do projeto AQUI!</strong></a>
    <br />
    <br />
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Tabela de conteúdos</summary>
  <ol>
    <li>
      <a href="#sobre-o-projeto">Sobre o Projeto</a>
      <ul>
        <li><a href="#tecnologias-utilizadas">Tecnologias utilizadas</a></li>
      </ul>
    </li>
    <li>
      <a href="#começando">Começando</a>
      <ul>
        <li><a href="#pré-requisitos">Pré-requisitos</a></li>
        <li><a href="#instalação-e-configuração">Instalação e Configuração</a></li>
      </ul>
    </li>
    <li>
      <a href="#uso">Uso</a>
       <ul>
        <li><a href="#testes-automatizados">Testes automatizados</a></li>
        <li><a href="#execução">Execução</a></li>
      </ul>
    </li>

  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## Sobre o projeto

O aplicativo Jim Hats é uma versão simplificada do aplicativo já existente [Gym Rats](https://www.gymrats.app/), neste documento são encontrados informações gerais sobre como executar o aplicativo e as tecnologias utilizadas para sua construção, para ver detalhes sobre as funcionalidades do projeto e sua arquitetura [CLIQUE AQUI](linkaqui).

<p align="right">(<a href="#readme-top">Voltar para o início</a>)</p>



### Tecnologias utilizadas

* ![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
* ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

<p align="right">(<a href="#readme-top">Voltar para o início</a>)</p>




<!-- GETTING STARTED -->
## Começando

Siga as instruções abaixo para instalar e executar o aplicativo.

### Pré requisitos

Para executar o aplicativo, é necessário ter os seguintes softwares instalados na máquina:

* Flutter na versão 3.27.x

* Dart na versão 3.6.x

* Emulador de Android devidamente configurado

<p align="right">(<a href="#readme-top">Voltar para o início</a>)</p>


### Instalação e configuração


1. Clone o repositório
    ```sh
   git clone https://github.com/GreatApe77/jim-hats.git
   ```
2. Navegue até o projeto mobile
   ```sh
   cd jim-hats/jim_hats_mobile
   ```
3. Instale as dependências
   ```sh
   flutter pub get
   ```
4. Execute o script de geração de mocks para os testes automatizados
   ```sh
   dart run build_runner build
   ```
5. Crie os seguintes arquivos no diretório /jim_hats_mobile
    ```
    📂 jim_hats_mobile/
    ├── .env.development      # Variáveis para o ambiente  development
    ├── .env.staging          # Variáveis para o ambiente  staging
    ├── .env.production       # Variáveis para o ambiente  production
    ```
  Um arquivo modelo para .env pode ser encontrado em: [.env.example](./.env.example)

<p align="right">(<a href="#readme-top">Voltar para o início</a>)</p>

<!-- USAGE EXAMPLES -->
## Uso

Aqui você encontra instruções para execução do projeto

### Testes automatizados
1. Execute o seguinte comando para executar os testes unitários e de widget
  ```sh
   flutter test
  ```
1. Para executar os testes com a cobertura de código, execute
  ```sh
   flutter test --coverage
  ```

### Execução em modo de desenvolvimento
1. Certifique-se que o arquivo .env.development esteja devidamente configurado na raíz do projeto e que ele esteja populado com as variáveis corretas

2. Execute a flavor de desenvolvimento em modo debug
  ```sh
   flutter run --debug --flavor development --dart-define-from-file=./.env.development
  ```
NOTA: para execução do aplicativo em funcionamento normal, certifique-se que a API está sendo executada na URL especificada.

<p align="right">(<a href="#readme-top">Voltar para o início</a>)</p>
