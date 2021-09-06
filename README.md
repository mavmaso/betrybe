# Tri
 
  Uma api RESTfull. Para demostrar minha maneira de codar.

### Proposal Problem

  Criar uma api de blog seguindo certas regras. Algumas coisas, como o login, foram simplificadas, por ser apenas uma demostração.

## Deps for Linux

- `sudo apt update`
- `sudo apt upgrade`
- `sudo apt install -y build-essential libssl-dev zlib1g-dev automake autoconf libncurses5-dev`

## In loco Setup

- Instalar as deps `mix deps.get`
- Criar o banco `mix ecto.setup`
- Start Phoenix  `mix phx.server`
- Rodar os testes `mix test`

## Database
  PostgreSQL
  ```
  username: postgres
  password: postgres
  ```

## Using

 Você pode usar postman/insomnia ou algo similar pra fazer os request de endpoin abaixo:

### Endpoint

 - Criar user POST `/user`
  ```
  {
    "displayName": "Brett Wiltshire",
    "email": "brett@email.com",
    "password": "123456",
    "image": "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
  }
  ```

 - Login ( post /login )
  ```
  {
    "email": "email@mail.com",
    "password": "123456"
  }
  ```

 - Ver user (get /user/:id )

## Made by

 - [mavmaso](https://github.com/mavmaso)
