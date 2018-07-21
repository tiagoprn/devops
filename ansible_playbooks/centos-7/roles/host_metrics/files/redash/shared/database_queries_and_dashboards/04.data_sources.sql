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
-- Data for Name: data_sources; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.data_sources VALUES (1, 1, 'local influxdb', 'influxdb', '{"url": "influxdb://admin:0jbAqlyXLb9dGUtowL@10.0.5.58:8086/collectd"}', 'queries', 'scheduled_queries', '2018-07-06 22:06:06.350317+00');


--
-- Name: data_sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.data_sources_id_seq', 1, true);


--
-- PostgreSQL database dump complete
--

