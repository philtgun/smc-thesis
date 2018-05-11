--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3 (Ubuntu 10.3-1.pgdg14.04+1)
-- Dumped by pg_dump version 10.3 (Ubuntu 10.3-1.pgdg14.04+1)

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
-- Data for Name: model; Type: TABLE DATA; Schema: public; Owner: acousticbrainz
--

COPY public.model (id, model, model_version, date, status) FROM stdin;
1	danceability	v2.1_beta1	2016-02-26 09:33:10.672311+01	show
2	gender	v2.1_beta1	2016-02-26 09:33:16.072684+01	show
3	genre_dortmund	v2.1_beta1	2016-02-26 09:33:20.367558+01	show
4	genre_electronic	v2.1_beta1	2016-02-26 09:33:25.752386+01	show
5	genre_rosamerica	v2.1_beta1	2016-02-26 09:33:30.927693+01	show
6	genre_tzanetakis	v2.1_beta1	2016-02-26 09:33:35.696131+01	show
7	ismir04_rhythm	v2.1_beta1	2016-02-26 09:33:40.120165+01	show
8	mood_acoustic	v2.1_beta1	2016-02-26 09:33:44.680366+01	show
9	mood_aggressive	v2.1_beta1	2016-02-26 09:34:16.584348+01	show
10	mood_electronic	v2.1_beta1	2016-02-26 09:34:21.856233+01	show
11	mood_happy	v2.1_beta1	2016-02-26 09:34:26.24796+01	show
12	mood_party	v2.1_beta1	2016-02-26 09:34:36.368223+01	show
13	mood_relaxed	v2.1_beta1	2016-02-26 09:34:41.967661+01	show
14	mood_sad	v2.1_beta1	2016-02-26 09:34:45.824758+01	show
15	moods_mirex	v2.1_beta1	2016-02-26 09:34:51.328161+01	show
16	timbre	v2.1_beta1	2016-02-26 09:34:57.464293+01	show
17	tonal_atonal	v2.1_beta1	2016-02-26 09:35:03.039442+01	show
18	voice_instrumental	v2.1_beta1	2016-02-26 09:35:10.320498+01	show
\.


--
-- Name: model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acousticbrainz
--

SELECT pg_catalog.setval('public.model_id_seq', 18, true);


--
-- PostgreSQL database dump complete
--

