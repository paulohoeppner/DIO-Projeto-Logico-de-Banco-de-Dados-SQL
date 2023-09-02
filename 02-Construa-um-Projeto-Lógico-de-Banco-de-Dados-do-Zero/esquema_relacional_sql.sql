-- criação do banco de dados para o cenário de Auto Repair Shop (Oficina Mecânica)
 
create database autoRepairShop;

use autoRepairShop;

-- criar tabela cliente
create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(255),
        constraint unique_cpf_client unique (CPF)        
);
alter table clients auto_increment=1;

desc clients;

-- criar tabela serviço
create table service(
		idService int auto_increment primary key,
        Pname varchar(255) not null,
        category enum('Troca de Óleo','Alinhamento','Rodízio de pneus e serviços','Serviço de freio') not null,
        descriptions varchar(45)  
);
alter table service auto_increment=1;

desc service;

-- criar constraints relacionadas ao pagamento
create table payments(
	idclient int,
    idPayment int,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    primary key(idClient, idPayment),
    CONSTRAINT fk_payment_client FOREIGN KEY (idclient) REFERENCES clients (idClient)
);

desc payments;

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    paymentCash boolean default false, 
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
);
alter table orders auto_increment=1;

desc orders;

-- criar tabela estoque
create table sparePartsStorage(
	idSpareStorage int auto_increment primary key,
    partsName varchar(255) not null,
    category enum('Óleo','Alinhamento','Pneu','Pastilha de freio') not null,
    quantity int default 0
);
alter table sparePartsStorage auto_increment=1;

desc sparePartsStorage;

-- criar tabela Peças
create table autoParts(
	idAutoParts int auto_increment primary key,
    partsName varchar(255) not null,
	category enum('Óleo','Alinhamento','Pneu','Pastilha de freio') not null,
    quantity varchar(45)
);
alter table autoParts auto_increment=1;

desc autoParts;

create table serviceOrder(
	idPOservice int,
    idPOorder int,
    poQuantity int default 1,
    primary key (idPOservice, idPOorder),
    constraint fk_serviceorder_service foreign key (idPOservice) references service(idService),
    constraint fk_serviceorder_order foreign key (idPOorder) references orders(idOrder)
);

desc serviceOrder;

create table serviceAutoParts(
	idSapAutoParts int,
    idSapService int,
    quantity int not null,
    primary key (idSapAutoParts, idSapService),
    constraint fk_service_autoparts_autoparts foreign key (idSapAutoParts) references autoParts(idAutoParts),
    constraint fk_service_autoparts_service foreign key (idSapService) references service(idService)
);

desc serviceAutoParts;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'autoRepairShop';