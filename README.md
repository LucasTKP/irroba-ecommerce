# Irroba
Este projeto foi desenvolvido com base nas intruções de um desafio.


### 💻 Projeto:

Este projeto consiste em uma vitrine virtual onde é possível visualizar todos os produtos cadastrados, cadastrar produtos, visualizar estoque, cadastrar usuários e visualizar usuários.
Além disso é possivel criar, editar e excluir o carrinho de comprar.

<br /> <br />

### 🎯 Desafios:

O maior desafio encontrado durante o desenvolvimento foi lidar com as limitações da "Fake Store Api".
Está Api apenas simula as operações de criação, ediçao e exclusão de dados mas não muda nada realmente no banco de dados, com isso, não foi possivel cadastrar produtos, usuários e nem adicionar produtos ao carrinho.
Isso fez o aplicativo ficar mais estático

<br /> <br />

### ⚙️ Termos Técnicos:
A aplicação foi estruturada utilizando a arquitetura MVC (Model, Views, Controllers) para organizar melhor o projeto. Para desacoplar responsabilidades, todas as conversões de dados aconteceram na camada `repositories` e todas as chamadas de API foram centralizadas na camada `services`.
Desenvolvi o projeto utilizando a versão 3.24.1 do Flutter e realizei testes exclusivamente em dispositivos Android, uma vez que não disponho de um MacBook para emulação no iOS. Algumas configurações nativas, como a integração com a biblioteca de localização para obter a posição do usuário, foram configuradas apenas para o sistema operacional Android.

<br /> <br />

### ⚙️ Como rodar localmente?

Para rodar localmente, basta clonar o projeto rodando no terminal o comando
`git clone https://github.com/LucasTKP/irroba-ecommerce.git`
Após clonar o projeto, abra a pasta e rode `flutter pub get` no terminal para instalar as dependencias.
Agora é só selecionar o celular android que será emulado e rodar `flutter run`.

<br /> <br />





<br />
