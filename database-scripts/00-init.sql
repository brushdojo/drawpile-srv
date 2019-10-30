/*
  Adapted from Drawpile's official database initialization scripts:
  https://github.com/drawpile/Drawpile/blob/master/src/thinsrv/database.cpp#L45
  https://github.com/drawpile/Drawpile/blob/master/src/thinsrv/dblog.cpp#L33

  We create the database manually here in order to seed it with configuration 
  data later on.
*/

CREATE TABLE IF NOT EXISTS settings (
  key PRIMARY KEY,
  value
);

CREATE TABLE IF NOT EXISTS listingservers (
  url
);

CREATE TABLE IF NOT EXISTS ipbans (
  ip,
  subnet,
  expires,
  comment,
  added
);

CREATE TABLE IF NOT EXISTS users (
  username UNIQUE,
  password,
  locked,
  flags
);

CREATE TABLE IF NOT EXISTS serverlog (
  timestamp,
  level,
  topic,
  user,
  session,
  message
);
