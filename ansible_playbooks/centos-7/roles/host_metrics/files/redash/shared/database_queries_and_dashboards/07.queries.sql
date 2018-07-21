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
-- Data for Name: queries; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.queries VALUES ('2018-07-08 21:10:31.779436+00', '2018-07-06 23:02:34.739878+00', 9, 1, 1, 1, 24489, 'VMSTAT - Number of System context switches per second', NULL, 'SELECT time, mean(value) AS mean_value FROM vmstat_value WHERE type = ''gauge'' AND type_instance = ''cs'' GROUP BY time(1m) ORDER BY time DESC;', '272b741455f0bf66dda4e4cdccfc1f36', 'lFGskQNNsMIFBrtxqkSms6v6FqD8A4j8cPER4aUj', 1, 1, false, false, '60', 0, '{"parameters": []}', '''1m'':30 ''9'':1B ''and'':23 ''as'':14 ''by'':28,32 ''context'':6A ''cs'':26 ''desc'':34 ''from'':17 ''gauge'':22 ''group'':27 ''instance'':25 ''mean'':12,15 ''number'':3A ''of'':4A ''order'':31 ''per'':8A ''second'':9A ''select'':10 ''switches'':7A ''system'':5A ''time'':11,29,33 ''type'':21,24 ''value'':13,16,19 ''vmstat'':2A,18 ''where'':20');
INSERT INTO public.queries VALUES ('2018-07-08 21:10:32.815677+00', '2018-07-06 22:45:28.273363+00', 6, 1, 1, 1, 24492, 'Load - 5 min', NULL, 'SELECT time, mean(value) AS mean_value FROM load_midterm GROUP BY time(1m) ORDER BY time DESC;', 'd72f468ef998d19b5f21c192488d04c8', 'WSkm0Mhq6IwbxVsEtML74PK1Xl9OeNMdJTlSLxAW', 1, 1, false, false, '60', 0, '{"parameters": []}', '''1m'':18 ''5'':3A ''6'':1B ''as'':9 ''by'':16,20 ''desc'':22 ''from'':12 ''group'':15 ''load'':2A,13 ''mean'':7,10 ''midterm'':14 ''min'':4A ''order'':19 ''select'':5 ''time'':6,17,21 ''value'':8,11');
INSERT INTO public.queries VALUES ('2018-07-08 21:11:31.689329+00', '2018-07-06 23:05:38.263754+00', 10, 1, 1, 1, 24497, 'VMSTAT - % CPU time spent on kernel code', NULL, 'SELECT time, mean(value) AS mean_value FROM vmstat_value WHERE type = ''gauge'' AND type_instance = ''sy'' GROUP BY time(1m) ORDER BY time DESC;', 'de92a9e22a4ced2a9509bf8cd7e201e0', 'ZJRqDx3h66Bia7CjGaJk1bNhkkwbV5ZxFA3UrUeX', 1, 1, false, false, '60', 0, '{"parameters": []}', '''10'':1B ''1m'':29 ''and'':22 ''as'':13 ''by'':27,31 ''code'':8A ''cpu'':3A ''desc'':33 ''from'':16 ''gauge'':21 ''group'':26 ''instance'':24 ''kernel'':7A ''mean'':11,14 ''on'':6A ''order'':30 ''select'':9 ''spent'':5A ''sy'':25 ''time'':4A,10,28,32 ''type'':20,23 ''value'':12,15,18 ''vmstat'':2A,17 ''where'':19');
INSERT INTO public.queries VALUES ('2018-07-08 21:11:31.703391+00', '2018-07-06 22:09:15.115832+00', 1, 1, 1, 1, 24498, 'Free memory', NULL, 'SELECT time, mean(value)/1000000 AS mean_value_in_mb FROM memory_value WHERE type_instance = ''free'' GROUP BY time(20m) ORDER BY time DESC;', '11f836165dc33989063cf1daa5577d0d', 'BiuUcfVg7HBOWV2J1AtmRf636y8JPTVNaE1PyPRE', 1, 1, false, false, '60', 0, '{"parameters": []}', '''/1000000'':8 ''1'':1B ''20m'':24 ''as'':9 ''by'':22,26 ''desc'':28 ''free'':2A,20 ''from'':14 ''group'':21 ''in'':12 ''instance'':19 ''mb'':13 ''mean'':6,10 ''memory'':3A,15 ''order'':25 ''select'':4 ''time'':5,23,27 ''type'':18 ''value'':7,11,16 ''where'':17');
INSERT INTO public.queries VALUES ('2018-07-08 21:11:31.823059+00', '2018-07-06 22:35:59.140635+00', 3, 1, 1, 1, 24500, 'CPU - user', NULL, 'SELECT time, mean(value) AS mean_value FROM cpu_value WHERE type_instance = ''user'' GROUP BY time(20m) ORDER BY time DESC;', '8b97f7bb3cfbeebd9fa434f3c88682d5', '2VnIPab0i7KfsK2mplc4vjSLMqJqEMdFj17Jx6qq', 1, 1, false, false, '60', 0, '{"parameters": []}', '''20m'':21 ''3'':1B ''as'':8 ''by'':19,23 ''cpu'':2A,12 ''desc'':25 ''from'':11 ''group'':18 ''instance'':16 ''mean'':6,9 ''order'':22 ''select'':4 ''time'':5,20,24 ''type'':15 ''user'':3A,17 ''value'':7,10,13 ''where'':14');
INSERT INTO public.queries VALUES ('2018-07-08 21:11:31.822983+00', '2018-07-06 22:54:36.88336+00', 8, 1, 1, 1, 24499, 'VMSTAT - Number of Processes waiting for run time', NULL, 'SELECT time, mean(value) AS mean_value FROM vmstat_value WHERE type = ''gauge'' AND type_instance = ''r'' GROUP BY time(1m) ORDER BY time DESC;', '0d764670342daa9d4b1077a01f9204de', 'WIeBYmjKsCEsaLm9ditGW2FNhtD54zsjuaMuCGRa', 1, 1, false, false, '60', 0, '{"parameters": []}', '''1m'':30 ''8'':1B ''and'':23 ''as'':14 ''by'':28,32 ''desc'':34 ''for'':7A ''from'':17 ''gauge'':22 ''group'':27 ''instance'':25 ''mean'':12,15 ''number'':3A ''of'':4A ''order'':31 ''processes'':5A ''r'':26 ''run'':8A ''select'':10 ''time'':9A,11,29,33 ''type'':21,24 ''value'':13,16,19 ''vmstat'':2A,18 ''waiting'':6A ''where'':20');
INSERT INTO public.queries VALUES ('2018-07-08 21:10:32.50345+00', '2018-07-06 23:07:38.871851+00', 11, 1, 1, 1, 24491, 'VMSTAT - % CPU time spent on user code', NULL, 'SELECT time, mean(value) AS mean_value FROM vmstat_value WHERE type = ''gauge'' AND type_instance = ''us'' GROUP BY time(1m) ORDER BY time DESC;', '90240e8c0da7eea5d49a45be92cd71d8', 'AZGbZZ1tWE8GjlU9xNk0FE1UTpL15OyVfOATvWfA', 1, 1, false, false, '60', 0, '{"parameters": []}', '''11'':1B ''1m'':29 ''and'':22 ''as'':13 ''by'':27,31 ''code'':8A ''cpu'':3A ''desc'':33 ''from'':16 ''gauge'':21 ''group'':26 ''instance'':24 ''mean'':11,14 ''on'':6A ''order'':30 ''select'':9 ''spent'':5A ''time'':4A,10,28,32 ''type'':20,23 ''us'':25 ''user'':7A ''value'':12,15,18 ''vmstat'':2A,17 ''where'':19');
INSERT INTO public.queries VALUES ('2018-07-08 21:11:01.71782+00', '2018-07-06 22:47:11.532833+00', 7, 1, 1, 1, 24493, 'Load - 15 min', NULL, 'SELECT time, mean(value) AS mean_value FROM load_longterm GROUP BY time(1m) ORDER BY time DESC;', 'f5e093637013569deaa2439b943d7a93', 'DeGpGSM3fAEdn7fdAwAgTStaunGwgvDPxIezyTXg', 1, 1, false, false, '60', 0, '{"parameters": []}', '''15'':3A ''1m'':18 ''7'':1B ''as'':9 ''by'':16,20 ''desc'':22 ''from'':12 ''group'':15 ''load'':2A,13 ''longterm'':14 ''mean'':7,10 ''min'':4A ''order'':19 ''select'':5 ''time'':6,17,21 ''value'':8,11');
INSERT INTO public.queries VALUES ('2018-07-08 21:11:01.893131+00', '2018-07-06 22:14:35.412813+00', 2, 1, 1, 1, 24496, 'Used memory', NULL, 'SELECT time, mean(value)/1000000 AS mean_value_in_mb FROM memory_value WHERE type_instance = ''used'' GROUP BY time(20m) ORDER BY time DESC;', '2f17a7ecd73ade0814d73655b28d0615', '5WYaPb2TlqhnABQsbax07KQ93WXgyI7EZYyprdQI', 1, 1, false, false, '60', 0, '{"parameters": []}', '''/1000000'':8 ''2'':1B ''20m'':24 ''as'':9 ''by'':22,26 ''desc'':28 ''from'':14 ''group'':21 ''in'':12 ''instance'':19 ''mb'':13 ''mean'':6,10 ''memory'':3A,15 ''order'':25 ''select'':4 ''time'':5,23,27 ''type'':18 ''used'':2A,20 ''value'':7,11,16 ''where'':17');
INSERT INTO public.queries VALUES ('2018-07-08 21:10:31.713509+00', '2018-07-06 23:09:06.858147+00', 12, 1, 1, 1, 24488, 'VMSTAT - % CPU time spent idle', NULL, 'SELECT time, mean(value) AS mean_value FROM vmstat_value WHERE type = ''gauge'' AND type_instance = ''id'' GROUP BY time(1m) ORDER BY time DESC;', '350d3322e4c39e5207162da40769db3d', 'm4lzaKydYleTC6phmgYqWMgJLyX8A19xIfijJBuO', 1, 1, false, false, '60', 0, '{"parameters": []}', '''12'':1B ''1m'':27 ''and'':20 ''as'':11 ''by'':25,29 ''cpu'':3A ''desc'':31 ''from'':14 ''gauge'':19 ''group'':24 ''id'':23 ''idle'':6A ''instance'':22 ''mean'':9,12 ''order'':28 ''select'':7 ''spent'':5A ''time'':4A,8,26,30 ''type'':18,21 ''value'':10,13,16 ''vmstat'':2A,15 ''where'':17');
INSERT INTO public.queries VALUES ('2018-07-08 21:11:01.754149+00', '2018-07-06 22:42:18.588062+00', 5, 1, 1, 1, 24494, 'Load - 1 min', NULL, 'SELECT time, mean(value) AS mean_value FROM load_shortterm GROUP BY time(1m) ORDER BY time DESC;', '6f8d5dccf49f0bfaa822e8672293d67b', '96ZukDt28MP6TzyREtquQpWSRTqROYn8Aljmhkq8', 1, 1, false, false, '60', 0, '{"parameters": []}', '''1'':3A ''1m'':18 ''5'':1B ''as'':9 ''by'':16,20 ''desc'':22 ''from'':12 ''group'':15 ''load'':2A,13 ''mean'':7,10 ''min'':4A ''order'':19 ''select'':5 ''shortterm'':14 ''time'':6,17,21 ''value'':8,11');
INSERT INTO public.queries VALUES ('2018-07-08 21:11:01.841527+00', '2018-07-06 22:39:33.480086+00', 4, 1, 1, 1, 24495, 'CPU - system', NULL, 'SELECT time, mean(value) AS mean_value FROM cpu_value WHERE type_instance = ''system'' GROUP BY time(20m) ORDER BY time DESC;', '2367baa4d68390927aa6583ad22e9748', 'GIk4thbAAXQo6gG4YGx1yagNfr4awP5gx3Q87DyM', 1, 1, false, false, '60', 0, '{"parameters": []}', '''20m'':21 ''4'':1B ''as'':8 ''by'':19,23 ''cpu'':2A,12 ''desc'':25 ''from'':11 ''group'':18 ''instance'':16 ''mean'':6,9 ''order'':22 ''select'':4 ''system'':3A,17 ''time'':5,20,24 ''type'':15 ''value'':7,10,13 ''where'':14');
INSERT INTO public.queries VALUES ('2018-07-08 21:10:32.1628+00', '2018-07-06 23:10:34.222101+00', 13, 1, 1, 1, 24490, 'VMSTAT - % CPU time spent waiting for I/O', NULL, 'SELECT time, mean(value) AS mean_value FROM vmstat_value WHERE type = ''gauge'' AND type_instance = ''wa'' GROUP BY time(1m) ORDER BY time DESC;', 'aba49774cf532911312a87545391933f', 'yejEQaDujkMLycxRfIHPYUMPGzohcn4MBW4uiLsb', 1, 1, false, false, '60', 0, '{"parameters": []}', '''13'':1B ''1m'':29 ''and'':22 ''as'':13 ''by'':27,31 ''cpu'':3A ''desc'':33 ''for'':7A ''from'':16 ''gauge'':21 ''group'':26 ''i/o'':8A ''instance'':24 ''mean'':11,14 ''order'':30 ''select'':9 ''spent'':5A ''time'':4A,10,28,32 ''type'':20,23 ''value'':12,15,18 ''vmstat'':2A,17 ''wa'':25 ''waiting'':6A ''where'':19');


--
-- Name: queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.queries_id_seq', 13, true);


--
-- PostgreSQL database dump complete
--

