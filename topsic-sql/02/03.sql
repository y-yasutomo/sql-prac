SELECT
        tg.PF_CODE as CODE
        ,pr.PF_NAME as 'NAME'
        ,ROUND((1.0*tg.sum_tgt/tmp.sum_amt)*100,1) as 'PERCENTAGE'
FROM (
    SELECT
        PF_CODE
        ,sum(AMT) as sum_tgt
    FROM
        DRINK_HABITS
    WHERE (GENDER_CODE != '1') and (CATEGORY_CODE = '120')
    GROUP BY 
        PF_CODE
    ) as tg
INNER JOIN(
    SELECT
        PF_CODE
        ,sum(AMT) as sum_amt
    FROM
        DRINK_HABITS
    WHERE (GENDER_CODE != '1') and (CATEGORY_CODE = '110')
    GROUP BY 
        PF_CODE
)as tmp ON tg.PF_CODE = tmp.PF_CODE
INNER JOIN PREFECTURE as pr ON tg.PF_CODE = pr.PF_CODE
ORDER BY 
    PERCENTAGE DESC
    ,CODE DESC
;

