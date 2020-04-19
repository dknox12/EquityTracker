-- =========================================
-- Create table tbsecurities
-- /* Parent table of Securities hierarchy */
-- =========================================


/* IF EXISTS DROP TABLE tbsecurities;--, tbportfolios, tbearnings, tbearningsnews; */

/*IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tbsecurities') AND type in (N'P', N'PC'))
  DROP TABLE tbsecurities
  GO */

-- Drop Existing Tables
IF(OBJECT_ID(N'[dbo].[tbsecurities]',			'U') is not null) DROP TABLE tbsecurities
IF(OBJECT_ID(N'[dbo].[tbportfolios]',			'U') is not null) DROP TABLE tbportfolios
IF(OBJECT_ID(N'[dbo].[tbearnings]',				'U') is not null) DROP TABLE tbearnings
IF(OBJECT_ID(N'[dbo].[tbevents]',				'U') is not null) DROP TABLE tbevents
IF(OBJECT_ID(N'[dbo].[tbeventrelated]',			'U') is not null) DROP TABLE tbeventrelated
--IF(OBJECT_ID(N'[dbo].[tbsecurities]',			'U') is not null) DROP TABLE tbsecurities
--IF(OBJECT_ID(N'[dbo].[tbsecurities]',			'U') is not null) DROP TABLE tbsecurities
--IF(OBJECT_ID(N'[dbo].[tbsecurities]',			'U') is not null) DROP TABLE tbsecurities


CREATE TABLE tbsecurities
(
	securityID int,
	securityDesc varchar(255),
	ticker varchar(50),
	-- closingPrice(dec(20,10),
	dateCreated datetime,
	dateModified datetime,
	dateDeleted datetime,
	deletedFlag bit,
	hiddenFlag bit
)
GO


CREATE TABLE tbportfolios
(
	portfolioid int,
	portname varchar(100),
	portsector varchar(50),
	sortorder int,
	dateCreated datetime,
	dateModified datetime,
	dateDeleted datetime,
	deletedFlag bit,
	hiddenFlag bit
)
GO

CREATE TABLE tbearnings
(
	earningsid int,
	earnquarter int,
	earndate date,
	earntime time,
	outstandingcommonshares bigint,
	expectedeps money,
	actualeps money,
	epsbeatloss money,
	expectedrevmill money,
	actualrevmill money,
	revbeatloss money,
	expectednetincomemill money,
	actualnetincomemill money,
	netincomebeatloss money,
	dateCreated datetime,
	dateModified datetime,
	dateDeleted datetime,
	deletedFlag bit,
	hiddenFlag bit
)
GO

CREATE TABLE tbevents
(
	eventid int,
	releasedate datetime, -- date the news  happened, not impact date in the future
	eventtitle varchar(150),
	eventdesc varchar(5000),
	followup_date datetime,
	newssource varchar (500),
	newssourceauthor varchar (500),
	newssourcelink varchar(4000),
	dateCreated datetime,
	dateModified datetime,
	dateDeleted datetime,
	deletedFlag bit,
	hiddenFlag bit
)
GO

CREATE TABLE tbeventrelated
(
	eventrelatedid int,
	eventid1 int,
	eventid2 int,
	reasoncategory varchar(150),
	reason varchar(1000),
	dateCreated datetime,
	dateModified datetime,
	dateDeleted datetime,
	deletedFlag bit,
	hiddenFlag bit
)
GO

/*
security types table
pricing table
financials
earnings details, dates, expected earnings etc
new initiatives
news releases
board of directors
management


*/