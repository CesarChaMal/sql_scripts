CREATE DATABASE Examen; //crea la bd
DROP DATABASE Examen; //elimina bd
SHOW DATABASES; //muestra la bd
SHOW TABLE FROM Examen; //muestra como esta la tabla
SHOW COLUMNS FROM Examen; //lista las columnas de la table
CREATE TABLE Alumno(IDAlumno INT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT ZEROFILL,
Nombre VARCHAR(30) NOT NULL, Salario DECIMAL(5,2), Sexo ENUM('M''F') DEFAULT 'M');
SHOW TABLES FROM Examen;
CREATE TEMPORALY TABLE Escuela(aqui van sentencias iguales a las anteriores); //Esta tabla se crea en la memoria y termina cuando se cierra la tabla
CREATE TEMPORALY TABLE TEMP SELECT * FROM Escuela //Se crea una tabla temporal sin necesidad de escribir todo
SELECT * FROM Escuela; //Muestra o selecciona los datos de la Escuela
USE base de datos; //La base de datos que voy a usar
ALTER TABLE Escuela CHANGE NOMBRE NOMBRES VARCHAR (200); //Nos sirve para modificar de nombre a una tabla
ALTER TABLE Escuela RENAME MiEscuela; //Renombra el nombre de la tabla, la estructura sigue igual.
ALTER TABLE Escuela DROP CodigoPostal; //De la tabla escuela elimino el campo CodigoPostal
ALTER TABLE Escuela ADD CodigoPostal INT(10); //Agrega una columna
SELECT NOMBRE FROM ALUMNO WHERE IDALUMNO=100; //Seleccionar nombre de la tabla alumno donde alumno sea igual a 100
SELECT Nombre FROM Alumno WHERE Nombre='A%'//Busca el indice apartir de la primera inicial
INSERT INTO ElAlumno VALUES(001,"JUAN", 55); //Mete registro
INSERT INTO Empleado(IDEmpleado, Nombre) VALUES (001, "JUAN"); //Indica que se va a insertar en el IDEmpleado y Nombre se van a insertar los datos que se dan
SELECT * FROM Empleado E //Para correr
Otras operaciones del SELECT: SELECT 8*8 AS Resultado //Se visualiza el resultado de 8*8 y AS pone etiqueta
SELECT IDEmpleado FROM Empleado E //Solo te muestra la columna que deseas
SELECT Nombre AS Pila, IDEmpleado AS Clave FROM Empleado E; //As me pone la etiqueta, cambio IDEmpleado por Clave
UPDATE Empleado SET Edad 25 WHERE IDEmpleado = 003; //El UDATE me modifica el registro 003
UPDATE Empleado SET Edad = Edad + 5 WHERE Nombre LIKE "J%"; //Va a agregar +5 a la edad a quienes empiezan con J
UPDATE Empleado SET Edad = Edad + 5 LIMIT 2; //Cambia solo los 2 primeros registros
DELETE FROM Empleado; //Borra toda la base de datos de Empleado
DELETE FROM Empleado WHERE Nombre = "JUAN"; //Me borra solo el registro de JUAN
DELETE FROM Empleado WHERE Nombre = "JUAN" AND IDEmpleado = 001; //Me borra el nombre Empleado si JUAN = 1
DELETE FROM Empleado WHERE IDEmpleado = 001 OR IDEmpleado = 003; //Me borra los empleados que sean 001 o 003
DELETE FROM Empleado WHERE IDEmpleado > 001 AND IDEmpleado <= 004; //Me borra los rango mas de 1
SELECT COUNT (*) FROM Empleado; //cuenta cuantos registros tengo
SELECT DISTINCT (Edad) FROM Empleado; //Selecciona las edades que no se repitan
SELECT COUNT (DISTINCT(Edad)) FROM Empleado WHERE Edad < 40; //Muestra cuantos registros tengo de edades
SELECT MAX (Edad) FROM Empleado; //muestra el resultado maximo (edad maxima)
SELECT MIN (Edad) FROM Empleado; //me devuelve el resultado minimo
SELECT AVG (Edad) FROM Empleado; //me saca un promedio de mis edades
SELECT STD (Edad) FROM Empleado; //me saca la desviacion estandar
SELECT SUM (Edad) FROM Empleado; //saca la suma de todas las edades
SELECT CONCAT ("Su nombre es:", Nombre) FROM Empleado; //concatena cadenas
SELECT SUM (Edad) FROM Empleado WHERE Edad < 40; //suma las edades menores a 40
SELECT MOD (14,3); //me muestra mi residuo
SELECT SUM (SUM(Salario) + SUM (Edad)) FROM Empleado; //suma el salario + la edad, se pueden ir anilando salarios
SELECT IDEmpleado FROM Empleado; //despliega de l empleado el ID en pantalla
SELECT IDEmpleado AS IDentificador FROM Empleado; //aqui cambia el nombre de la etiqueta
SELECT 2 + 2 AS Resultado; //resultado y abajo saldra 4
Manejo del If
SELECT IF (Columna > Columna2, "V","F") FROM Empleado; //despliega si es verdadero o falso
SELECT IFNULL (Edad / Antiguedad, 0) FROM Empleado; //si la primera es verdadera me devuelve el resultado, si no me devolvera 0, va a acomparar el primero con el otro
SELECT IF (Edad < Antiguedad, 1,0) FROM Empleado; //si va a ser verdadero me devuelve 1 si es falso nos devolvera 0
SELECT NOT (IF(Edad < Antiguedad, 1,0) FROM Empleado; //cambia de estado si es verdadero se vuelve falso
SELECT Nombre FROM Empleado WHERE Edad = 20 AND Edad = 26; //muestra los nombres de los empleados cuando la edad sea = a 20 y 26, los 2 tienen que ser verdaderos para que se cumplan
SELECT Nombre FROM Empleado WHERE Edad = 20 OR Edad = 26; //El OR es una exepcion, o muestra uno o los 2
SELECT Nombre FROM Empleado WHERE NOT (Edad = 20 OR Edad = 26); //aqui no me despliega nada, por que el NOT me cambia el resultado
SELECT Nombre FROM Empleado WHERE (Edad = 20 OR Edad = 26) AND Nombre = "JUAN"; //primeor el OR tiene que cumplirse para que luego se cumppla el ANd y para que luego se desppliege ango en pantalla y sea verdadero el AND y el OR tienen que ser verdaderos
SELECT Nombre FROM Empleado WHERE Edad = 20 AND Edad = 26 AND Edad = 50; //esta sentencia no se puede cumplir por que nadie tiene las mismas edades al mismo tiempo
SELECT Nombre FROM Empleado WHERE (Edad = 20 AND Edad = 26) OR Edad = 50; //muestra la edad de 50
Funciones con cadenas
SELECT LTRIM ("  JUAN"); //quita espacios que existen en la cadena
RTRIM //quita espacios por la derecha
TRIM //quita los valores de ambos lados
SELECT SUBSTRING ("HOLA MUNDO", 6); //me saca una cadena apartir de la letra 6
SELECT LOCATE ("NEGRO", "El perro negro persigue al gato", 1); //busca el primer argumento en el segundo y me devuelve su pocicion
SELECT REPLACE ("Archivo.xxx", "xxx", "123"); //la cadena origen lo va a sustiruir por 123 osea devuelve archivo. 123
SELECT REVERSE ("Hola"); //devuelve la palabra alreves 
UCASE //todo lo convierte a mayusculas
LCASE //lo convierte a minusculas
SELECT UCASE ("JuAn"); //devuelve JUAN
SELECT LCASE ("JuAn"); //devuelve juan