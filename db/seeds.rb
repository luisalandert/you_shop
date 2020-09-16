# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Empresas
company_one = Company.create!(name:'Empresa Um', cnpj: '15.841.968/4394-20', address: 'Av. Paulista, 1007, São Paulo, SP',
                user_email: 'user@empresaum.com', email_domain: '@empresaum.com')
company_two = Company.create!(name:'Empresa Dois', cnpj: '54.892.878/0981-67', address: 'Av. Morumbi, 100, São Paulo, SP',
                user_email: 'user@empresadois.com', email_domain: '@empresadois.com')

# Usuários
user_one = User.create!(email: 'patricia@empresaum.com', password:'abc123', full_name:'Patricia Andrade',
                        social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                        job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_one,
                        status: :complete)
user_two = User.create!(email: 'heitorp@empresaum.com', password:'abc123', full_name:'Heitor Penteado',
                        social_name:'Heitor Penteado', birth_date:Date.parse('10/06/1975'),
                        job_position: 'Engenheiro de Dados', department: 'Business Inteligence', company: company_one,
                        status: :complete)
user_three = User.create!(email: 'joaquimp@empresaum.com', password:'abc123', full_name:'Joaquim Queiroga',
                         social_name:'Joaquim Queiroga', birth_date:Date.parse('15/09/1970'),
                         job_position: 'Advogado', department: 'Jurídico', company: company_one,
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
product_one = Product.new(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                              category: category_one, quantity: 5, price: 25.00, condition: :new_product, 
                              user: user_one , status: :available)
product_one.picture.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'paes_de_mel.png')),filename: 'paes_de_mel.png')
product_one.save!
product_two = Product.create!(name: 'Jaqueta jeans', description: 'Jaqueta jeans Shoulder tamanho 40 em ótimo estado.',
                              category: category_two, quantity: 1, price: 100.00, condition: :used,
                              user: user_one , status: :available)
product_two.picture.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'jaqueta_jeans.jpg')),filename: 'jaqueta_jeans.jpg')
product_two.save!
product_three = Product.create!(name: 'Espelho decorado', description: 'Espelho decorado pintado à mão.',
                                category: category_four, quantity: 1, price: 30.00, condition: :new_product,
                                user: user_one , status: :available)
product_three.picture.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'espelho_decorado.jpg')),filename: 'espelho_decorado.jpg')
product_three.save!
product_four = Product.create!(name: 'Chuteira', description: 'Chuteira Nike tamanho 38, usada poucas vezes.',
                               category: category_two, quantity: 1, price: 50.00 , condition: :used,
                               user: user_two, status: :available)
product_five = Product.create!(name: 'Bolo no pote', description: 'Bolo recheado no pote, ótimo para comer no almoço! Sabores variados.',
                               category: category_one, quantity: 10, price: 10.00 , condition: :new_product,
                               user: user_two, status: :available)
product_five.picture.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'bolo_no_pote.jpg')),filename: 'bolo_no_pote.jpg')
product_five.save!
product_six = Product.create!(name: 'Sabonetes artesanais', description: 'Sabonete artesanal, vegano e 100% natural, embalagem com 2. Opções: baunilha, verbena ou lírios',
                              category: category_three, quantity: 5, price: 15.00 , condition: :new_product,
                              user: user_two, status: :available)
product_six.picture.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sabonete.jpg')),filename: 'sabonete.jpg')
product_six.save!
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
message_one = Message.create!(content: 'Boa Tarde Patricia, eu gostaria de comprar 2 caixas do pão de mel de brigadeiro para essa sexta. Você tem conta no banco x?',
                              sender: user_two, recipient: user_one, product: product_one)
message_two = Message.create!(content: 'Oi Heitor! Eu posso te entregar na sexta sim, tenho conta no banco x e y.',
                              sender: user_one, recipient: user_two, product: product_one)
message_three = Message.create!(content: 'Você quer receber que horas?.',
                              sender: user_one, recipient: user_two, product: product_one)
message_four = Message.create!(content: 'Pode ser na hora do almoço?',
                              sender: user_two, recipient: user_one, product: product_one)
message_five = Message.create!(content: 'Você faz sabores diferentes por encomenda? Por exemplo recheio de café?',
                               sender: user_three, recipient: user_one, product: product_one)

# Propostas
proposal_one = Proposal.create!(product: product_one, buyer: user_two, seller: user_one, proposed_price: 25, quantity: 2)
proposal_two = Proposal.create!(product: product_six, buyer: user_three, seller: user_two, proposed_price: 15, quantity: 1)
proposal_three = Proposal.create!(product: product_two, buyer: user_three, seller: user_one, proposed_price: 80, quantity: 1)
proposal_four = Proposal.create!(product: product_five, buyer: user_one, seller: user_two, proposed_price: 10, quantity: 2)
proposal_five = Proposal.create!(product: product_six, buyer: user_one, seller: user_two, proposed_price: 15, quantity: 1)


#Compras/recibos
invoice_one = Invoice.create!(proposal: proposal_one, seller: user_one, buyer: user_two, issue_date: Date.current)
invoice_two = Invoice.create!(proposal: proposal_five, seller: user_two, buyer: user_one, issue_date: Date.current)