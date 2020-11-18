-- Creación de la Base de Datos --
kennojc=# CREATE DATABASE películas;
CREATE DATABASE
kennojc=# \c películas
You are now connected to database "películas" as user "kennojc".

-- Crear las tablas para cada archivo y cargar la info  --

CREATE TABLE peliculas(
 id INT,
 movie VARCHAR(255),
 release_year INT,
 director VARCHAR(255),
 PRIMARY KEY (id)
 );
CREATE TABLE

CREATE TABLE reparto(                                               
 from_movie INT,
 artist_name VARCHAR(255),
 FOREIGN KEY (from_movie) REFERENCES peliculas(id)
 );
CREATE TABLE

\copy peliculas FROM '/Users/kennojc/Desafío_Latam/Databases/Top100/peliculas.csv' csv header
\copy reparto FROM '/Users/kennojc/Desafío_Latam/Databases/Top100/reparto.csv' csv

-- ejemplo resultado --
id  |                        movie                         | release_year |       director
-----+------------------------------------------------------+--------------+-----------------------
   1 | Forest Gump                                          |         1994 | Robert Zemeckis
   2 | Titanic                                              |         1997 | James Cameron
   3 | El Padrino                                           |         1972 | Francis Ford Coppola
   4 | Gladiator                                            |         2000 | Ridley Scott
   5 | El Señor de los anillos: El retorno del rey          |         2003 | Peter Jackson
   6 | El caballero oscuro                                  |         2008 | Christopher Nolan
   7 | Cadena perpetua                                      |         1994 | Frank Darabont
   8 | Piratas del Caribe: La maldición de la Perla Negra   |         2003 | Gore Verbinski
   9 | Braveheart                                           |         1995 | Mel Gibson
  10 | La lista de Schindler                                |         1993 | Steven Spielberg

  from_movie |         artist_name
------------+-----------------------------
          1 | Tom Hanks
          1 | Robin Wright Penn
          1 | Gary Sinise
          1 | Mykelti Williamson
          1 | Sally Field
          1 | Rebecca Williams
          1 | Michael Conner Humphreys


-- Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película--
--año de estreno, director y todo el reparto--

películas=# SELECT movie, release_year, director, artist_name
películas-# FROM peliculas
películas-# INNER JOIN reparto
películas-# ON peliculas.id = reparto.from_movie
películas-# WHERE movie = 'Titanic'
películas-# ;
  movie  | release_year |   director    |    artist_name
---------+--------------+---------------+-------------------
 Titanic |         1997 | James Cameron | Leonardo DiCaprio
 Titanic |         1997 | James Cameron | Kate Winslet
 Titanic |         1997 | James Cameron | Billy Zane
 Titanic |         1997 | James Cameron | Kathy Bates
 Titanic |         1997 | James Cameron | Frances Fisher
 Titanic |         1997 | James Cameron | Bernard Hill
 Titanic |         1997 | James Cameron | Jonathan Hyde
 Titanic |         1997 | James Cameron | Danny Nucci
 Titanic |         1997 | James Cameron | David Warner
 Titanic |         1997 | James Cameron | Bill Paxton
 Titanic |         1997 | James Cameron | Gloria Stuart
 Titanic |         1997 | James Cameron | Victor Garber
 Titanic |         1997 | James Cameron | Suzy Amis
(13 rows)

-- Listar los titulos de las películas donde actúe Harrison Ford --

películas=# SELECT movie
películas-# FROM peliculas
películas-# INNER JOIN reparto
películas-# ON peliculas.id = reparto.from_movie
películas-# WHERE artist_name = 'Harrison Ford'
películas-# ;

                     movie
-----------------------------------------------
 Star Wars. Episodio IV: Una nueva esperanza
 Indiana Jones y la última cruzada
 En busca del arca perdida
 Star Wars. Episodio V: El imperio contraataca
 Star Wars. Episodio VI: El retorno del Jedi
 Blade Runner
 Apocalypse Now
 Indiana Jones y el templo maldito
(8 rows)

-- Indicar cuantos actores distintos hay --
películas=# SELECT COUNT (DISTINCT artist_name) FROM reparto;

 count
-------
   831


--Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por
--título de manera ascendente.

películas=# SELECT movie FROM peliculas                                                                               
WHERE release_year > 1989 AND release_year < 2000                                                                     
ORDER BY movie  ASC;

                   movie
--------------------------------------------
 American Beauty
 American History X
 Braveheart
 Cadena perpetua
 Eduardo Manostijeras
 El Padrino. Parte III
 El club de la pelea
 El profesional
 El sexto sentido
 El show de Truman
 El silencio de los corderos........etc

 --Listar el reparto de las películas lanzadas el año 2001--
SELECT artist_name FROM reparto
INNER JOIN peliculas
ON reparto.from_movie = peliculas.id
WHERE release_year = 2001 ;

-- Listar los actores de la película más nueva--
SELECT artist_name FROM reparto                                                                           
INNER JOIN peliculas                                                                                                  
ON reparto.from_movie = peliculas.id                                                                                  
WHERE release_year = (                                                                                                
    SELECT MAX(release_year) FROM peliculas);
