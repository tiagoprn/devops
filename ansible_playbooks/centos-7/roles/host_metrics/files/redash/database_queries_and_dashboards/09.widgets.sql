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
-- Data for Name: widgets; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.widgets VALUES ('2018-07-06 23:23:33.765831+00', '2018-07-06 23:19:32.712981+00', 5, 7, '', 1, '{"position": {"autoHeight": false, "sizeX": 3, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 3, "row": 5}, "isHidden": false}', 1);
INSERT INTO public.widgets VALUES ('2018-07-06 23:23:33.763173+00', '2018-07-06 23:19:16.432059+00', 4, 10, '', 1, '{"position": {"autoHeight": false, "sizeX": 3, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 0, "row": 5}, "isHidden": false}', 1);
INSERT INTO public.widgets VALUES ('2018-07-06 23:23:33.765969+00', '2018-07-06 23:18:14.981619+00', 2, 4, '', 1, '{"position": {"autoHeight": false, "sizeX": 3, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 0, "row": 0}, "isHidden": false}', 1);
INSERT INTO public.widgets VALUES ('2018-07-06 23:23:33.765918+00', '2018-07-06 23:18:27.562678+00', 3, 2, '', 1, '{"position": {"autoHeight": false, "sizeX": 3, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 3, "row": 0}, "isHidden": false}', 1);
INSERT INTO public.widgets VALUES ('2018-07-06 23:23:33.849436+00', '2018-07-06 23:22:09.319956+00', 6, 17, '', 1, '{"position": {"autoHeight": false, "sizeX": 2, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 2, "row": 10}, "isHidden": false}', 1);
INSERT INTO public.widgets VALUES ('2018-07-06 23:23:33.890481+00', '2018-07-06 23:23:04.677581+00', 8, 19, '', 1, '{"position": {"autoHeight": false, "sizeX": 2, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 4, "row": 10}, "isHidden": false}', 1);
INSERT INTO public.widgets VALUES ('2018-07-06 23:23:33.890386+00', '2018-07-06 23:22:46.157392+00', 7, 14, '', 1, '{"position": {"autoHeight": false, "sizeX": 2, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 0, "row": 10}, "isHidden": false}', 1);
INSERT INTO public.widgets VALUES ('2018-07-06 23:27:43.762167+00', '2018-07-06 23:25:25.559058+00', 11, 24, '', 1, '{"position": {"autoHeight": false, "sizeX": 3, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 3, "row": 0}, "isHidden": false}', 2);
INSERT INTO public.widgets VALUES ('2018-07-06 23:27:43.762235+00', '2018-07-06 23:26:36.279695+00', 14, 28, '', 1, '{"position": {"autoHeight": false, "sizeX": 3, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 3, "row": 5}, "isHidden": false}', 2);
INSERT INTO public.widgets VALUES ('2018-07-06 23:27:43.761991+00', '2018-07-06 23:26:01.962214+00', 13, 26, '', 1, '{"position": {"autoHeight": false, "sizeX": 3, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 0, "row": 5}, "isHidden": false}', 2);
INSERT INTO public.widgets VALUES ('2018-07-06 23:27:43.762096+00', '2018-07-06 23:24:50.210495+00', 9, 22, '', 1, '{"position": {"autoHeight": false, "sizeX": 3, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 0, "row": 0}, "isHidden": false}', 2);
INSERT INTO public.widgets VALUES ('2018-07-06 23:27:43.850365+00', '2018-07-06 23:27:05.974475+00', 15, 32, '', 1, '{"position": {"autoHeight": false, "sizeX": 3, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 0, "row": 10}, "isHidden": false}', 2);
INSERT INTO public.widgets VALUES ('2018-07-06 23:27:43.885671+00', '2018-07-06 23:27:34.400724+00', 16, 30, '', 1, '{"position": {"autoHeight": false, "sizeX": 3, "sizeY": 5, "maxSizeY": 1000, "maxSizeX": 6, "minSizeY": 5, "minSizeX": 1, "col": 3, "row": 10}, "isHidden": false}', 2);


--
-- Name: widgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.widgets_id_seq', 16, true);


--
-- PostgreSQL database dump complete
--

