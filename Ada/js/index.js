// npm - gerenciador de pacotes
// require permite importar
// const readlineSync = require('readline-sync');
const readlineSync = require('readline-sync');

console.log("Hello, World!")
console.log("Curso JS na ADA")


console.log(hoisting, typeof hoisting, nomePessoas, typeof nomePessoas, idade, typeof idade); // hoisting
// sempre camelCase
// tipagem dinâmica e FRACA, já inferi o tipo de dado - TypeScript tipagem forte
// = atribuição
var nomePessoas = "Ana"; // string
var idade = 27; // number pra todos os números
var altura = 1.86; //number
var estudando = true, matriculado = false; //boolean 
// posso esvrever variáveis inline, separadas por vírgula, evita repetição do termo 'var'

console.log(nomePessoas, typeof nomePessoas, idade, typeof idade, altura, typeof altura, estudando, typeof estudando, matriculado, typeof matriculado, hoisting, typeof hoisting)

var semConteudo; // undefined
console.log(semConteudo)

// !!! não utileze 'var', foi descontinuado, variavel global, por conta do hoisting, de forma errada permite que exista antes de ser criada
var hoisting = "hoisting - var permite acessar antes de ser incializada retornando undefined, let não permite."
console.log(hoisting, typeof hoisting)

let notaDoAluno = 9;// permite alteração como var, existe no escopo e não de forma global
const falta = 8; // constante não se altera

const nota1 = 4;
const nota2 = 10;

const media = (((nota1 * 2) + (nota2 ** 2) + (notaDoAluno % 2)) - falta) / 2;
console.log(media);
console.log(nota1 * 2, nota2 ** 2, notaDoAluno % 2);


const idade2 = readlineSync.question("Qual eh a sua idade? ");
console.log("Sua idade:", idade2, "anos.", typeof idade2);

// coerção explícita|conversão manual de tipos 
const idadeNumber = Number(idade2); 
console.log(idadeNumber, typeof idadeNumber);

// console.log(Number(x)); erro 
console.log(String(10), typeof String(10));

console.log(Boolean(0)); // false
console.log(Boolean(1)); // qualquer número diferente de '0' retorna 'true'

console.log(1 + 1);
console.log(1 + "1");
console.log(1 - 1);
console.log(10 / 2);

let num = 1 + "1";
console.log(num, typeof num); // '11' string
num = "4" - num + "6";
console.log(num, typeof num); // 4 - 11 = 7 + '6' = 76

console.log(1 + 9 + 8 + '2'); // 18 + '2' = 182
console.log('1' + 9 + 8 + 2); // '1' '9' '8' '2' = 1982
console.log('1' + '9' + 8 + '2'); // iden
console.log('1' - '9' - 8 - '2'); // - 8 - 8 = -16 - '2' = -18  

console.log(1 - 9 - 8 - '2'); // -18
console.log('1' - 9 - 8 - 2); // iden
console.log('1' - '9' - '8' - '2'); // iden

console.log('10' - '4' - '3' - 2 + '5') //15




