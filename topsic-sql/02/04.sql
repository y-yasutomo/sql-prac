SELECT
    pr.PF_NAME
    ,SUM(COALESCE(es.ELEMENTARY,0)) as sum_ELEMENTARY
    ,SUM(COALESCE(es.MIDDLE,0)) as sum_MIDDLE
    ,SUM(COALESCE(es.HIGH,0)) as sum_HIGH
    ,SUM(COALESCE(es.JUNIOR_CLG,0)) as sum_JUNIOR_CLG
    ,SUM(COALESCE(es.COLLEGE,0)) as sum_COLLEGE
    ,SUM(COALESCE(es.GRADUATE,0)) as sum_GRADUATE
FROM
    ENROLLMENT_STATUS as es
INNER JOIN PREFECTURE  as pr ON  es.PF_CODE = pr.PF_CODE
WHERE 
    SURVEY_YEAR = 2020
GROUP BY 
    es.PF_CODE
;