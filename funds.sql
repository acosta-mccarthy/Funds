SELECT
  f.fund_code AS "Fund Code",
  fpn.name,
CASE
  WHEN f.appropriation > 0 THEN CONCAT((f.expenditure*100)/f.appropriation, '%') END AS "Percent Spent",
  CONCAT(((CURRENT_DATE - '2018-07-01')*100)/365, '%') AS "Percent of FY",
  CAST (f.appropriation/100 AS money) AS "Appropriation",
  CAST (f.expenditure/100 as money) AS "Expenditure",
  CAST (f.encumbrance/100 as money) AS "Encumbrance"


FROM sierra_view.fund AS f
JOIN sierra_view.fund_master AS fm ON fm.code = f.fund_code
JOIN sierra_view.external_fund_property_name AS fp ON fp.external_fund_property_id = fm.id
JOIN sierra_view.fund_property_name AS fpn ON fpn.fund_property_id = fp.external_fund_property_id

WHERE
  f.fund_type = 'fbal' AND
  f.appropriation > 0
GROUP BY
   f.fund_code, fpn.name, f.appropriation, f.expenditure, f.encumbrance
ORDER BY

  f.fund_code;
