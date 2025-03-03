-- Phan 1 --
CREATE DATABASE MOVIES
ON PRIMARY
(
 NAME = 'Movies_data',
 FILENAME = 'D:\CSDL\MOVIES\Movies_data.mdf',
 SIZE = 25MB,
 MAXSIZE = 40MB,
 FILEGROWTH = 1MB
)
LOG ON
(NAME = 'Movies_log',
 FILENAME = 'D:\CSDL\MOVIES\Movies_log.ldf',
 SIZE = 6MB,
 MAXSIZE = 8MB,
 FILEGROWTH = 1MB
);
GO
-- Phan 2 -- 
ALTER DATABASE MOVIES
ADD FILE
(
 NAME = 'Movies_data2',
 FILENAME = 'D:\CSDL\MOVIES\Movies_data2.ndf',
 SIZE = 10MB,
 MAXSIZE = 20MB,
 FILEGROWTH = 1MB
)
GO

ALTER DATABASE Movies SET SINGLE_USER;
SELECT name, user_access_desc FROM sys.databases WHERE name = 'Movies';
ALTER DATABASE Movies SET RESTRICTED_USER;
SELECT name, user_access_desc FROM sys.databases WHERE name = 'Movies';
ALTER DATABASE Movies SET MULTI_USER;
SELECT name, user_access_desc FROM sys.databases WHERE name = 'Movies';

ALTER DATABASE Movies
MODIFY FILE (
    NAME = 'Movies_data2',
    SIZE = 15 MB
);
ALTER DATABASE Movies SET AUTO_SHRINK ON;

-- XÓA CSDL Movies
DROP DATABASE Movies;
GO



