--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- Data for Name: places; Type: TABLE DATA; Schema: public; Owner: noti
--

COPY places (id, name, coords) FROM stdin;
5a3f30dc-8315-4540-ae12-7f8484f1c58a	Pizzeria Finlandia	(64.6837500000000034,24.4766399999999997)
\.


--
-- Data for Name: deals; Type: TABLE DATA; Schema: public; Owner: noti
--

COPY deals (id, title, place_id) FROM stdin;
6b30b047-3c6f-47de-97fd-83c67277d0d1	Cheap Margerita	5a3f30dc-8315-4540-ae12-7f8484f1c58a
d3ed1523-7e17-4b0a-9702-d7039cd53e3e	2 for 1 any pizza	5a3f30dc-8315-4540-ae12-7f8484f1c58a
\.


--
-- PostgreSQL database dump complete
--

