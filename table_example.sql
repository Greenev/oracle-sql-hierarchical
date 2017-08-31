--Creating an example table
CREATE TABLE relatives 
(	id NUMBER(2) NOT NULL,
	name VARCHAR2(20),
	gender CHAR(1) NOT NULL,
	parent_id NUMBER(2),
	CONSTRAINT relatives_pk PRIMARY KEY (id),
	CONSTRAINT relatives_ck CHECK (gender in ('m', 'f'))
);

--Populating the relatives table
INSERT ALL
	INTO relatives (id,	name, gender, parent_id) VALUES (1, 'Ivan', 'm', 2)
	INTO relatives (id,	name, gender, parent_id) VALUES (2,	'Petr',	'm', 3)
	INTO relatives (id,	name, gender) VALUES (3,	'Ekaterina', 'f')
	INTO relatives (id,	name, gender, parent_id) VALUES (4,	'Maria', 'f', 2)
	INTO relatives (id,	name, gender, parent_id) VALUES (5,	'Anastasia', 'f', 3)
	INTO relatives (id,	name, gender, parent_id) VALUES (6,	'Pavel', 'm', 5)
SELECT * FROM dual;