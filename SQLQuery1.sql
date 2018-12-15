/*script for data cleaning after generating the data*/
/*the reseason and indicators were randomly mixed and not matching*/

SELECT*FROM dbo.insurance

SELECT * FROM dbo.insurance WHERE fraud_claim_reason LIKE 'inflated figure'



/*reason being matched with the dates*/
UPDATE dbo.insurance
SET fraud_claim_reason = 'expired policy' 
FROM dbo.insurance
WHERE dbo.insurance.date_of_claim > policy_end


/*indicator being mached with the reasons*/
UPDATE dbo.insurance
SET fraud_claim_indicator = 1
FROM dbo.insurance
WHERE dbo.insurance.fraud_claim_reason LIKE 'expired policy'



/*replacing the figures with 0s to suit the didnot pay premium reason*/
UPDATE dbo.insurance
SET total_premium = 0
FROM dbo.insurance
WHERE dbo.insurance.fraud_claim_reason LIKE 'didnot pay premium'



/*anonymization*/
ALTER TABLE dbo.dataclean  ALTER COLUMN holder_name
ADD MASKED WITH (FUNCTION = 'partial(2,"xxx",0)');

ALTER TABLE dbo.dataclean  ALTER COLUMN holder_surname
ADD MASKED WITH (FUNCTION = 'partial(3,"xxx",1)');

ALTER TABLE dbo.dataclean  ALTER COLUMN holder_DOB
ADD MASKED WITH (FUNCTION = 'default()');


ALTER TABLE dbo.dataclean  ALTER COLUMN holder_street
ADD MASKED WITH (FUNCTION = 'partial(1,"xxx",1)');

 