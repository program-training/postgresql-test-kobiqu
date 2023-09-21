-- 1

--  כל העובדים

SELECT * FROM orders 

-- 2

-- כמות מוצרים

SELECT COUNT(product_id) FROM products 

-- 5

-- קטגןריה עם יותר מ 10 מוצרים

SELECT category_id
FROM categories
WHERE (
        SELECT
            COUNT(category_id)
        FROM products
    ) > 10
GROUP BY category_id

-- 6

-- שם קטגוריה מעל 10 מוצרים

SELECT category_name
FROM categories
WHERE (
        SELECT
            COUNT(category_id)
        FROM products
    ) > 10
GROUP BY category_name

-- 8

SELECT
    emp.first_name || ' ' || emp.last_name AS full_name,
    de AS area_description
FROM (
        SELECT
            empt.employee_id AS emp_id,
            empt.territory_id,
            territories.territory_description AS de
        FROM
            employee_territories AS empt
            INNER JOIN territories ON territories.territory_id = empt.territory_id
        GROUP BY
            empt.employee_id,
            empt.territory_id,
            territories.territory_description
    ) AS new_table
    INNER JOIN employees AS emp ON new_table.emp_id = emp.employee_id
GROUP BY emp.employee_id, de

-- 9

-- שם מלא

SELECT
    emp.first_name || ' ' || emp.last_name AS full_name,
    COUNT(o.employee_id) AS orders_sum
FROM employees AS emp
    INNER JOIN orders AS o ON (
        SELECT
            COUNT(employee_id)
        FROM orders
    ) > 100
WHERE
    emp.employee_id = o.employee_id
GROUP BY emp.employee_id
