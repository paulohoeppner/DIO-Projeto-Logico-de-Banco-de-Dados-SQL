-- inserção de dados e queries
use autoRepairShop;

show tables;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, CPF, Address) 
	   values('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', 789123456,'rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores');


-- idService, Pname, category('Troca de Óleo','Alinhamento','Rodízio de pneus e serviços', 'Serviço de freio')
insert into service (Pname, category) values
							  ('Troca de Óleo','Troca de Óleo'),
                              ('Alinhamento das rodas','Alinhamento'),
                              ('Rodízio de pneus','Rodízio de pneus e serviços'),
                              ('Troca das pastilhas de freio','Serviço de freio');
                              

select * from clients;
select * from service;

-- idOrder, idOrderClient, orderStatus, orderDescription, paymentCash
insert into orders (idOrderClient, orderStatus, orderDescription, paymentCash) values 
							 (1, default,'compra via aplicativo',1),
                             (2, default,'compra via aplicativo',0),
                             (3,'Confirmado',null,1),
                             (4, default,'compra via web site',0);

-- idPOproduct, idPOorder, poQuantity
select * from orders;

insert into serviceOrder (idPOservice, idPOorder, poQuantity) values
						 (1,1,2),
                         (2,2,1),
                         (3,3,1),
                         (4,4,1);

-- idSpareStorage, partsName, category, quantity
insert into sparePartsStorage (partsName, category, quantity) values 
							('Óleo', 'Óleo',1000),
                            ('Pneu','Pneu',500),
                            ('Pastilha de freio','Pastilha de freio',200);
	
select * from sparePartsStorage;

-- idAutoParts, partsName, category, quantity
insert into autoParts (partsName, category, quantity) values 
							('Óleo', 'Óleo','4'),
                            ('Pneu','Alinhamento','2'),
                            ('Pneu','Pneu','4'),
                            ('Pastilha de freio', 'Pastilha de freio','2');
select * from autoParts;

-- idSapAutoParts, idSapService, quantity
insert into serviceAutoParts (idSapAutoParts, idSapService, quantity) values
						 (1,1,500),
                         (2,2,200),
                         (3,3,400),
                         (4,4,100);

select * from serviceAutoParts;


select count(*) from clients;

select * from clients c, orders o where c.idClient = idOrderClient;

select Fname,Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;

select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;
                             
select count(*) from clients c, orders o 
			where c.idClient = idOrderClient;

select * from orders;

      
-- Recuperar quantos pedidos foram realizados pelos clientes?
select clients.idClient, Fname, count(*) as Number_of_orders 
from clients 
inner join orders ON clients.idClient = orders.idOrderClient
group by idClient; 
        
-- Relação de Peças, serviços e estoque;

select * 
from AutoParts
join serviceAutoParts on autoParts.idAutoParts = serviceAutoParts.idSapAutoParts
join service on serviceAutoParts.idSapService = service.idService
join sparePartsStorage on service.idService = idSpareStorage;

-- Relação de nomes das peças e nomes dos serviços 

select * 
from AutoParts
join serviceAutoParts on autoParts.idAutoParts = serviceAutoParts.idSapAutoParts
join service on serviceAutoParts.idSapService = service.idService;