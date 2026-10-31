\set ON_ERROR_STOP on

BEGIN;

TRUNCATE TABLE foods, food_name;

\copy foods (id, food_group, food_name, energy, moisture, protein, lipid, food_fiber, carbohydrate, natrium, potassium, calcium, magnesium, phosphorus, iron, zinc, copper, manganese, iodine, selenium, chrome, molybdenum, vitamin_a, vitamin_d, vitamin_e, vitamin_k, vitamin_b1, vitamin_b2, niacin, vitamin_b6, vitamin_b12, folic_acid, pantothenic_acid, biotin, vitamin_c, sodium_content, other) FROM 'food_data_0410.csv' WITH (FORMAT csv, ENCODING 'UTF8');

\copy food_name (id, food_group, food_name, other) FROM 'food_name_data_0415.csv' WITH (FORMAT csv, ENCODING 'UTF8');

COMMIT;
