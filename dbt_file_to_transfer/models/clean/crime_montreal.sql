SELECT *
FROM crime_montreal_stage
WHERE
    pdq IS NOT NULL AND
    x IS NOT NULL AND
    y IS NOT NULL AND
    longitude IS NOT NULL AND
    latitude IS NOT NULL
