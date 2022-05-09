--  IMDb Movie Project
--  Rick Sherman
--  Modified: 2022-04-28, 2021-12-09, 2021-12-02

-- BI Schema for People
-- PostgreSQL

-- Drop table
-- DROP TABLE IF EXISTS BI_list_names ;

-- people involved in the titles
CREATE TABLE BI_list_names (
	listRank int NULL default -1,
                  name_sk int not null,
	nconst varchar(10) NOT NULL,
  	primaryName varchar(255),

	fileName varchar(512) NULL,
	expandedList int null default -1,

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY  (name_sk)
);
-- CREATE NONCLUSTERED INDEX CIX_BI_list_names ON BI_list_names (nconst);

-- Drop table
-- DROP TABLE IF EXISTS BI_list_titles ;

-- list of titles
CREATE TABLE BI_list_titles  (
	listRank int NULL,
                  title_sk int not null,
	tconst varchar(10) NOT NULL,
	primaryTitle varchar(1024),

	fileName varchar(512) NULL,
	expandedList int null default -1,

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY  (title_sk)
);
-- CREATE NONCLUSTERED INDEX CIX_BI_list_titles ON BI_list_titles(tconst);

-- Drop table
-- DROP TABLE IF EXISTS BI_list_BRG_titles_names  ;

-- list of titles
CREATE TABLE BI_list_BRG_titles_names  (
                  name_sk int not null,
                  title_sk int not null,
	nconst varchar(10) NOT NULL,
	tconst varchar(10) NOT NULL,

	-- fileName varchar(512) NULL,
	expandedList int null default -1,

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY  (name_sk,title_sk)
);
-- CREATE NONCLUSTERED INDEX CIX_BI_list_BRG_titles_names ON BI_list_BRG_titles_names  (nconst,tconst);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_name_basics ;

-- people involved in the titles
CREATE SEQUENCE dim_imdb_name_basics_seq;

CREATE TABLE dim_imdb_name_basics (
                  name_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_name_basics_seq'),
	nconst varchar(10) NOT NULL,

	primaryName varchar(255),
	birthYear int,
	deathYear int,

	name_imdb_url varchar(255),

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
--	PRIMARY KEY NONCLUSTERED  (name_sk)
	PRIMARY KEY (name_sk)
);
-- CREATE CLUSTERED INDEX CIX_dim_imdb_name_basics ON dim_imdb_name_basics (nconst);

-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_titleType;

CREATE SEQUENCE dim_imdb_titleType_seq;

CREATE TABLE dim_imdb_titleType  (
	titleType_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_titleType_seq'),

	titleType varchar(255),
	titleCategory varchar(255),

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (titleType_sk)
);

-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_title_basics;

CREATE SEQUENCE dim_imdb_title_basics_seq;

CREATE TABLE dim_imdb_title_basics (
                 title_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_title_basics_seq'),
	tconst varchar(10) NOT NULL,

	titleType_sk int,    -- new FK

	primaryTitle varchar(1024),
	originalTitle varchar(1024),
	isAdult smallint,
	startYear int,
	endYear int,
	runtimeMinutes int,

	title_imdb_url varchar(255),

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- 	PRIMARY KEY NONCLUSTERED  (title_sk)
	PRIMARY KEY (title_sk)
);
-- CREATE CLUSTERED INDEX CIX_dim_imdb_title_basics  ON dim_imdb_title_basics (tconst);


-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_primaryProfession;

CREATE SEQUENCE dim_imdb_primaryProfession_seq;

CREATE TABLE dim_imdb_primaryProfession   (
	primaryProfession_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_primaryProfession_seq'),
    primaryProfession varchar(255),

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (primaryProfession_sk)
);

-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_name_basics_knownForTitles;

CREATE SEQUENCE dim_imdb_name_basics_knownForTitles_seq;

CREATE TABLE dim_imdb_name_basics_knownForTitles (
	knownForTitles_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_name_basics_knownForTitles_seq'),

                 name_sk int not null, 
	title_sk int not null, -- knownForTitles varchar(1024),
	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (knownForTitles_sk)
);
-- -- CREATE INDEX IDX_dim_imdb_name_basics_knownForTitles   ON dim_imdb_name_basics_knownForTitles  (name_sk, title_sk);

-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_name_basics_primaryProfession;

CREATE SEQUENCE dim_imdb_name_basics_primaryProfession_seq;

CREATE TABLE dim_imdb_name_basics_primaryProfession (
	name_basics_primaryProfession_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_name_basics_primaryProfession_seq'),

                  name_sk int, 
	primaryProfession_sk int,
	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (name_basics_primaryProfession_sk)
);
--  -- CREATE INDEX IDX_dim_imdb_name_basics_primaryProfession    ON dim_imdb_name_basics_primaryProfession   (name_sk,primaryProfession_sk);


-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_genres;

CREATE SEQUENCE dim_imdb_genres_seq;

CREATE TABLE dim_imdb_genres   (
	genres_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_genres_seq'),

	genres varchar(255),
                  genre_source varchar(80),              -- imdb or MovieLens               
	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (genres_sk)
);

-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_title_basics_genres ;

CREATE SEQUENCE dim_imdb_title_basics_genres_seq;

CREATE TABLE dim_imdb_title_basics_genres (
	titles_genres_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_title_basics_genres_seq'),

                  title_sk int,
	genres_sk int,
                  genre_source varchar(80),              -- imdb or MovieLens     
	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (titles_genres_sk)
);
-- -- CREATE INDEX IDX_SK_dim_imdb_title_basics_genres    ON dim_imdb_title_basics_genres (title_sk,genres_sk);

-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_title_crew_directors;

CREATE SEQUENCE dim_imdb_title_crew_directors_seq;

CREATE TABLE dim_imdb_title_crew_directors (
	directors_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_title_crew_directors_seq'),
                  title_sk int,
                  name_sk int,

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (directors_sk)
);
-- CREATE INDEX IDX_SK_dim_imdb_title_crew_directors     ON dim_imdb_title_crew_directors (title_sk,name_sk);

-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_title_crew_writers ;

CREATE SEQUENCE dim_imdb_title_crew_writers_seq;

CREATE TABLE dim_imdb_title_crew_writers (
	writers_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_title_crew_writers_seq'),
                 title_sk int,
                 name_sk int,

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (writers_sk)
);
-- CREATE INDEX IDX_SK_dim_imdb_title_crew_writers     ON dim_imdb_title_crew_writers (title_sk,name_sk);

-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_title_episode ;

CREATE SEQUENCE dim_imdb_title_episode_seq;

CREATE TABLE dim_imdb_title_episode (
	title_episode_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_title_episode_seq'),

                 title_sk int,
                 parent_title_sk int,
	seasonNumber int,
	episodeNumber int,

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (title_episode_sk)
);
-- CREATE INDEX IDX_SK_dim_imdb_title_episode     ON dim_imdb_title_episode (title_sk,parent_title_sk);


-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_job_category;

CREATE SEQUENCE dim_imdb_job_category_seq;

CREATE TABLE dim_imdb_job_category   (
	job_category_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_job_category_seq'),
	job_category varchar(255),        
	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (job_category_sk)
);

-- Drop table
-- DROP TABLE IF EXISTS dim_imdb_title_principals 

CREATE SEQUENCE dim_imdb_title_principals_seq;

CREATE TABLE dim_imdb_title_principals (
	title_principals_sk int NOT NULL DEFAULT NEXTVAL ('dim_imdb_title_principals_seq'),

                  title_sk int not null,
                  name_sk int not null,
	title_ordering int NOT NULL,

	job_category_sk int,
	job_title varchar(1024),
	character_name varchar(1024),

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (title_principals_sk) -- (tconst,[ordering])
);
CREATE UNIQUE INDEX UDX_SK_dim_imdb_title_principals      ON dim_imdb_title_principals (title_sk,name_sk,title_ordering);

-- Drop table
-- DROP TABLE IF EXISTS fct_imdb_title_ratings ;

CREATE SEQUENCE fct_imdb_title_ratings_seq;

CREATE TABLE fct_imdb_title_ratings (
	title_ratings_sk int NOT NULL DEFAULT NEXTVAL ('fct_imdb_title_ratings_seq'),

                 title_sk int not null,
	averageRating real,
	numVotes int,

	DI_JobID varchar(20) NOT NULL,
	DI_Create_DT timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (title_ratings_sk)
);
-- CREATE INDEX IDX_SK_fct_imdb_title_ratings     ON fct_imdb_title_ratings (title_sk);

-- Create view for TV episodes --------------------------------------------------------------------------------------------

create view dim_imdb_title_basics_episodes_vw as
select
	title_sk,
	tconst,
	titleType_sk,
	primaryTitle,
	originalTitle,
	isAdult,
	startYear,
	endYear,
	runtimeMinutes,
	title_imdb_url
from dim_imdb_title_basics
;



