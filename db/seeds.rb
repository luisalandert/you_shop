# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Empresas
company_one = Company.create!(name:'Empresa Um', cnpj: '15.841.968/4394-20', address: 'Av. Paulista, 1007, São Paulo, SP',
                user_email: 'user@empresaum.com', email_domain: '@empresaum.com')
company_two = Company.create!(name:'Empresa Dois', cnpj: '54.892.878/0981-67', address: 'Av. Morumbi, 100, São Paulo, SP',
                user_email: 'user@empresadois.com', email_domain: '@empresadois.com')

# Usuários
user_two = User.create!(email: 'heitorp@empresaum.com', password:'abc123', full_name:'Heitor Penteado',
                        social_name:'Heitor Penteado', birth_date:Date.parse('10/06/1975'),
                        job_position: 'Engenheiro de Dados', department: 'Business Inteligence', company: company_one,
                        status: :complete)
user_one = User.create!(email: 'patricia@empresaum.com', password:'abc123', full_name:'Patricia Andrade',
                        social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                        job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_one,
                        status: :complete)

another_user = User.create!(email: 'tereza.q@empresadois.com', password:'abc123', full_name:'Tereza Queiroz',
                            social_name:'Tereza Queiroz', birth_date:Date.parse('11/11/1999'),
                            job_position: 'Estagiária', department: 'Desenvolvimento', company: company_two ,
                            status: :complete)

# Categorias
category_one = Category.create!(name: 'Alimentos')
category_two = Category.create!(name: 'Vestuário')
category_three = Category.create!(name: 'Cuidados Pessoais')
category_four = Category.create!(name: 'Decoração')

#Produtos
product_one = Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                              category: category_one, quantity: 5, price: 25.00, condition: :new_product, 
                              user: user_one , status: :available)
product_two = Product.create!(name: 'Jaqueta jeans', description: 'Jaqueta jeans Shoulder tamanho 40 em ótimo estado.',
                              category: category_two, quantity: 1, price: 100.00, condition: :used,
                              user: user_one , status: :available)
product_three = Product.create!(name: 'Espelho decorado', description: 'Espelho decorado pintado à mão.',
                                category: category_four, quantity: 1, price: 30.00, condition: :new_product,
                                user: user_one , status: :available)
product_four = Product.create!(name: 'Chuteira', description: 'Chuteira Nike tamanho 38, usada poucas vezes.',
                               category: category_two, quantity: 1, price: 50.00 , condition: :used,
                               user: user_two, status: :available)
product_five = Product.create!(name: 'Bolo no pote', description: 'Bolo recheado no pote, ótimo para comer no almoço! Sabores variados.',
                               category: category_one, quantity: 10, price: 10.00 , condition: :new_product,
                               user: user_two, status: :available)
product_six = Product.create!(name: 'Sabonetes artesanais', description: 'Sabonete artesanal, vegano e 100% natural, embalagem com 2. Opções: baunilha, verbena ou lírios',
                              category: category_three, quantity: 5, price: 15.00 , condition: :new_product,
                              user: user_two, status: :available)
another_product = Product.create!(name: 'Shampoo em barra', description: 'Shampoo em barra artesanal, embalagem com 1. Com verbena e babosa',
                                  category: category_three, quantity: 5, price: 15.00 , condition: :new_product,
                                  user: another_user, status: :available)
unavailable_product = Product.create!(name: 'Creme de arnica', description: 'Creme de arnica para batidas, ajuda na cicatrização',
                              category: category_three, quantity: 10, price: 10.00 , condition: :new_product,
                              user: user_one, status: :unavailable)

# Comentários
comment_one = Comment.create!(content: 'O pão de mel é recheado? Quais sabores você tem?',
                              user: user_two, product: product_one)
comment_two = Comment.create!(content: 'Faço os pães de mel na versão só com licor ou recheado com brigadeiro ou doce de leite.',
                              user: user_one, product: product_one)
comment_three = Comment.create!(content: 'A chuteira é para gramado ou quadra?',
                                user: user_one, product: product_four)
comment_four = Comment.create!(content: 'Você aceita encomendas maiores? Queria dar de presente pras minhas primas.',
                               user: user_one, product: product_six)

# Mensagens privadas