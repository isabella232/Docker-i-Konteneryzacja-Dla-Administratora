CREATE DATABASE maildb;
CREATE USER mailuser@localhost IDENTIFIED BY 'mailPWD';
CREATE USER 'mailuser'@'172.18.0.0/255.255.255.0' IDENTIFIED BY 'mailPWD';
GRANT ALL ON maildb.* TO mailuser@localhost;
GRANT ALL ON maildb.* TO 'mailuser'@'172.18.0.0/255.255.255.0';
FLUSH PRIVILEGES;

USE maildb;

CREATE TABLE virtual_Status(
	status_id INT NOT NULL,
	status_desc VARCHAR(50) NOT NULL,
	status_note VARCHAR(100),
	PRIMARY KEY (status_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE virtual_Domains( 
	domain_name VARCHAR(100) not null,
	domain_desc VARCHAR(100) not null,
	status_id INT NOT NULL DEFAULT 1,
PRIMARY KEY (domain_name), 
FOREIGN KEY (status_id) REFERENCES virtual_Status(status_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE virtual_Users (
	domain_name VARCHAR(100) not null,
	email VARCHAR(100) NOT NULL,
	password VARCHAR(106) NOT NULL,
	fullname VARCHAR(50) NOT NULL,
	department VARCHAR(50) NOT NULL,
	status_id INT NOT NULL DEFAULT 1,
PRIMARY KEY (email),
FOREIGN KEY (domain_name) REFERENCES virtual_Domains(domain_name) ON DELETE CASCADE,
FOREIGN KEY (status_id) REFERENCES virtual_Status(status_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE virtual_Aliases (
	domain_name VARCHAR(100) not null,
	source VARCHAR(100) NOT NULL,
	destination TEXT NOT NULL,
	status_id INT NOT NULL DEFAULT 1,
PRIMARY KEY (source),
FOREIGN KEY (domain_name) REFERENCES virtual_Domains(domain_name) ON DELETE CASCADE,
FOREIGN KEY (status_id) REFERENCES virtual_Status(status_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO virtual_Status (status_id,status_desc) VALUES ('1','Enable');
INSERT INTO virtual_Domains (domain_name,domain_desc) VALUES ('workhome.augustow.pl','WORKHOME.AUGUSTOW.PL');
INSERT INTO virtual_Users (domain_name,email,password,fullname,department) VALUES ('workhome.augustow.pl','test1@workhome.augustow.pl',TO_BASE64(UNHEX(SHA2('test1', 512))),'Test 1','Test');
INSERT INTO virtual_Users (domain_name,email,password,fullname,department) VALUES ('workhome.augustow.pl','test2@workhome.augustow.pl',TO_BASE64(UNHEX(SHA2('test2', 512))),'Test 2','Test');
INSERT INTO virtual_Aliases (domain_name,source,destination) VALUES ('workhome.augustow.pl','group-test@workhome.augustow.pl','test1@workhome.augustow.pl,test2@workhome.augustow.pl');