-- ==========================================
-- VENTAS TOTALES
-- ==========================================
-- KPI principal del negocio

SELECT 
    SUM("Total Amount") AS ventas_totales
FROM ventas;

-- ==========================================
-- VENTAS POR CATEGORÍA DE PRODUCTO
-- ==========================================

SELECT 
    "Product Category" AS categoria,
    SUM("Total Amount") AS ventas_totales
FROM ventas
GROUP BY "Product Category"
ORDER BY ventas_totales DESC;
-- Negocio: Identifica motores de ingresos.

-- ==========================================
-- VENTAS POR GÉNERO
-- ==========================================

SELECT 
    "Gender",
    SUM("Total Amount") AS ventas_totales
FROM ventas
GROUP BY "Gender"
ORDER BY ventas_totales DESC;
-- Negocio: Segmentación de clientes.

-- ==========================================
-- VENTAS POR TRIMESTRE
-- ==========================================

SELECT
    EXTRACT(YEAR FROM "Date") AS año,
    CONCAT('Q', EXTRACT(QUARTER FROM "Date")) AS trimestre,
    SUM("Total Amount") AS ventas_totales
FROM ventas
GROUP BY año, trimestre
ORDER BY año, trimestre;
-- Negocio: Detecta estacionalidad.

-- ==========================================
-- PARTICIPACIÓN DE VENTAS POR CATEGORÍA (%)
-- ==========================================

SELECT
    "Product Category" AS categoria,
    SUM("Total Amount") AS ventas_categoria,
    ROUND(
        SUM("Total Amount") * 100.0 / 
        (SELECT SUM("Total Amount") FROM ventas),
        2
    ) AS porcentaje_participacion
FROM ventas
GROUP BY "Product Category"
ORDER BY ventas_categoria DESC;
-- Negocio: Dependencia del negocio.

-- ==========================================
-- TICKET PROMEDIO
-- ==========================================

SELECT
    AVG("Total Amount") AS ticket_promedio
FROM ventas;
-- Negocio: Pricing y marketing.

-- ==========================================
-- VENTAS POR RANGO DE EDAD
-- ==========================================

SELECT
    CASE
        WHEN "Age" < 25 THEN 'Menores de 25'
        WHEN "Age" BETWEEN 25 AND 34 THEN '25-34'
        WHEN "Age" BETWEEN 35 AND 44 THEN '35-44'
        WHEN "Age" BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS rango_edad,
    SUM("Total Amount") AS ventas_totales
FROM ventas
GROUP BY rango_edad
ORDER BY ventas_totales DESC;
-- Negocio: Segmentación avanzada.

