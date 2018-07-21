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

INSERT INTO public.users VALUES ('2018-07-06 22:04:29.402462+00', '2018-07-06 22:04:29.402462+00', 1, 1, 'admin', 'admin@localhost.localdomain', NULL, '$6$rounds=95890$dcfCj.k3fn4pCv21$RUfFGiu6MgkxCwVerOQq6OcozzKurAG.qYoaQ7P.iuYxTtk5t/amWtkuSk7xUPS.RnfBRvjXHq8QKGsl6eoTR/', '{1,2}', 'lfNfuMHKexaPhh82oTccTVmKpGTVDs2CU1DxO67Z');


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- PostgreSQL database dump complete
--

