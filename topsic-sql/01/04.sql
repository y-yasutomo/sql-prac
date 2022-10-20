    SELECT 
        PF_CODE as '都道府県コード'
        ,PF_NAME as '都道府県名'
        ,max(CASE WHEN rnk = 1 THEN NATION_NAME END) as '1位 国名'
        ,sum(CASE WHEN rnk = 1 THEN AMT ELSE 0 END) as '1位 人数'
        ,max(CASE WHEN rnk = 2 THEN NATION_NAME END) as '2位 国名'
        ,sum(CASE WHEN rnk = 2 THEN AMT ELSE 0 END) as '2位 人数'
        ,max(CASE WHEN rnk = 3 THEN NATION_NAME END) as '3位 国名'
        ,sum(CASE WHEN rnk = 3 THEN AMT ELSE 0 END) as '3位 人数'
        ,sum(AMT) as '合計人数'
    FROM (
        SELECT
            f.PF_CODE
            ,p.PF_NAME
            ,f.NATION_CODE
            ,n.NATION_NAME
            ,AMT
            ,RANK() OVER (
                PARTITION BY f.PF_CODE
                ORDER BY AMT DESC , f.NATION_CODE ASC
                ) as rnk
        FROM 
            FOREIGNER as f
        INNER JOIN PREFECTURE as p ON f.PF_CODE = p.PF_CODE
        INNER JOIN NATIONALITY as n ON f.NATION_CODE = n.NATION_CODE
        WHERE 
            f.NATION_CODE <> '113'
        )
    GROUP BY 
        PF_CODE
        ,PF_NAME
    ORDER BY 
        合計人数 desc 
        ,PF_CODE
;


/*
with temp as (
    SELECT 
        PF_CODE
        ,PF_NAME
        ,sum(CASE WHEN rnk = 1 THEn AMT ELSE 0 END) as 'fst'
        ,sum(CASE WHEN rnk = 2 THEn AMT ELSE 0 END) as 'sec'
        ,sum(CASE WHEN rnk = 3 THEn AMT ELSE 0 END) as 'thr'
        ,sum(AMT) as '合計人数'
    FROM (
        SELECT
            f.PF_CODE
            ,p.PF_NAME
            ,f.NATION_CODE
            ,n.NATION_NAME
            ,AMT
            ,RANK() OVER (
                PARTITION BY f.PF_CODE
                ORDER BY AMT DESC , f.NATION_CODE ASC
                ) as rnk
        FROM 
            FOREIGNER as f
        INNER JOIN PREFECTURE as p ON f.PF_CODE = p.PF_CODE
        INNER JOIN NATIONALITY as n ON f.NATION_CODE = n.NATION_CODE
        WHERE 
            f.NATION_CODE <> '113'
        )
    GROUP BY 
        PF_CODE
        ,PF_NAME
    ORDER BY 
        合計人数 desc 
        ,PF_CODE
)
, temp2 as (
    SELECT
            f.PF_CODE
            ,f.NATION_CODE
            ,n.NATION_NAME
            ,AMT
            ,RANK() OVER (
                PARTITION BY f.PF_CODE
                ORDER BY AMT DESC , f.NATION_CODE ASC
                ) as rnk
        FROM 
            FOREIGNER as f
        INNER JOIN PREFECTURE as p ON f.PF_CODE = p.PF_CODE
        INNER JOIN NATIONALITY as n ON f.NATION_CODE = n.NATION_CODE
        WHERE 
            f.NATION_CODE <> '113'
)
    SELECT temp.PF_CODE as '都道府県コード'
            ,temp.PF_NAME as '都道府県名'
            ,temp2.NATION_NAME as '1位 国名'
            ,fst as '1位 人数'
            ,t3.NATION_NAME as '2位 国名'
            ,sec as '2位 人数'
            ,t4.NATION_NAME as '3位 国名'
            ,thr as '3位 人数'
            ,合計人数
    FROM temp
    INNER JOIN temp2 ON temp.PF_CODE = temp2.PF_CODE and
                        temp.fst = temp2.AMT 
    INNER JOIN temp2 as t3 ON temp.PF_CODE = t3.PF_CODE and
                        temp.sec = t3.AMT 
    INNER JOIN temp2 as t4 ON temp.PF_CODE = t4.PF_CODE and
                        temp.thr = t4.AMT 
;
*/