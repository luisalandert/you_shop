# README

# youShop

youShop is a website for buying and selling products among coworkers. Simply create an account and fill your profile information to advertise your own products and see what other people are selling.
This project was developed with Ruby on Rails and tested with Rspec and Capybara. For validations the gem Devise was also used.

## Setup

```bash
git clone git@github.com:luisalandert/you_shop.git

bin/setup
```
If necessary run:

```bash
yarn install --check-files
```
To start the server on http://localhost:3000/ :

```bash
rails server
```

## Testing

To run all tests use the command: 

```bash
rspec
```
To run a specific test use the same command but specify the path and line:

```bash
rspec spec/folder/file_to_test_spec.rb:2
```

## Usage

1. Create account with corporate email. If company is not registered yet you will have to do it.

2. Complete your profile to be able to use all features.

3. Click on 'Cadastrar Produto' to register your own products.

4. Click on 'Produtos' to see all products and use the form on the top to search for specific products.

5. Write comments or private messages on the product page.

6. Click on 'Fazer Proposta' on the product page to make an offer and check its status by clicking on 'Propostas' in your profile page. 

7. If you're a seller click on 'Aceitar' to accept an offer and 'Rejeitar' to deny an offer.
