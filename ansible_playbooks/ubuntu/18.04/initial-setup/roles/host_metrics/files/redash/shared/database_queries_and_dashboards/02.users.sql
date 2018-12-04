--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Debian 10.4-2.pgdg90+1)
-- Dumped by pg_dump version 10.4 (Debian 10.4-2.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES ('2018-07-21 15:11:07.750924+00', '2018-07-21 15:11:07.750924+00', 1, 1, 'devops', 'devops@localhost.localdomain', NULL, '$6$rounds=108335$wz0O2aYhqh0APfc0$hOVVLnhJ9QRvj1kJ6Y/ujw5S5DIXOStCWC7d5vRpCg7FIgq7amxHTPftjNwFr7G6LOUulV8Fj0qvIs.tV//N1.', '{1,2}', 'MtHSb14emobBdlrHZPaZF1D3puIIE80LXy2pperd');


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- PostgreSQL database dump complete
--

