-- author : cbarange
-- date : 22th december 2020
-- file : dml_posthoop_post.sql
-- base : posthoop_post
-- role : insert data

\c posthoop_post
SET ROLE posthoop;

INSERT INTO posthoop_post."post"(text, uid_user) VALUES('Hey, ça va ?','c92bd41d-233f-4f51-a21b-5d53b7da984a');

INSERT INTO posthoop_post."post"(text, uid_user)  VALUES('Bonjour à tous','76da6529-78d3-4984-bbac-b6d8adbe1365');

INSERT INTO posthoop_post."comment"(text, uid_user, uid_post) 
SELECT 'Oui ca va !' AS text,'76da6529-78d3-4984-bbac-b6d8adbe1365' AS uid_user, P.uid as uid_post
	FROM posthoop_post.post AS P
  WHERE P.uid_user='c92bd41d-233f-4f51-a21b-5d53b7da984a';

INSERT INTO posthoop_post."comment"(text, uid_user, uid_post) 
SELECT 'Salut a toi' AS text, 'c92bd41d-233f-4f51-a21b-5d53b7da984a' AS uid_user, P.uid as uid_post
  FROM posthoop_post.post AS P
  WHERE P.uid_user='76da6529-78d3-4984-bbac-b6d8adbe1365';

INSERT INTO posthoop_post."comment"(text, uid_user, uid_post) 
SELECT 'Trop bien' AS text,'76da6529-78d3-4984-bbac-b6d8adbe1365' AS uid_user, P.uid as uid_post
  FROM posthoop_post.post AS P
  WHERE P.uid_user='76da6529-78d3-4984-bbac-b6d8adbe1365';
