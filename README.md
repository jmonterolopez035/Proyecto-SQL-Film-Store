# 📌 Proyecto SQL – Análisis y Consultas sobre la Base de Datos Film store rental

Este repositorio contiene el proyecto final del módulo de SQL, donde se ha trabajado con la base de datos **Film store rental**.  
El objetivo del proyecto es demostrar dominio de SQL a través de la creación del esquema de la base de datos, la resolución de consultas de distinta complejidad y la elaboración de un pequeño análisis interpretativo.

---

## 📁 Contenido del repositorio

El repositorio incluye los siguientes archivos:

### **1. "Create_schema.sql"**
Archivo SQL que contiene la creación del esquema completo de la base de datos utilizado en el proyecto.  
Incluye:
- Creación de tablas  
- Creación de secuencias  
- Tipos personalizados   
- Estructura base de la BBDD previa a la inserción de datos  

---

### **2. "EsquemaBBDD.png"**
Imagen del diagrama entidad-relación (ERD) de la base de datos.  
Permite visualizar:
- Tablas principales  
- Relaciones entre entidades  
- Cardinalidades  

Este esquema sirve de apoyo para entender mejor las consultas implementadas.

---

### **3. "Consultas_resueltas.sql"**
Archivo principal del proyecto.  
Incluye:
- Los **enunciados numerados** de cada consulta  
- La **solución SQL correspondiente**  
- Comentarios donde es necesario para mejorar la comprensión  
- Uso de `JOIN`, subconsultas, CTEs, funciones de agregación, operaciones con fechas, filtros lógicos, etc.

Todas las consultas han sido probadas y validadas en PostgreSQL.

---

## 🧠 Metodología seguida

1. **Creación del esquema:**  
   - Se utilizó el script de creación original de la BBDD "Film store rental".  
   - Se ejecutó en un entorno PostgreSQL (DBeaver) para obtener la estructura base.  
   - Se exportó toda la parte relativa al *schema* antes de cargar los datos, siguiendo las instrucciones del proyecto.

2. **Carga y exploración de datos:**  
   - La BBDD fue cargada y revisada para entender la estructura, llaves primarias, llaves foráneas y relaciones.  
   - Se generó el diagrama ER incluido en este repositorio.

3. **Resolución de consultas:**  
   - Se trabajó consulta por consulta siguiendo el orden del enunciado.  
   - Se aplicaron buenas prácticas SQL:  
      - Uso adecuado de joins  
      - CTEs cuando aportaban claridad  
      - Expresiones condicionales  
      - Funciones de fecha  
      - Agrupaciones y filtros con `HAVING`  
   - Cada consulta está acompañada de su enunciado para facilitar su lectura.

4. **Análisis final:**
   - Este proyecto ha consistido en el desarrollo y resolución de un conjunto de 64 consultas SQL aplicadas a una base de datos relacional del tipo videoclub. A lo largo del proceso se ha trabajado con         diferentes partes clave del lenguaje SQL, desde operaciones básicas hasta consultas complejas que integran múltiples tablas, subconsultas, CTEs y lógica basada en fechas.  
   - Cada bloque de ejercicios permitió extraer aprendizajes sobre el comportamiento de la BBDD, frecuentes patrones de consulta y estructura comercial del negocio simulado.  
   - El análisis general puede consultarse dentro del propio archivo `Consultas_resueltas.sql`.

---

## 🔍 Objetivos alcanzados

Durante el desarrollo del proyecto se han puesto en práctica conocimientos como:

- Modelado relacional y lectura de esquemas
- Consultas con `JOIN` de distinta complejidad
- Subconsultas y uso de `WITH` (CTEs)
- Funciones de agregación y filtros lógicos
- Gestión de fechas y duraciones
- Creación de vistas y tablas temporales
- Interpretación analítica de resultados

---

## 🛠️ Tecnologías utilizadas

- **SQL** (PostgreSQL)
- **DBeaver** como entorno de trabajo
- **Git & GitHub** para control de versiones
- **Herramientas de diagramación** (DBeaver ERD)

---

## 📄 Autor

Proyecto realizado por Juan Montero López como parte del módulo de SQL del máster "Data Analytics" impartido por The Power Business School.

---

## 📬 Contacto

Si deseas comentar mejoras o sugerencias, puedes abrir un *issue* en el repositorio.


