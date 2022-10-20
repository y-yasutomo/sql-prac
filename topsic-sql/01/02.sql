SELECT
    SLEEP_TIME_DTL.AGE_CODE as 年齢コード
    ,AGE_NAME as 年齢階層名
    ,sum(SP_TIME_5) as '5時間未満'
    ,sum(SP_TIME_6) as '5時間以上6時間未満'
    ,sum(SP_TIME_7) as '6時間以上7時間未満'
    ,sum(SP_TIME_8) as '7時間以上8時間未満'
    ,sum(SP_TIME_9) as '8時間以上9時間未満'
    ,sum(SP_TIME_9OVER) as '9時間以上'
FROM 
    SLEEP_TIME_DTL
INNER JOIN
    PREFECTURE ON SLEEP_TIME_DTL.PF_CODE = PREFECTURE.PF_CODE
INNER JOIN 
    AGE_GRP ON SLEEP_TIME_DTL.AGE_CODE = AGE_GRP.AGE_CODE
WHERE 
    PF_NAME in ('北海道','青森県','岩手県','宮城県','福島県')
GROUP BY
    SLEEP_TIME_DTL.AGE_CODE
    ,AGE_NAME
ORDER BY 
    SLEEP_TIME_DTL.AGE_CODE
;
