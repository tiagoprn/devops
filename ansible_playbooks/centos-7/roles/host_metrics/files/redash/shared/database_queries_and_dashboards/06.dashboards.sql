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
-- Data for Name: dashboards; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.dashboards VALUES ('2018-07-06 23:23:41.288589+00', '2018-07-06 23:16:22.711208+00', 1, 3, 1, 'general-system-view', 'General System View', 1, '[]', true, false, false);
INSERT INTO public.dashboards VALUES ('2018-07-06 23:28:23.273231+00', '2018-07-06 23:24:26.643173+00', 2, 2, 1, 'vmstat-system-view', 'VMSTAT System View', 1, '[]', false, false, false);
INSERT INTO public.dashboards VALUES ('2018-07-22 16:26:01.421481+00', '2018-07-22 16:22:49.898886+00', 3, 2, 1, 'network', 'Network', 1, '[]', false, false, false);
INSERT INTO public.dashboards VALUES ('2018-07-22 17:52:33.852882+00', '2018-07-22 17:29:12.556764+00', 4, 2, 1, 'tcp-connections', 'TCP Connections', 1, '[]', false, false, false);
INSERT INTO public.dashboards VALUES ('2018-07-22 22:39:49.797256+00', '2018-07-22 21:33:18.778172+00', 5, 3, 1, 'processes', 'Critical Processes metrics', 1, '[]', false, false, false);
INSERT INTO public.dashboards VALUES ('2018-07-24 11:16:45.456615+00', '2018-07-24 11:09:10.629416+00', 6, 2, 1, 'disks', 'Disks', 1, '[]', false, false, false);


--
-- Name: dashboards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dashboards_id_seq', 6, true);


--
-- PostgreSQL database dump complete
--

