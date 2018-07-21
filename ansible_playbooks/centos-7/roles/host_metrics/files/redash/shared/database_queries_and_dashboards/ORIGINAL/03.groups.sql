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
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.groups VALUES (1, 1, 'builtin', 'admin', '{admin,super_admin}', '2018-07-06 22:04:29.309747+00');
INSERT INTO public.groups VALUES (2, 1, 'builtin', 'default', '{create_dashboard,create_query,edit_dashboard,edit_query,view_query,view_source,execute_query,list_users,schedule_query,list_dashboards,list_alerts,list_data_sources}', '2018-07-06 22:04:29.309747+00');


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.groups_id_seq', 2, true);


--
-- PostgreSQL database dump complete
--

