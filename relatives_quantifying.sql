--Script allows to quantify the number of brothers/sisters and male/female cousins 
--for every person in the example table

WITH
  --Making a table where each relative's ID corresponds his brothers' and sisters' IDs
  all_siblings AS (SELECT r1.id     AS id, 
                          r2.id     AS sibl_id, 
                          r2.gender AS gender 
                  FROM relatives r1
                  LEFT OUTER JOIN relatives r2 ON r1.parent_id = r2.parent_id AND r1.id != r2.id)
SELECT r1.id, r1.name,
  --Filtering by gender to get separate brothers and sisters columns
  (SELECT COUNT(sibl_id) FROM all_siblings WHERE id = r1.id AND gender = 'm') AS brothers, 
  (SELECT COUNT(sibl_id) FROM all_siblings WHERE id = r1.id AND gender = 'f') AS sisters,
  --Taking 2-nd level hierarchical queries
  (SELECT COUNT(id) FROM relatives WHERE level = 2 AND gender = 'm'
    CONNECT BY PRIOR id = parent_id
    --Choosing root string from all_siblings table as each relative's parent brothers' IDs
    START WITH id IN (select sibl_id FROM all_siblings where id = r1.parent_id)) AS male_cousins,
  (SELECT COUNT(id) FROM relatives WHERE level = 2 AND gender = 'f'
    CONNECT BY PRIOR id = parent_id
    --Choosing root string from all_siblings table as each relative's parent sisters' IDs
    START WITH id IN (SELECT sibl_id FROM all_siblings WHERE id = r1.parent_id)) AS female_cousins
FROM relatives r1
ORDER BY r1.id;