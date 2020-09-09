# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

company_one = Company.create!(name:'Empresa Um', cnpj: '15.841.968/4394-20', address: 'Av. Paulista, 1007, São Paulo, SP',
                user_email: 'user@empresaum.com', email_domain: '@empresaum.com')
company_two = Company.create!(name:'Empresa Dois', cnpj: '54.892.878/0981-67', address: 'Av. Morumbi, 100, São Paulo, SP',
                user_email: 'user@empresadois.com', email_domain: '@empresadois.com')
company_three = Company.create!(name:'Empresa Três', cnpj: '71.367.326/2719-85', address: 'R. Purpurina, 193, São Paulo, SP',
                user_email: 'user@empresatres.com.br', email_domain: '@empresatres.com.br')
company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')

User.create!(email: 'joao@empresaum.com', password:'abc123', full_name:'João da Silva',
             social_name:'João da Silva', birth_date:Date.parse('15/05/1987'),
             job_position: 'Advogado', department: 'Jurídico', company: company_one ,
             status: :complete)
User.create!(email: 'maria@empresaum.com', password:'def123', full_name:'Maria Pereira',
             social_name:'Maria Pereira', birth_date:Date.parse('02/01/1990'),
             job_position: 'Desenvolvedora', department: 'Tecnologia', company: company_one ,
             status: :complete)

User.create!(email: 'raquel@empresadois.com', password:'abc456', full_name:'Rodrigo de Freitas',
             social_name:'Raquel de Freitas', birth_date:Date.parse('10/09/1993'),
             job_position: 'Analista de Marketing', department: 'Marketing', company: company_two ,
             status: :complete)
User.create!(email: 'pedro@empresadois.com', password:'gtr167', full_name:'Pedro Rodrigues',
             social_name:'Pedro Rodrigues', birth_date:Date.parse('26/03/1985'),
             job_position: 'Gerente', department: 'Vendas', company: company_two ,
             status: :complete)

User.create!(email: 'ana.brandao@empresatres.com.br', password:'abc123', full_name:'Ana Brandão',
             social_name:'Ana Brandão', birth_date:Date.parse('04/08/1969'),
             job_position: 'Auxiliar Administrativo', department: 'Recursos Humanos', company: company_three ,
             status: :complete)
User.create!(email: 'tereza.q@empresatres.com.br', password:'abc123', full_name:'Tereza Queiroz',
             social_name:'Tereza Queiroz', birth_date:Date.parse('11/11/1999'),
             job_position: 'Estagiária', department: 'Desenvolvimento', company: company_three ,
             status: :complete)

User.create!(email: 'heitorp@empresaquatro.com.br', password:'abc123', full_name:'Heitor Penteado',
             social_name:'Heitor Penteado', birth_date:Date.parse('10/06/1975'),
             job_position: 'Engenheiro de Dados', department: 'Business Inteligence', company: company_four,
             status: :complete)
User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
             social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
             job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
             status: :complete)