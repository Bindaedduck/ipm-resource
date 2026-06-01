-- 자동화속성 count
COUNT(CASE WHEN eventlog.Automated='true' THEN 1 END) / COUNT(eventlog.Automated)

-- cost 필터
SELECT
	e.ACTIVITY,
	SUM(e.cost) AS sum_cost,
	COUNT(*) AS tot_count,
	AVG(e.cost) AS avg_cost
FROM eventlog e
WHERE e.CASEID IN (
	SELECT caseid FROM case_stats WHERE cost > 100000
)
AND e.ACTIVITY IN ('액티비티명',...)
GROUP BY e.ACTIVITY
ORDER BY sum)cost DESC;

-- activity wait time 필터
WITH wt AS(
	SELECT
		caseid,
		activity,
		starttime - LAG(starttime) OVER(PARTITION BY caseid ORDER BY starttime) AS wait_time
	FROM eventlog
),
kpi_exceeded_cases AS (
	SELECT DISTINCT caseid
	FROM wt
	WHERE wait_time > 10 * 24 * 60 * 60 * 1000
)
SELECT
	activity,
	COUNT(*) AS total_count
FROM eventlog
WHERE caseid IN (SELECT caseid FROM kpi_exceeded_cases)
AND eventlog.ACTIVITY IN ('액티비티명',...)
GROUP BY activity
ORDER BY total_count DESC;

-- 활동 통계 표시 > 처리량
AVG(eventlog.WAITTIME)

-- 활동 통계 표시 > 서비스 시간(endtime 있을 시)
AVG(eventlog.SERVICETIME)