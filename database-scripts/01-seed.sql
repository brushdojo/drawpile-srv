/* set the default server configuration options */
INSERT INTO settings VALUES 
  ('clientTimeout', 180),
  ('sessionSizeLimit', 0),
  ('sessionCountLimit', 10),
  ('persistence', true),
  ('allowGuestHosts', false),
  ('idleTimeLimit', 7200),
  ('serverTitle', 'Brush Dojo | A friendly art community for new and experienced artists'),
  ('welcomeMessage', 'Welcome to Brush Dojo! Have fun drawing!'),
  ('announceWhitelist', true),
  ('privateUserList', true),
  ('allowGuests', true),
  ('archive', true),
  ('extauth', false),
  ('logpurgedays', 14),
  ('autoResetThreshold', '30mb'),
  ('customAvatars', true);

/* set the announcement server whitelist */
INSERT INTO listingservers VALUES 
  ('https://drawpile.net/api/listing/');
