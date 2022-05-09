-- imdb project
-- Stage Tables STG - Alternative ONLY
-- PostgreSQL
-- 
-- r sherman
-- 2022-04-21

-- imdb_dev.stg_imdb_name_basics 

CREATE TABLE stg_imdb_name_basics (
  nconst varchar(10)  NOT NULL,
  primaryName varchar(255)  DEFAULT NULL,
  birthYear int DEFAULT NULL,
  deathYear int DEFAULT NULL,
  birthYear_char varchar(4)  DEFAULT NULL,
  deathYear_char varchar(4)  DEFAULT NULL,
  primaryProfession varchar(255)  DEFAULT NULL,
  knownForTitles varchar(1024)  DEFAULT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (nconst)
) ;

-- imdb_dev.stg_imdb_title_akas 

CREATE TABLE stg_imdb_title_akas (
  titleId varchar(10)  NOT NULL,
  ordering int NOT NULL,
  title varchar(1024)  DEFAULT NULL,
  region varchar(255)  DEFAULT NULL,
  language varchar(255)  DEFAULT NULL,
  types varchar(255)  DEFAULT NULL,
  attributes varchar(1024)  DEFAULT NULL,
  isOriginalTitle varchar(255)  DEFAULT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (titleId,ordering)
) ;


-- imdb_dev.stg_imdb_title_basics 

CREATE TABLE stg_imdb_title_basics (
  tconst varchar(10)  NOT NULL,
  titleType varchar(255)  DEFAULT NULL,
  primaryTitle varchar(1024)  DEFAULT NULL,
  originalTitle varchar(1024)  DEFAULT NULL,
  isAdult smallint DEFAULT NULL,
  startYear int DEFAULT NULL,
  endYear int DEFAULT NULL,
  runtimeMinutes int DEFAULT NULL,
  startYear_char varchar(4)  DEFAULT NULL,
  endYear_char varchar(4)  DEFAULT NULL,
  runtimeMinutes_char varchar(10)  DEFAULT NULL,
  genres varchar(255)  DEFAULT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (tconst)
) ;


-- imdb_dev.stg_imdb_title_crew 

CREATE TABLE stg_imdb_title_crew (
  tconst varchar(10)  NOT NULL,
  directors varchar(4000)  DEFAULT NULL,
  writers varchar(4000)  DEFAULT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (tconst)
) ;


-- imdb_dev.stg_imdb_title_episode 

CREATE TABLE stg_imdb_title_episode (
  tconst varchar(10)  NOT NULL,
  parentTconst varchar(10)  DEFAULT NULL,
  seasonNumber int DEFAULT NULL,
  episodeNumber int DEFAULT NULL,
  seasonNumber_char varchar(10)  DEFAULT NULL,
  episodeNumber_char varchar(10)  DEFAULT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (tconst)
) ;


-- imdb_dev.stg_imdb_title_principals 

CREATE TABLE stg_imdb_title_principals (
  tconst varchar(10)  NOT NULL,
  ordering int NOT NULL,
  nconst varchar(10)  DEFAULT NULL,
  category varchar(255)  DEFAULT NULL,
  job varchar(1024)  DEFAULT NULL,
  characters varchar(1024)  DEFAULT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (tconst,ordering)
) ;


-- imdb_dev.stg_imdb_title_ratings 

CREATE TABLE stg_imdb_title_ratings (
  tconst varchar(10)  NOT NULL,
  averageRating double precision DEFAULT NULL,
  numVotes int DEFAULT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (tconst)
) ;

--  ----------------------------------------------------------------------------------------------------------

CREATE TABLE stg_imdb_name_basics_knownForTitles (
  nconst varchar(10)  NOT NULL,
  knownForTitles varchar(255) NOT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (nconst,knownForTitles)
) ;

CREATE TABLE stg_imdb_name_basics_primaryProfession (
  nconst varchar(10)  NOT NULL,
  primaryProfession varchar(255)  NOT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (nconst,primaryProfession)
) ;

CREATE TABLE stg_imdb_title_basics_genres (
  tconst varchar(10)  NOT NULL,
  genres varchar(255)  NOT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ( tconst ,genres)
) ;


CREATE TABLE stg_imdb_title_crew_directors (
  tconst varchar(10)  NOT NULL,
  directors varchar(255)  NOT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (tconst,directors)
) ;

CREATE TABLE stg_imdb_title_crew_writers (
  tconst varchar(10)  NOT NULL,
  writers varchar(255)  NOT NULL,
  DI_JobID varchar(20)  NOT NULL,
  DI_Create_DT timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (tconst, writers)
) ;






