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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: deals; Type: TABLE; Schema: public; Owner: noti
--

CREATE TABLE deals (
    id uuid NOT NULL,
    title text NOT NULL,
    place_id uuid
);


ALTER TABLE deals OWNER TO noti;

--
-- Name: places; Type: TABLE; Schema: public; Owner: noti
--

CREATE TABLE places (
    id uuid NOT NULL,
    name text NOT NULL,
    coords point NOT NULL
);


ALTER TABLE places OWNER TO noti;

--
-- Name: deals deals_pkey; Type: CONSTRAINT; Schema: public; Owner: noti
--

ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (id);


--
-- Name: places place_pkey; Type: CONSTRAINT; Schema: public; Owner: noti
--

ALTER TABLE ONLY places
    ADD CONSTRAINT place_pkey PRIMARY KEY (id);


--
-- Name: deals deals_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: noti
--

ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_place_id_fkey FOREIGN KEY (place_id) REFERENCES places(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

