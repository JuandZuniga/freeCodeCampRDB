--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    user_id integer NOT NULL,
    username character varying(22),
    games_played integer DEFAULT 0,
    best_game integer DEFAULT 0
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_user_id_seq OWNER TO freecodecamp;

--
-- Name: games_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_user_id_seq OWNED BY public.games.user_id;


--
-- Name: games user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN user_id SET DEFAULT nextval('public.games_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (2, 'user_1783606969149', 0, 0);
INSERT INTO public.games VALUES (3, 'user_1783606969148', 0, 0);
INSERT INTO public.games VALUES (5, 'user_1783609031079', 2, 113);
INSERT INTO public.games VALUES (15, 'user_1783610045198', 2, 501);
INSERT INTO public.games VALUES (4, 'user_1783609031080', 5, 121);
INSERT INTO public.games VALUES (1, 'jose', 1, 4);
INSERT INTO public.games VALUES (14, 'user_1783610045199', 5, 13);
INSERT INTO public.games VALUES (7, 'user_1783609408997', 2, 318);
INSERT INTO public.games VALUES (6, 'user_1783609408998', 5, 371);
INSERT INTO public.games VALUES (9, 'user_1783609677985', 2, 126);
INSERT INTO public.games VALUES (8, 'user_1783609677986', 5, 171);
INSERT INTO public.games VALUES (11, 'user_1783609804027', 2, 631);
INSERT INTO public.games VALUES (10, 'user_1783609804028', 5, 252);
INSERT INTO public.games VALUES (13, 'user_1783609892908', 2, 374);
INSERT INTO public.games VALUES (12, 'user_1783609892909', 5, 17);


--
-- Name: games_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_user_id_seq', 15, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (user_id);


--
-- PostgreSQL database dump complete
--

