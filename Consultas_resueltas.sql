--- Lógica consultas SQL resueltas 

--- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select "title"
from "film"
where "rating" = 'R';

--- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select concat("first_name",' ',"last_name") as full_name
from "actor"
where "actor_id" between 30 and 40;

--- 4. Obtén las películas cuyo idioma coincide con el idioma original.
select "title", 
       "language_id", 
       "original_language_id"
from "film"
where "language_id" = "original_language_id"; 
---original_laguage_id solo tiene valores nulos, por tanto, ninguna película coincidirá con language_id. Todos los language_id en film tienen valor de 1 'English'.

--- 5. Ordena las películas por duración de forma ascendente.
select "title", 
       "length"
from "film"
order by "length"; --- Podemos escribirlo tanto así como indicar el orden asc, ya que por defecto nos lo ordenará por orden ascendente.

--- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select concat("first_name", ' ', "last_name") as full_name
from "actor"
where "last_name" like '%ALLEN%';

--- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select "rating", 
       count("film_id") as quantity
from "film"
group by "rating"
order by "quantity" desc;

--- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select "title", "rating", "length"
from "film"
where "rating" = 'PG-13' or "length" >= 180;

--- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select min("replacement_cost") as minimum_value_sub, 
       max("replacement_cost") as maximum_value_sub, 
       max("replacement_cost") - min("replacement_cost") as variability
from "film";

--- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select min("length") as minimum_duration, 
       max("length") as maximum_duration
from "film"; ---Esto sería en cuanto a valor numérico, pero si queremos saber el nombre de las películas que cumplen ese requisito podemos hacer otra consulta

select "title"
from "film"
where "length" = 46;

select "title"
from "film"
where "length" = 185;

--- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select "r"."rental_id", 
       "r"."rental_date", 
       "p"."amount"
from "rental" as r
join "payment" as p
  on "r"."rental_id" = "p"."rental_id"
order by "r"."rental_date" desc;
limit 1 offset 2;  


--- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select "title", 
       "rating"
from "film"
where "rating" not in ('NC-17', 'G');

--- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select "rating",
       round(avg("length"), 2) as average_duration
from "film"
group by "rating";

--- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select "title", 
       "length"
from "film" 
where "length" > 180;

--- 15. ¿Cuánto dinero ha generado en total la empresa?
select sum("amount") as "Total_sales"
from "payment";

--- 16. Muestra los 10 clientes con mayor valor de id.
select "customer_id", 
       concat("first_name", ' ',"last_name")
from "customer"
order by "customer_id" desc
limit 10;

--- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select concat("c"."first_name", ' ', "c"."last_name"),
       "a"."title"
from "film" as a
join "film_actor" as b
  on "a"."film_id" = "b"."film_id"
join "actor" as c 
  on "b"."actor_id" = "c"."actor_id"
where "a"."title" = 'EGG IGBY';

--- 18. Selecciona todos los nombres de las películas únicos.
select distinct "title"
from "film";

--- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select "f"."title",
       "c"."name" as genre,
       "f"."length"
from "film" as f 
join "film_category" as fc 
  on "f"."film_id" = "fc"."film_id"
join "category" as c
  on "fc"."category_id" = "c"."category_id"
where "f"."length" > 180 and "c"."name" = 'Comedy';
  
--- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos, muestra el nombre de categoría junto con el promedio de duración.     
select "c"."name", 
       round(avg("f"."length"), 2) as average_duration
from "film" as f 
join "film_category" as fc 
  on "f"."film_id" = "fc"."film_id"
join "category" as c
  on "fc"."category_id" = "c"."category_id"
group by "c"."name" 
having avg("f"."length") > 110
order by "average_duration" desc;

--- 21. ¿Cuál es la media de duración del alquiler de las películas?
select round(avg("rental_duration"), 2) as average_rent_length
from "film";

--- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat("first_name", ' ',"last_name") as full_name
from "actor";

--- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

select date("rental_date") as period,
       count("rental_id") as rent_per_day
from "rental"
group by date("rental_date")
order by "rent_per_day" desc;

--- 24. Encuentra las películas con una duración superior al promedio.
select "title", 
       "length"
from "film"
where "length" > (
                   select avg("length")
                   from "film"
                   )
order by "length" desc;

--- 25. Averigua el número de alquileres registrados por mes.
select extract(year from "rental_date")as año,
       extract(month from "rental_date") as mes,
       count("rental_id") as rent_per_month
from "rental"
group by extract(year from "rental_date"), extract(month from "rental_date")
order by "año";

--- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
select round(avg("amount"), 2) as average, 
       round(stddev("amount"), 2) as standard_desv, 
       round(variance("amount"), 2) as var
from "payment";

--- 27. ¿Qué películas se alquilan por encima del precio medio?
select "title",
       "rental_rate"
from "film"
where "rental_rate" > (
                       select avg("rental_rate")
                       from "film"
                      )
order by "rental_rate" desc;

--- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
select "fa"."actor_id",
       count("f"."title") as movies
from "film" as f
join "film_actor" as fa
  on "f"."film_id" = "fa"."film_id"
group by "fa"."actor_id"
having count("f"."title") > 40
order by "movies" desc;

--- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select "f"."title", 
       count("i"."film_id") as quantity_available
from "inventory" as i
right join "film" as f
  on "i"."film_id" = "f"."film_id"
group by "f".title;

--- 30. Obtener los actores y el número de películas en las que ha actuado.
select concat("a"."first_name", ' ',"a"."last_name") as full_name,
       count(distinct "fa"."film_id") as movie_quantity
from "film_actor" as fa
join "actor" as a 
  on "fa"."actor_id" = "a"."actor_id"
group by concat("a"."first_name", ' ',"a"."last_name");

--- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select "f"."title", 
       concat("a"."first_name", ' ', "a"."last_name") as full_name
from "film" as f
left join "film_actor" as fa
  on "f"."film_id" = "fa"."film_id"
left join "actor" as a
  on "fa"."actor_id" = "a"."actor_id"
order by "f"."title";

--- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select concat("a"."first_name", ' ', "a"."last_name") as full_name,
       "f"."title"
from "film" as f
right join "film_actor" as fa
  on "f"."film_id" = "fa"."film_id"
right join "actor" as a
  on "fa"."actor_id" = "a"."actor_id"
order by "full_name";

--- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select "f"."title", 
       "r"."rental_id"
from "rental" as r
join "inventory" as i
  on "r"."inventory_id" = "i"."inventory_id"
join "film" as f
  on "i"."film_id" = "f"."film_id"
order by "f"."title";

--- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select concat("c"."first_name", ' ', "c"."last_name") as customer_full_name,
       sum("p"."amount") as total_spending
from "customer" as c 
join "payment" as p 
  on "c"."customer_id" = "p"."customer_id"
group by concat("c"."first_name", ' ', "c"."last_name")
order by "total_spending" desc
limit 5; 

--- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select concat("first_name", ' ', "last_name") as actor_full_name
from "actor"
where "first_name" = 'JOHNNY';

--- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
alter table customer
rename "first_name" to "Nombre";
alter table customer
rename "last_name" to "Apellido";
alter table staff
rename "first_name" to "Nombre";
alter table staff
rename "last_name" to "Apellido";       
alter table actor
rename "first_name" to "Nombre";
alter table actor
rename "last_name" to "Apellido";  

--- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select min("actor_id"), 
       max("actor_id")
from "actor";

--- 38. Cuenta cuántos actores hay en la tabla “actor”.
select count("actor_id") as total_actors
from "actor";

--- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select concat("Apellido", ', ',"Nombre") as full_name_backwards
from "actor"
order by "Apellido";

--- 40. Selecciona las primeras 5 películas de la tabla “film”.
select "title"
from "film"
limit 5;

--- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select "Nombre",
       count("Nombre") as n_actors_same_name
from "actor"
group by "Nombre"
order by "n_actors_same_name" desc;

--- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select "r"."rental_id", 
       concat("c"."Nombre", ' ',"c"."Apellido") as customer_full_name
from "rental" as r
join "customer" as c
  on "r"."customer_id" = "c"."customer_id"
order by "r"."rental_id";

--- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select concat("c"."Nombre", ' ',"c"."Apellido") as customer_full_name,
       "r"."rental_id"
from "customer" as c
left  join "rental" as r
  on "c"."customer_id" = "r"."customer_id"
order by "customer_full_name";    

--- Si queremos filtrar para saber aquellos que no tienen alquileres realizaríamos la siguiente consulta 
select concat("c"."Nombre", ' ',"c"."Apellido") as customer_full_name,
       "r"."rental_id"
from "rental" as r
join "customer" as c
  on "r"."customer_id" = "c"."customer_id"
where "r"."rental_id" is null 
order by "customer_full_name";  --- Se observa que no hay clientes sin factura 

--- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select * 
from "film"
cross join "category";

/*En general este JOIN no nos aporta valor en general ya que realiza el producto cartesiano y no surgen relaciones reales entre las películas y su categoría. 
 * Podría tener cierto valor si añadimos un LEFT JOIN con la tabla "film_category" y vemos las combinaciones reales faltantes o las películas sin categoría 
 *  o también para testear el rendimiento con la simulación de combinaciones posibles */

--- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select concat("a"."Nombre", ' ',"a"."Apellido") as actor_full_name,
       "c"."name" as category
from "actor" as a
join "film_actor" as fa
on "a"."actor_id" = "fa"."actor_id"
join "film_category" as fc
on "fa"."film_id" = "fc"."film_id"
join "category" as c
on "fc"."category_id" = "c"."category_id"
where "c"."name" = 'Action'
order by "a"."Apellido";

--- 46. Encuentra todos los actores que no han participado en películas.
select concat("a"."Nombre", ' ',"a"."Apellido") as actor_full_name,
       "fa"."film_id"
from "actor" as a
left join "film_actor" as fa 
  on "a"."actor_id" = "fa"."actor_id"
where "fa"."film_id" is null;

---47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select concat("a"."Nombre", ' ',"a"."Apellido") as actor_full_name,
       count("fa"."film_id") as quantity_films
from "film_actor" as fa
join "actor" as a 
  on "fa"."actor_id" = "a"."actor_id"
group by concat("a"."Nombre", ' ',"a"."Apellido")
order by quantity_films desc;

--- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view "actor_num_peliculas" as 
select concat("a"."Nombre", ' ',"a"."Apellido") as actor_full_name,
       count("fa"."film_id") as quantity_films
from "film_actor" as fa
join "actor" as a 
  on "fa"."actor_id" = "a"."actor_id"
group by concat("a"."Nombre", ' ',"a"."Apellido")
order by quantity_films desc;

select * 
from "actor_num_peliculas";

--- 49. Calcula el número total de alquileres realizados por cada cliente.
select "c"."customer_id", 
       concat("c"."Nombre", ' ', "c"."Apellido") as customer_full_name, 
       count("r"."rental_id") as quantity_rents
from "rental" as r
join "customer" as c
  on "r"."customer_id" = "c"."customer_id"
group by "c"."customer_id", concat("c"."Nombre", ' ', "c"."Apellido")
order by "quantity_rents" desc;

--- 50. Calcula la duración total de las películas en la categoría 'Action'.
select "c"."name",
       sum("f"."length") as duration
from "film" as f
join "film_category" as fc
  on "f"."film_id" = "fc"."film_id"
join "category" as "c"
  on "fc"."category_id" = "c"."category_id"
where "c"."name" = 'Action'
group by "c"."name" ;

---51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
create temp table "clientes_rentas_temporal" as 
select "c"."customer_id", 
       concat("c"."Nombre", ' ', "c"."Apellido") as customer_full_name, 
       count("r"."rental_id") as quantity_rents
from "rental" as r
join "customer" as c
  on "r"."customer_id" = "c"."customer_id"
group by "c"."customer_id", concat("c"."Nombre", ' ', "c"."Apellido")
order by "quantity_rents" desc;

select * 
from "clientes_rentas_temporal";

--- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create temp table "peliculas_alquiladas" as 
select "f"."title", 
       count("r"."rental_id") as quantity_rents
from "film" as f
join "inventory" as i
  on "f"."film_id" = "i"."film_id"
join "rental" as r
  on "i"."inventory_id" = "r"."inventory_id"
group by "f"."title"
having count("r"."rental_id") >= 10; 

select *
from "peliculas_alquiladas";

/*53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.*/
select "f"."title"
from "customer" as c
join "rental" as r
  on "c"."customer_id" = "r"."customer_id"
join "inventory" as i 
  on "r"."inventory_id" = "i"."inventory_id"
join "film" as f
  on "i"."film_id" = "f"."film_id"
where "c"."Nombre" = 'TAMMY' and "c"."Apellido" =  'SANDERS' and "r"."return_date" is null
order by "f"."title";

/* 54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido. */

select concat("a"."Nombre", ' ',"a"."Apellido") as actor_full_name
from "actor" as a
where exists (
              select 1
              from "film_actor" as fa
              join "film_category" as fc
                on "fa"."film_id" = "fc"."film_id"
              join "category" as c
                on "fc"."category_id" = "c"."category_id"
              where "a"."actor_id" = "fa"."actor_id" and "c"."name" = 'Sci-Fi'
             )
order by "Apellido";

/* 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.*/
with "rental_spartacus" as (
select min("rental_date") as primer_alquiler
from "rental" as r
join "inventory" as i
  on "r"."inventory_id" = "i"."inventory_id"
join "film" as f
on "i"."film_id" = "f"."film_id"
where "f"."title" = 'SPARTACUS CHEAPER'
)
select distinct "a"."Nombre",
                "a"."Apellido"
from "actor" as a
join "film_actor" as fa
  on "a"."actor_id" = "fa"."actor_id"
join "inventory" as i
  on "fa"."film_id" = "i"."film_id"
join "rental" as r
  on "i"."inventory_id" = "r"."inventory_id"
cross join "rental_spartacus" as rs
where "r"."rental_date" > "rs"."primer_alquiler"
order by "a"."Apellido";

--- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select distinct "actor_id",
       concat("Nombre",' ', "Apellido") as full_name
from "actor"
where "actor_id" not in (
select distinct "a"."actor_id"
from "actor" as a
join "film_actor" as fa
  on "a"."actor_id" = "fa"."actor_id"
join "film_category" as fc
  on "fa"."film_id" = "fc"."film_id"
join "category" as c
  on "fc"."category_id" = "c"."category_id"
where "c"."name" in ('Music')
)
order by "full_name";

--- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select "f"."title", 
       ("r"."return_date" - "r"."rental_date") as rental_duration
from "film" as f
join "inventory" as i 
  on "f"."film_id" = "i"."film_id"
join "rental" as r
  on "i"."inventory_id" = "r"."inventory_id"
where extract(day from ("r"."return_date" - "r"."rental_date")) >8
order by "rental_duration" desc;

---58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
select "f"."title", 
       "c"."name"
from "film" as f
join "film_category" as fc
  on "f"."film_id" = "fc"."film_id"
join "category" as "c"
  on "fc"."category_id" = "c"."category_id"
where "c"."name" = 'Animation';

/*59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.*/ 
select "title", 
       "length"
from "film"
where "length" in (
select "length"
from "film"
where "title" = 'DANCING FEVER'
);

--- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select                "c"."Nombre", 
                      "c"."Apellido",
       count(distinct "i"."film_id") as total_movies
from "customer" as c
join "rental" as r
  on "c"."customer_id" = "r"."customer_id"
join "inventory" as i
  on "r"."inventory_id" = "i"."inventory_id"
group by "c"."customer_id", "c"."Nombre", "c"."Apellido"
having count(distinct "i"."film_id") >= 7
order by "c"."Apellido";

--- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select "c"."name", 
       count("r"."rental_id") as recuento_alquileres,
       count(distinct "i"."film_id") as recuento_peliculas
from "rental" as r
join "inventory" as i
  on "r"."inventory_id" = "i"."inventory_id"
join "film_category" as fc
  on "i"."film_id" = "fc"."film_id"
join "category" as c
  on "fc"."category_id" = "c"."category_id"
group by "c"."category_id", "c"."name";

--- 62. Encuentra el número de películas por categoría estrenadas en 2006.
select "c"."name", 
       count(distinct "f"."film_id") as quantity
from "category" as c
join "film_category" as fc
  on "c"."category_id" = "fc"."category_id"
join "film" as f
  on "fc"."film_id" = "f"."film_id"
where "f"."release_year" = '2006'
group by "c"."name"
order by "quantity" desc; 

--- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select concat("s"."Nombre", ' ',"s"."Apellido") as full_name,
       "st"."store_id"
from "staff" as s 
cross join "store" as st;

/*64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.*/
select        "c"."customer_id", 
       concat("c"."Nombre", ' ',"c"."Apellido") as full_name, 
       count("i"."film_id") as total_rental
from "customer" as c
join "rental" as r 
  on "c"."customer_id" = "r"."customer_id"
join "inventory" as i
  on "r"."inventory_id" = "i"."inventory_id"
group by "c"."customer_id"
order by "total_rental" desc;


