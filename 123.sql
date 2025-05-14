CREATE TABLE Product (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	ed VARCHAR(20) NOT NULL
);

CREATE TABLE Client (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	address VARCHAR(255),
	phone VARCHAR(20)
);

CREATE TABLE Futura(
	id SERiAL PRIMARY KEY,
	idcen INT NOT NULL REFERENCES Client(id),
	data DATE NOT NULL,
	totalum DECIMAL (10,2) DEFAUlT 0.00
);

CREATE TABLE FuturaInfo(
	id SERIAL PRIMARY KEY,
	idfutura INT NOT NULL REFERENCES Futura(id),
	idproduct INT NOT NULL  REFERENCES Product(id),
	quantity INT NOT NULL,
	price DECImAL(10,2) NOT NULL
);

CREATE OR REPLACE FUNCTION insert_futura_info() RETURNS TRIGGER AS
	$ad_fi_trigger$
	BEGIN
	UPDATE futura SET totalsum=totalsum+NEW.quantity*NEW.price
	WHERE futura.id=NEW.IDFutura;
	RETURN NULL;
END
	$ad_fi_trigger$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION delete_futura_info() RETURNS TRIGGER AS
$del_fi_trigger$
BEGIN
UPDATE future SET totalsum=totalsum-OLD.quantity*OLD.price
WHERE futura.id=OLD.IDFutura;
RETURN NULL;
END
$del_fi_trigger$ LANGUAGE plpgsql;


CREATE TRIGGER ins_futura_info AFTER INSERT ON FuturaInfo
FOR EACH ROW EXECUTE PROCEDURE insert_futura_info();


CREATE TRIGGER del_futura_info AFTER DELETE ON FuturaInfo
FOR EACH ROW EXECUTE PROCEDURE delete_futura_info();
