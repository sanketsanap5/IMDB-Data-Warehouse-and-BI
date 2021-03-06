/****** IMDb Project  ******/

-- 
-- IMDb Project
-- Staging tables  SQL Server
-- Last updated: 2022-04-24, 2022-04-21
-- Rick Sherman 
--
--


----- IMDb Core dataset -----------------------------------------------------------------------------------------------------

DROP TABLE if exists stg_imdb_name_basics ;

CREATE TABLE stg_imdb_name_basics (
	nconst nvarchar(10) NOT NULL,
	primaryName nvarchar(255),
	birthYear int,
	deathYear int,
	birthYear_char nvarchar(4),
	deathYear_char nvarchar(4),
	primaryProfession nvarchar(255),
	knownForTitles nvarchar(1024),

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	-- -- SOR_FileID int NULL,
	-- -- SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (nconst)
);

DROP TABLE if exists stg_imdb_title_akas ;

CREATE TABLE stg_imdb_title_akas (
	titleId nvarchar(10) NOT NULL,  -- really tconst
	[ordering] int NOT NULL,
	title nvarchar(1024),
	region nvarchar(255),
	[language] nvarchar(255),
	types nvarchar(255),
	[attributes] nvarchar(1024),
	isOriginalTitle nvarchar(255),

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	-- SOR_FileID int NULL,
	-- SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (titleId,[ordering])
);

DROP TABLE if exists stg_imdb_title_basics ;

CREATE TABLE stg_imdb_title_basics (
	tconst nvarchar(10) NOT NULL,
	titleType nvarchar(255),
	primaryTitle nvarchar(1024),
	originalTitle nvarchar(1024),
	isAdult bit,
	startYear int,
	endYear int,
	runtimeMinutes int,
	startYear_char nvarchar(4),
	endYear_char nvarchar(4),
	runtimeMinutes_char nvarchar(10),
	genres nvarchar(255),

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	-- SOR_FileID int NULL,
	-- SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (tconst)
);

DROP TABLE if exists stg_imdb_title_crew ;

CREATE TABLE stg_imdb_title_crew (
	tconst nvarchar(10) NOT NULL,
	directors nvarchar(4000),
	writers nvarchar(4000),

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	-- SOR_FileID int NULL,
	-- SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (tconst)
);

DROP TABLE if exists stg_imdb_title_episode ;

CREATE TABLE stg_imdb_title_episode (
	tconst nvarchar(10) NOT NULL,
	parentTconst nvarchar(10),
	seasonNumber int,
	episodeNumber int,
	seasonNumber_char nvarchar(10),
	episodeNumber_char nvarchar(10),

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	-- SOR_FileID int NULL,
	-- SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (tconst)
);

DROP TABLE if exists stg_imdb_title_principals ;

CREATE TABLE stg_imdb_title_principals (
	tconst nvarchar(10) NOT NULL,
	[ordering] int NOT NULL,
	nconst nvarchar(10),
	category nvarchar(255),
	job nvarchar(1024),
	[characters] nvarchar(1024),

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	-- SOR_FileID int NULL,
	-- SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (tconst,[ordering])
);

DROP TABLE if exists stg_imdb_title_ratings ;

CREATE TABLE stg_imdb_title_ratings (
	tconst nvarchar(10) NOT NULL,
	averageRating real,
	numVotes int,

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	-- SOR_FileID int NULL,
	-- SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (tconst)
);


----- IMDb Extended dataset -----------------------------------------------------------------------------------------------------

------- Box Office Ranking Top 1k by Revenue

DROP TABLE if exists stg_box_office_worldwide ;

CREATE TABLE stg_box_office_worldwide (  -- update 2022-04-24
	box_office_worldwide_sk int NOT NULL IDENTITY(1,1),
	BoxOffice_Rank int,
	tconst nvarchar(10),
	Title nvarchar(255),
	Worldwide_LifetimeGross bigint,
	Domestic_LifetimeGross bigint,
	Domestic_Pct real,
	Foreign_LifetimeGross bigint,
	Foreign_Pct real,
	Release_Year int,

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	SOR_FileID int NULL,
	SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (box_office_worldwide_sk)
);

DROP TABLE if exists imdb_dev.dbo.stg_box_office_worldwide_reject ;

CREATE TABLE stg_box_office_worldwide_reject (
	box_office_worldwide_reject_sk int NOT NULL IDENTITY(1,1),
	BoxOffice_Rank int,

	tconst nvarchar(10) null,

	Title nvarchar(255) not null,

	RevisedTitle nvarchar(255),

	Worldwide_LifetimeGross bigint,
	Domestic_LifetimeGross bigint,
	Domestic_Pct real,
	Foreign_LifetimeGross bigint,
	Foreign_Pct real,
	Release_Year int,

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	SOR_FileID int NULL,
	SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (box_office_worldwide_reject_sk)
);

------- Movie Daily Box Office ----------------------------

DROP TABLE if exists stg_numbers_daily_box_office ;

CREATE TABLE stg_numbers_daily_box_office ( -- 2022-04-24
	daily_box_office_sk int NOT NULL IDENTITY(1,1),
	Movie_Name nvarchar(255) NOT NULL,
	Show_Date datetime NOT NULL,
	Daily_Rank int,
	Daily_Gross bigint,
	Daily_Change_Pct decimal(10,3),
	Weekly_Change_Pct decimal(10,3),
	Number_of_Theaters int,
	Gross_Per_Theater bigint,
	Total_Gross bigint,
	Number_of_Days int,

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	SOR_FileID int NULL,
	SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (daily_box_office_sk)
);

------- Movie Brands ----------------------------

DROP TABLE if exists stg_imdb_brands_gross ;

CREATE TABLE stg_imdb_brands_gross (  -- 2022-04-24
	Brands_Gross_SK int NOT NULL IDENTITY(1,1),
	Brand_Name nvarchar(80),
	Total_Revenue bigint,
	Number_of_Releases int,
	Top_Release nvarchar(255),
	Lifetime_Gross bigint,

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	SOR_FileID int NULL,
	SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (Brands_Gross_SK)
);

DROP TABLE if exists stg_imdb_brands_list ;

CREATE TABLE stg_imdb_brands_list ( -- 2022-04-24
	Brands_Lists_SK int NOT NULL IDENTITY(1,1),
	Brand_Name nvarchar(255),
	Realease_Rank int,
	Release_Name nvarchar(255),
	Lifetime_Gross bigint,
	Max_Theaters int,
	Opening_Gross bigint,
	Open_Theaters int,
	Release_Date datetime,
	Distributor nvarchar(255),

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	SOR_FileID int NULL,
	SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (Brands_Lists_SK)
);

------- Movie Franchises ----------------------------

DROP TABLE if exists stg_imdb_franchises_gross ;

CREATE TABLE stg_imdb_franchises_gross ( -- 2022-04-24
	Franchises_Gross_SK int NOT NULL IDENTITY(1,1),
	Franchise nvarchar(80),
	Total_Revenue bigint,
	Number_of_Releases int,
	Top_Release nvarchar(255),
	Lifetime_Gross bigint,

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	SOR_FileID int NULL,
	SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (Franchises_Gross_SK)
);

DROP TABLE if exists stg_imdb_franchises_list ;

CREATE TABLE stg_imdb_franchises_list ( -- 2022-04-24
	Franchises_Lists_SK int NOT NULL IDENTITY(1,1),
	Franchise nvarchar(255),
	Realease_Rank int,
	Release_Name nvarchar(255),
	Lifetime_Gross bigint,
	Max_Theaters int,
	Opening_Gross bigint,
	Open_Theaters int,
	Release_Date datetime,
	Distributor nvarchar(255),

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	SOR_FileID int NULL,
	SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (Franchises_Lists_SK)
);

DROP TABLE if exists stg_numbers_frachise_all_box_office ;

CREATE TABLE stg_numbers_frachise_all_box_office (  -- 2022-04-24
	frachise_all_box_office_sk int NOT NULL IDENTITY(1,1),
	Franchise nvarchar(255) NOT NULL,
	No_of_Movies int NOT NULL,
	Domestic_Box_Office bigint NOT NULL,
	Infl_Adj_Dom_Box_Office bigint NOT NULL,
	Worldwide_Box_Office bigint NOT NULL,
	First_Year int NOT NULL,
	Last_Year int NOT NULL,
	No_of_Years int NOT NULL,

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	SOR_FileID int NULL,
	SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (frachise_all_box_office_sk)
);

DROP TABLE if exists stg_numbers_frachise_movies_box_office ;

CREATE TABLE stg_numbers_frachise_movies_box_office ( -- 2022-04-24
	frachise_movies_box_office_sk int NOT NULL IDENTITY(1,1),
	Franchise nvarchar(255) NOT NULL,
	Release_Date datetime NOT NULL,
	Movie_Name nvarchar(255) NOT NULL,
	Production_Budget bigint,
	Opening_Weekend bigint,
	Domestic_Box_Office bigint,
	Worldwide_Box_Office bigint,

	DI_JobID nvarchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	SOR_FileID int NULL,
	SOR_FileName nvarchar(128) NULL,
	PRIMARY KEY (frachise_movies_box_office_sk)
);

---------------------------------------------------------------------------------------------------------------------------------
-- Reference Table

DROP TABLE if exists stg_imdb_titleType;

CREATE TABLE stg_imdb_titleType (
	titleType_sk int NOT NULL IDENTITY(1,1),
	titleType varchar(255) NULL,
	titleCategory varchar(255) NULL,

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	PRIMARY KEY (titleType_sk)
);

-- Tracking file ingestion
DROP TABLE if exists DI_stg_file_ingest;

CREATE TABLE DI_stg_file_ingest (
	DI_stg_file_ingest int NOT NULL IDENTITY(1,1),
	File_Group varchar(80) NULL,
	FileName varchar(512) NULL,
	FileRows int NULL,
                  File_LoopCounter int NULL,
	RowsInserted int NULL,
	DI_JobID varchar(20) NULL,
	DI_Create_DT datetime DEFAULT (getdate()) NOT NULL,
	PRIMARY KEY (DI_stg_file_ingest)
);