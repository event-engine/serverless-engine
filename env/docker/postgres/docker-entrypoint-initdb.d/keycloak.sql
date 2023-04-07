--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3 (Debian 14.3-1.pgdg110+1)
-- Dumped by pg_dump version 14.3 (Debian 14.3-1.pgdg110+1)

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

--
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: dev
--

CREATE DATABASE keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE keycloak OWNER TO dev;

\connect keycloak

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO dev;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO dev;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO dev;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO dev;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO dev;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO dev;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO dev;

--
-- Name: client; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO dev;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO dev;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO dev;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO dev;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO dev;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO dev;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO dev;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO dev;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO dev;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO dev;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO dev;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO dev;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO dev;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO dev;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO dev;

--
-- Name: component; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO dev;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO dev;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO dev;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO dev;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO dev;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO dev;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO dev;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO dev;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO dev;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO dev;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO dev;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO dev;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO dev;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO dev;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO dev;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO dev;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO dev;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO dev;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO dev;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO dev;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO dev;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO dev;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO dev;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO dev;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO dev;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO dev;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO dev;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO dev;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO dev;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO dev;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO dev;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO dev;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO dev;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO dev;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO dev;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO dev;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO dev;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO dev;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO dev;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO dev;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO dev;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO dev;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO dev;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO dev;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO dev;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO dev;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO dev;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO dev;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO dev;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO dev;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO dev;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO dev;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO dev;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO dev;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO dev;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO dev;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO dev;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO dev;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO dev;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO dev;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO dev;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO dev;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO dev;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO dev;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO dev;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO dev;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO dev;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO dev;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO dev;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO dev;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
e320428a-7aae-45d8-b52c-ac759ac4449c	\N	auth-cookie	master	cf8d37d8-831d-410a-84b6-129edc896b82	2	10	f	\N	\N
4c9832de-6bef-4f7a-bb7c-bdfcaccfbc4b	\N	auth-spnego	master	cf8d37d8-831d-410a-84b6-129edc896b82	3	20	f	\N	\N
ceeddf70-64d5-4885-a233-dfef169fb54f	\N	identity-provider-redirector	master	cf8d37d8-831d-410a-84b6-129edc896b82	2	25	f	\N	\N
0cd0ec61-ce19-434d-a4f6-0dcaa54e811e	\N	\N	master	cf8d37d8-831d-410a-84b6-129edc896b82	2	30	t	fe0bd33a-c103-4b93-b511-36cfc636a1cf	\N
b4fdf279-3fa2-4b31-8483-6e842391a1ea	\N	auth-username-password-form	master	fe0bd33a-c103-4b93-b511-36cfc636a1cf	0	10	f	\N	\N
5648b99f-b14f-43f2-bd23-28727f358e8a	\N	\N	master	fe0bd33a-c103-4b93-b511-36cfc636a1cf	1	20	t	79787da6-d507-499a-89d9-e5e7f3ec1e37	\N
dcc1b60b-34e7-4479-91dd-b9ac4e1f2ead	\N	conditional-user-configured	master	79787da6-d507-499a-89d9-e5e7f3ec1e37	0	10	f	\N	\N
e5edaee9-9be3-469c-824b-8525968abc28	\N	auth-otp-form	master	79787da6-d507-499a-89d9-e5e7f3ec1e37	0	20	f	\N	\N
6a3eaf1d-d93a-419a-bda9-76fa9fac7170	\N	direct-grant-validate-username	master	3d2452e1-8fad-4c2b-b723-366664edd859	0	10	f	\N	\N
544c188d-f450-4a73-8761-0ec0ef3a212b	\N	direct-grant-validate-password	master	3d2452e1-8fad-4c2b-b723-366664edd859	0	20	f	\N	\N
1cd242ec-254c-4af4-a6da-18ab7e8f0e31	\N	\N	master	3d2452e1-8fad-4c2b-b723-366664edd859	1	30	t	64cfc2a9-8d9e-4c15-804a-4b6d5b45b899	\N
e09e1037-803c-4e4a-b8f7-2fce3560720c	\N	conditional-user-configured	master	64cfc2a9-8d9e-4c15-804a-4b6d5b45b899	0	10	f	\N	\N
4291cdda-2a1c-42c4-a573-e8f8c962fdc7	\N	direct-grant-validate-otp	master	64cfc2a9-8d9e-4c15-804a-4b6d5b45b899	0	20	f	\N	\N
ae5eb78c-de34-4c03-9312-dbf81b1fec23	\N	registration-page-form	master	7757aff1-143f-483b-a2fc-ae5bc992a58c	0	10	t	0d788cd7-2de9-4760-bbc0-eeecaa314ce3	\N
45536b3e-a771-4c1c-b552-be6f2e9a40aa	\N	registration-user-creation	master	0d788cd7-2de9-4760-bbc0-eeecaa314ce3	0	20	f	\N	\N
5ed46883-443d-4b54-adef-1e01649440f6	\N	registration-profile-action	master	0d788cd7-2de9-4760-bbc0-eeecaa314ce3	0	40	f	\N	\N
27c7ec39-c8b0-45c2-8576-89b4d3915d00	\N	registration-password-action	master	0d788cd7-2de9-4760-bbc0-eeecaa314ce3	0	50	f	\N	\N
b5259dbd-2ec6-4182-9a4c-d76706077b90	\N	registration-recaptcha-action	master	0d788cd7-2de9-4760-bbc0-eeecaa314ce3	3	60	f	\N	\N
d98120c5-aed3-42fc-87cb-c301257acf97	\N	reset-credentials-choose-user	master	198bc148-ff66-4d0a-9ac3-b8af1209b44e	0	10	f	\N	\N
90a311fe-98a1-4236-9d44-c7ee07383a94	\N	reset-credential-email	master	198bc148-ff66-4d0a-9ac3-b8af1209b44e	0	20	f	\N	\N
16e067fc-cc23-46e4-ba8a-17a0201af5d8	\N	reset-password	master	198bc148-ff66-4d0a-9ac3-b8af1209b44e	0	30	f	\N	\N
eb18e65b-5e8c-43a5-9628-0fdaf3efa0d9	\N	\N	master	198bc148-ff66-4d0a-9ac3-b8af1209b44e	1	40	t	9f6ab19e-53e5-44ec-a145-d4092328e042	\N
dd47e3cc-2cdf-4132-8918-946b428526e2	\N	conditional-user-configured	master	9f6ab19e-53e5-44ec-a145-d4092328e042	0	10	f	\N	\N
e110bf2d-1baa-49fb-bd45-3ee8e586a313	\N	reset-otp	master	9f6ab19e-53e5-44ec-a145-d4092328e042	0	20	f	\N	\N
cc8c3259-8864-4cdc-9789-67d7a3aca36a	\N	client-secret	master	45703785-4db8-4d88-9c36-8f882d25210c	2	10	f	\N	\N
2555c7e0-b95f-4438-899c-e3ec8683b5dd	\N	client-jwt	master	45703785-4db8-4d88-9c36-8f882d25210c	2	20	f	\N	\N
e3372ec2-f733-4c28-8ef7-1d12b63ed6c3	\N	client-secret-jwt	master	45703785-4db8-4d88-9c36-8f882d25210c	2	30	f	\N	\N
32e52b91-c21a-44b7-86eb-10658d344cd2	\N	client-x509	master	45703785-4db8-4d88-9c36-8f882d25210c	2	40	f	\N	\N
0cf3b55f-bc4a-4c54-9932-bd3d837cf11b	\N	idp-review-profile	master	b478b226-2edc-4653-8d16-655d4f54b4a1	0	10	f	\N	d86be076-169b-41f2-9e82-7facc5b7b1ef
3dac0db9-fee6-4363-9698-0f0a61e29c28	\N	\N	master	b478b226-2edc-4653-8d16-655d4f54b4a1	0	20	t	2e86b2d9-4833-4842-b289-32f28306b538	\N
fe330a42-ef90-4339-9b31-d9230a10414c	\N	idp-create-user-if-unique	master	2e86b2d9-4833-4842-b289-32f28306b538	2	10	f	\N	0e4311bc-e5b7-4bbe-b9df-5d05f4a1f7d9
c3c42b1a-6a05-46cc-a027-f8f0937b0255	\N	\N	master	2e86b2d9-4833-4842-b289-32f28306b538	2	20	t	153b08ff-a8d5-4f8f-92de-80bd7c9edfac	\N
7450937e-6fcf-457e-9018-83d2de64a2c2	\N	idp-confirm-link	master	153b08ff-a8d5-4f8f-92de-80bd7c9edfac	0	10	f	\N	\N
cef90ef1-2548-4b2e-8265-39dbb778d06e	\N	\N	master	153b08ff-a8d5-4f8f-92de-80bd7c9edfac	0	20	t	2aab8e2b-4362-4540-aab8-3cb8fa1d9dd6	\N
10f2ca61-e54e-4cb1-8d6c-d1fbebb5a85c	\N	idp-email-verification	master	2aab8e2b-4362-4540-aab8-3cb8fa1d9dd6	2	10	f	\N	\N
1c2d16ac-9aa0-4f2d-a462-f4b50825940c	\N	\N	master	2aab8e2b-4362-4540-aab8-3cb8fa1d9dd6	2	20	t	2862c3de-1211-45f8-92c1-b379f2649f2a	\N
159f58e7-404f-4bbd-8c03-3a14633dec2e	\N	idp-username-password-form	master	2862c3de-1211-45f8-92c1-b379f2649f2a	0	10	f	\N	\N
700260a3-783f-4bd5-87b4-073a49339136	\N	\N	master	2862c3de-1211-45f8-92c1-b379f2649f2a	1	20	t	6a207a85-eddb-47c3-9450-8d0b5b1b49c4	\N
d8224cf8-20fb-4e99-85c3-9c183e2dae2d	\N	conditional-user-configured	master	6a207a85-eddb-47c3-9450-8d0b5b1b49c4	0	10	f	\N	\N
11d9952e-aace-4eb2-baea-393c91ff2760	\N	auth-otp-form	master	6a207a85-eddb-47c3-9450-8d0b5b1b49c4	0	20	f	\N	\N
9deecd89-5d3b-43a0-8277-f65ecf0a2612	\N	http-basic-authenticator	master	da2d9687-fcfd-40ab-b878-8f35b428e85f	0	10	f	\N	\N
446e9322-2252-4c97-8fbe-9d4f25fb1fcc	\N	docker-http-basic-authenticator	master	469549d3-8036-4049-a59b-4ea91231b0c7	0	10	f	\N	\N
ad4673b0-ee1f-4922-a590-6cac354a9765	\N	no-cookie-redirect	master	6c512f14-4e98-4b9f-8bdb-d1e0fdfb68df	0	10	f	\N	\N
024fa5dd-c854-4eb0-a99e-db1c3b033c64	\N	\N	master	6c512f14-4e98-4b9f-8bdb-d1e0fdfb68df	0	20	t	63b685e0-239f-458d-9af5-dbcfaf664bce	\N
50b78c37-986e-4064-99d9-6225611e0130	\N	basic-auth	master	63b685e0-239f-458d-9af5-dbcfaf664bce	0	10	f	\N	\N
1e20ffe6-b159-44ea-b2a9-a78df1d35ee7	\N	basic-auth-otp	master	63b685e0-239f-458d-9af5-dbcfaf664bce	3	20	f	\N	\N
35779511-828f-4fd5-b4c7-2085e060549f	\N	auth-spnego	master	63b685e0-239f-458d-9af5-dbcfaf664bce	3	30	f	\N	\N
ae0e0ff1-7868-46f6-b790-d804633dd7d9	\N	auth-cookie	App	8c063474-f70a-4bc1-82df-064d15376e8c	2	10	f	\N	\N
045fa344-25ff-4b9a-8498-96ac2d81c0bb	\N	auth-spnego	App	8c063474-f70a-4bc1-82df-064d15376e8c	3	20	f	\N	\N
7892a450-ff07-43f9-8e4d-2e0d76688c02	\N	identity-provider-redirector	App	8c063474-f70a-4bc1-82df-064d15376e8c	2	25	f	\N	\N
b4383cad-715b-4058-b909-8e949035a090	\N	\N	App	8c063474-f70a-4bc1-82df-064d15376e8c	2	30	t	9fd29de3-44e0-434f-b7bb-0d098f9a75f6	\N
112e90be-f834-44cd-a346-cbfbfc300e4e	\N	auth-username-password-form	App	9fd29de3-44e0-434f-b7bb-0d098f9a75f6	0	10	f	\N	\N
ec764944-2c8c-4e4f-ba70-8a6ceac27304	\N	\N	App	9fd29de3-44e0-434f-b7bb-0d098f9a75f6	1	20	t	49aeed77-a595-4f86-855d-6e5827add648	\N
55507129-878e-4e45-a864-aa6435c8ceaa	\N	conditional-user-configured	App	49aeed77-a595-4f86-855d-6e5827add648	0	10	f	\N	\N
fa5a9e6a-18e8-470b-96d0-b14029e40204	\N	auth-otp-form	App	49aeed77-a595-4f86-855d-6e5827add648	0	20	f	\N	\N
98f800b9-02a8-4445-b1e3-c82f2d0ff9fb	\N	direct-grant-validate-username	App	840c623a-b243-49e2-8068-e4147fc56a14	0	10	f	\N	\N
77207f7c-5346-4e6e-a399-178eedfbabeb	\N	direct-grant-validate-password	App	840c623a-b243-49e2-8068-e4147fc56a14	0	20	f	\N	\N
60da560f-33ee-42c6-b642-2406e8d9b712	\N	\N	App	840c623a-b243-49e2-8068-e4147fc56a14	1	30	t	372f02a6-ce34-4ec1-8530-70b958f4fecb	\N
4e2c1c7c-8c2f-48ef-bd1c-13284a911edd	\N	conditional-user-configured	App	372f02a6-ce34-4ec1-8530-70b958f4fecb	0	10	f	\N	\N
2b915b61-8574-4833-ba3f-27ae36e3c002	\N	direct-grant-validate-otp	App	372f02a6-ce34-4ec1-8530-70b958f4fecb	0	20	f	\N	\N
c3958715-2067-432c-af71-0520f2c388e2	\N	registration-page-form	App	9cca84ba-be69-48ba-80c0-87353744f540	0	10	t	74ce11d1-3f5c-4ab7-9dd8-4a8481443787	\N
b079733b-00d7-4a75-917a-cb7212a9f7a0	\N	registration-user-creation	App	74ce11d1-3f5c-4ab7-9dd8-4a8481443787	0	20	f	\N	\N
1597163f-3faa-4461-a77a-958a14db3673	\N	registration-profile-action	App	74ce11d1-3f5c-4ab7-9dd8-4a8481443787	0	40	f	\N	\N
352e7c45-8073-45b4-9374-f733a25508ef	\N	registration-password-action	App	74ce11d1-3f5c-4ab7-9dd8-4a8481443787	0	50	f	\N	\N
47539cf4-e720-4f1b-86e0-106561d40cb7	\N	registration-recaptcha-action	App	74ce11d1-3f5c-4ab7-9dd8-4a8481443787	3	60	f	\N	\N
5da279f5-4696-4b17-936e-1cc3c636e46b	\N	reset-credentials-choose-user	App	0bad4002-d028-442f-85ca-28a21521807d	0	10	f	\N	\N
d293b010-de08-4118-8336-1bbf0ca3e9f2	\N	reset-credential-email	App	0bad4002-d028-442f-85ca-28a21521807d	0	20	f	\N	\N
b07b5eac-5ace-4ab8-a212-5917355497dd	\N	reset-password	App	0bad4002-d028-442f-85ca-28a21521807d	0	30	f	\N	\N
ad167411-6580-4d37-a828-ac8f246b4e2e	\N	\N	App	0bad4002-d028-442f-85ca-28a21521807d	1	40	t	f2bddf32-aa27-4c9c-9c61-876c9a12c781	\N
5229e913-992b-4c08-9bcc-1adf132215a9	\N	conditional-user-configured	App	f2bddf32-aa27-4c9c-9c61-876c9a12c781	0	10	f	\N	\N
3520aaee-eec8-470f-95fa-c5512598ec03	\N	reset-otp	App	f2bddf32-aa27-4c9c-9c61-876c9a12c781	0	20	f	\N	\N
7418d107-b5f6-4bab-b75f-444aa6b44529	\N	client-secret	App	80b98a00-d4f6-4465-91e0-c2cf2450f0ce	2	10	f	\N	\N
ff7b7bbe-d59e-44fc-90d5-dea5f84ad4be	\N	client-jwt	App	80b98a00-d4f6-4465-91e0-c2cf2450f0ce	2	20	f	\N	\N
5ccfacd3-d5ee-4b56-b180-123992136966	\N	client-secret-jwt	App	80b98a00-d4f6-4465-91e0-c2cf2450f0ce	2	30	f	\N	\N
4db7a0da-62a9-4c92-84f6-0b1ff9b0bd89	\N	client-x509	App	80b98a00-d4f6-4465-91e0-c2cf2450f0ce	2	40	f	\N	\N
e57d4c9c-7e6f-40bc-9453-562bbd461290	\N	idp-review-profile	App	02534362-bd81-438f-974b-67bd98dd96bb	0	10	f	\N	7bc54682-147c-4b98-8ad6-e614ec1c1d56
b5b6b47c-f0f4-4634-a42c-38d16b48512a	\N	\N	App	02534362-bd81-438f-974b-67bd98dd96bb	0	20	t	4e26b643-44f8-4e10-bfa7-d849e57f88be	\N
5b14a4b9-0f8c-4757-af8b-44e034dbdf7f	\N	idp-create-user-if-unique	App	4e26b643-44f8-4e10-bfa7-d849e57f88be	2	10	f	\N	b2c1bd0d-aa31-45dc-8e7e-1cd4a14bfd75
ad5fd739-8af1-40b5-a21f-f8c80d211557	\N	\N	App	4e26b643-44f8-4e10-bfa7-d849e57f88be	2	20	t	c08d6f68-d11c-4d0e-840d-c1d1c17c352d	\N
1b47b264-3509-488e-b778-4c07581befb1	\N	idp-confirm-link	App	c08d6f68-d11c-4d0e-840d-c1d1c17c352d	0	10	f	\N	\N
97ff5711-87ef-4336-b7e0-b3a836ef3ef4	\N	\N	App	c08d6f68-d11c-4d0e-840d-c1d1c17c352d	0	20	t	733cb8d4-d744-44f5-8cd2-3598950f95c7	\N
dccbe473-72b6-45f2-ba20-cdbf4e4f6d2e	\N	idp-email-verification	App	733cb8d4-d744-44f5-8cd2-3598950f95c7	2	10	f	\N	\N
24f650d6-7814-42a7-9c44-7f183c67bf80	\N	\N	App	733cb8d4-d744-44f5-8cd2-3598950f95c7	2	20	t	6e5d8d14-457b-447f-b83f-4f27ad31558a	\N
7966eac1-29da-4aa3-a900-6e20bc8f1357	\N	idp-username-password-form	App	6e5d8d14-457b-447f-b83f-4f27ad31558a	0	10	f	\N	\N
72ac2b26-3de8-4afb-834c-73d4f76c8353	\N	\N	App	6e5d8d14-457b-447f-b83f-4f27ad31558a	1	20	t	50273372-4e94-4674-bc82-e8c7d3866de7	\N
7e33a614-bcb7-4068-8096-6d8ca3fc8303	\N	conditional-user-configured	App	50273372-4e94-4674-bc82-e8c7d3866de7	0	10	f	\N	\N
c4a6e175-e461-467b-8b14-ef7d1154d14e	\N	auth-otp-form	App	50273372-4e94-4674-bc82-e8c7d3866de7	0	20	f	\N	\N
4fac766b-6b75-4d6e-b301-b516e96ba23a	\N	http-basic-authenticator	App	c6e71d62-b567-4a12-a89f-42f5d24c5dd7	0	10	f	\N	\N
d793bb8a-6f79-4bc8-86ef-940c08279365	\N	docker-http-basic-authenticator	App	d0eb7ac1-0819-4ba9-acb0-6fcfb603ee83	0	10	f	\N	\N
f1b91032-78d6-4cd5-ac25-73e41ad75899	\N	no-cookie-redirect	App	830bd44f-6ca6-4bf8-8ca7-dfe31a4c0d44	0	10	f	\N	\N
43ca99dd-54a8-4ca5-bf29-87a332803bb1	\N	\N	App	830bd44f-6ca6-4bf8-8ca7-dfe31a4c0d44	0	20	t	3122fe17-b90c-4231-928f-e62324f6c607	\N
18fd0761-8312-44c2-9784-199e0137f190	\N	basic-auth	App	3122fe17-b90c-4231-928f-e62324f6c607	0	10	f	\N	\N
dce89072-a5dd-417b-9083-ded5058dac17	\N	basic-auth-otp	App	3122fe17-b90c-4231-928f-e62324f6c607	3	20	f	\N	\N
86311580-9c82-4b17-9662-eefb24e0c5d8	\N	auth-spnego	App	3122fe17-b90c-4231-928f-e62324f6c607	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
cf8d37d8-831d-410a-84b6-129edc896b82	browser	browser based authentication	master	basic-flow	t	t
fe0bd33a-c103-4b93-b511-36cfc636a1cf	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
79787da6-d507-499a-89d9-e5e7f3ec1e37	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
3d2452e1-8fad-4c2b-b723-366664edd859	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
64cfc2a9-8d9e-4c15-804a-4b6d5b45b899	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
7757aff1-143f-483b-a2fc-ae5bc992a58c	registration	registration flow	master	basic-flow	t	t
0d788cd7-2de9-4760-bbc0-eeecaa314ce3	registration form	registration form	master	form-flow	f	t
198bc148-ff66-4d0a-9ac3-b8af1209b44e	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
9f6ab19e-53e5-44ec-a145-d4092328e042	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
45703785-4db8-4d88-9c36-8f882d25210c	clients	Base authentication for clients	master	client-flow	t	t
b478b226-2edc-4653-8d16-655d4f54b4a1	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
2e86b2d9-4833-4842-b289-32f28306b538	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
153b08ff-a8d5-4f8f-92de-80bd7c9edfac	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
2aab8e2b-4362-4540-aab8-3cb8fa1d9dd6	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
2862c3de-1211-45f8-92c1-b379f2649f2a	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
6a207a85-eddb-47c3-9450-8d0b5b1b49c4	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
da2d9687-fcfd-40ab-b878-8f35b428e85f	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
469549d3-8036-4049-a59b-4ea91231b0c7	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
6c512f14-4e98-4b9f-8bdb-d1e0fdfb68df	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
63b685e0-239f-458d-9af5-dbcfaf664bce	Authentication Options	Authentication options.	master	basic-flow	f	t
8c063474-f70a-4bc1-82df-064d15376e8c	browser	browser based authentication	App	basic-flow	t	t
9fd29de3-44e0-434f-b7bb-0d098f9a75f6	forms	Username, password, otp and other auth forms.	App	basic-flow	f	t
49aeed77-a595-4f86-855d-6e5827add648	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	App	basic-flow	f	t
840c623a-b243-49e2-8068-e4147fc56a14	direct grant	OpenID Connect Resource Owner Grant	App	basic-flow	t	t
372f02a6-ce34-4ec1-8530-70b958f4fecb	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	App	basic-flow	f	t
9cca84ba-be69-48ba-80c0-87353744f540	registration	registration flow	App	basic-flow	t	t
74ce11d1-3f5c-4ab7-9dd8-4a8481443787	registration form	registration form	App	form-flow	f	t
0bad4002-d028-442f-85ca-28a21521807d	reset credentials	Reset credentials for a user if they forgot their password or something	App	basic-flow	t	t
f2bddf32-aa27-4c9c-9c61-876c9a12c781	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	App	basic-flow	f	t
80b98a00-d4f6-4465-91e0-c2cf2450f0ce	clients	Base authentication for clients	App	client-flow	t	t
02534362-bd81-438f-974b-67bd98dd96bb	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	App	basic-flow	t	t
4e26b643-44f8-4e10-bfa7-d849e57f88be	User creation or linking	Flow for the existing/non-existing user alternatives	App	basic-flow	f	t
c08d6f68-d11c-4d0e-840d-c1d1c17c352d	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	App	basic-flow	f	t
733cb8d4-d744-44f5-8cd2-3598950f95c7	Account verification options	Method with which to verity the existing account	App	basic-flow	f	t
6e5d8d14-457b-447f-b83f-4f27ad31558a	Verify Existing Account by Re-authentication	Reauthentication of existing account	App	basic-flow	f	t
50273372-4e94-4674-bc82-e8c7d3866de7	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	App	basic-flow	f	t
c6e71d62-b567-4a12-a89f-42f5d24c5dd7	saml ecp	SAML ECP Profile Authentication Flow	App	basic-flow	t	t
d0eb7ac1-0819-4ba9-acb0-6fcfb603ee83	docker auth	Used by Docker clients to authenticate against the IDP	App	basic-flow	t	t
830bd44f-6ca6-4bf8-8ca7-dfe31a4c0d44	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	App	basic-flow	t	t
3122fe17-b90c-4231-928f-e62324f6c607	Authentication Options	Authentication options.	App	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
d86be076-169b-41f2-9e82-7facc5b7b1ef	review profile config	master
0e4311bc-e5b7-4bbe-b9df-5d05f4a1f7d9	create unique user config	master
7bc54682-147c-4b98-8ad6-e614ec1c1d56	review profile config	App
b2c1bd0d-aa31-45dc-8e7e-1cd4a14bfd75	create unique user config	App
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
d86be076-169b-41f2-9e82-7facc5b7b1ef	missing	update.profile.on.first.login
0e4311bc-e5b7-4bbe-b9df-5d05f4a1f7d9	false	require.password.update.after.registration
7bc54682-147c-4b98-8ad6-e614ec1c1d56	missing	update.profile.on.first.login
b2c1bd0d-aa31-45dc-8e7e-1cd4a14bfd75	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
096f72b6-3b44-41a3-8c2e-0d8c275da221	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
8d28d30b-6f86-4660-bb86-5675f4d7c84b	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b545aafd-591f-41e5-b26f-17435382e410	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
6748f472-1b4e-43fa-8f69-93ffbd2ab457	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d1228e78-7937-45d4-ba50-a43daf807f23	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
399902fb-36bf-406f-b2f8-8c5184e7a293	t	f	app-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	App Realm	f	client-secret	\N	\N	\N	t	f	f	f
790e9137-6d96-4c13-a099-ab842c14f32b	t	f	realm-management	0	f	\N	\N	t	\N	f	App	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
4f038b8e-0ad1-446b-9e90-ead3e85d653e	t	f	account	0	t	\N	/realms/app/account/	f	\N	f	App	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
86153581-a8b1-479c-b29c-061271c84de5	t	f	account-console	0	t	\N	/realms/app/account/	f	\N	f	App	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5da2b98f-cfdc-41fa-8ca3-df2c043e9337	t	f	broker	0	f	\N	\N	t	\N	f	App	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	t	f	security-admin-console	0	t	\N	/admin/app/console/	f	\N	f	App	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
bc759ebf-a7fe-4c58-b409-23b7c97d1da1	t	f	admin-cli	0	t	\N	\N	f	\N	f	App	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
b545aafd-591f-41e5-b26f-17435382e410	S256	pkce.code.challenge.method
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	S256	pkce.code.challenge.method
86153581-a8b1-479c-b29c-061271c84de5	S256	pkce.code.challenge.method
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	S256	pkce.code.challenge.method
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	backchannel.logout.revoke.offline.tokens
beba6298-e40f-445e-ab0d-233b70a7d5cc	keycloak	login_theme
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	saml.artifact.binding
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	saml.server.signature
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	saml.server.signature.keyinfo.ext
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	saml.assertion.signature
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	saml.client.signature
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	saml.encrypt
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	saml.authnstatement
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	saml.onetimeuse.condition
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	saml_force_name_id_format
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	saml.multivalued.roles
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	saml.force.post.binding
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	exclude.session.state.from.auth.response
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	oauth2.device.authorization.grant.enabled
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	oidc.ciba.grant.enabled
beba6298-e40f-445e-ab0d-233b70a7d5cc	true	use.refresh.tokens
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	id.token.as.detached.signature
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	tls.client.certificate.bound.access.tokens
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	require.pushed.authorization.requests
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	client_credentials.use_refresh_token
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	display.on.consent.screen
beba6298-e40f-445e-ab0d-233b70a7d5cc	false	backchannel.logout.session.required
beba6298-e40f-445e-ab0d-233b70a7d5cc	172800	access.token.lifespan
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
abfd8b39-f065-4862-82d9-1a1ed8273bc7	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
e083d442-9125-4b10-9ec1-27e8fe6a286d	role_list	master	SAML role list	saml
d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4	profile	master	OpenID Connect built-in scope: profile	openid-connect
4c8c7fec-7401-4549-b96d-c5d63adf1971	email	master	OpenID Connect built-in scope: email	openid-connect
09e1062e-9b80-4b9a-9196-79e852ba3288	address	master	OpenID Connect built-in scope: address	openid-connect
82a71695-8f28-40ad-9e6c-efc965a82b68	phone	master	OpenID Connect built-in scope: phone	openid-connect
b4be1054-0cdc-49c5-bc73-055d8da3933c	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
09d26c1c-e365-476e-be1b-9a2eb90c750b	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
295004d4-ae34-4135-9093-7b35a1f9df31	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
cba4b270-00c3-4930-aaae-d53dfb43b5c3	offline_access	App	OpenID Connect built-in scope: offline_access	openid-connect
e5aa98e6-a31e-41f0-aaca-c99a52473689	role_list	App	SAML role list	saml
2ab8bc7f-7373-4a64-ac43-13b2419af337	profile	App	OpenID Connect built-in scope: profile	openid-connect
9775950f-5ca6-4e0b-8358-55ff4eae5144	email	App	OpenID Connect built-in scope: email	openid-connect
15a581f1-7876-468a-a959-d8e8cced7906	address	App	OpenID Connect built-in scope: address	openid-connect
c84e32dd-96aa-416c-87de-00b29660bbac	phone	App	OpenID Connect built-in scope: phone	openid-connect
ea79f985-5024-4c5b-b2c7-ab78edf9f130	roles	App	OpenID Connect scope for add user roles to the access token	openid-connect
5b864830-f859-44e6-814d-251210334c72	web-origins	App	OpenID Connect scope for add allowed web origins to the access token	openid-connect
be0cd9db-06d7-4cbf-8722-608b252ebdba	microprofile-jwt	App	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
abfd8b39-f065-4862-82d9-1a1ed8273bc7	true	display.on.consent.screen
abfd8b39-f065-4862-82d9-1a1ed8273bc7	${offlineAccessScopeConsentText}	consent.screen.text
e083d442-9125-4b10-9ec1-27e8fe6a286d	true	display.on.consent.screen
e083d442-9125-4b10-9ec1-27e8fe6a286d	${samlRoleListScopeConsentText}	consent.screen.text
d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4	true	display.on.consent.screen
d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4	${profileScopeConsentText}	consent.screen.text
d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4	true	include.in.token.scope
4c8c7fec-7401-4549-b96d-c5d63adf1971	true	display.on.consent.screen
4c8c7fec-7401-4549-b96d-c5d63adf1971	${emailScopeConsentText}	consent.screen.text
4c8c7fec-7401-4549-b96d-c5d63adf1971	true	include.in.token.scope
09e1062e-9b80-4b9a-9196-79e852ba3288	true	display.on.consent.screen
09e1062e-9b80-4b9a-9196-79e852ba3288	${addressScopeConsentText}	consent.screen.text
09e1062e-9b80-4b9a-9196-79e852ba3288	true	include.in.token.scope
82a71695-8f28-40ad-9e6c-efc965a82b68	true	display.on.consent.screen
82a71695-8f28-40ad-9e6c-efc965a82b68	${phoneScopeConsentText}	consent.screen.text
82a71695-8f28-40ad-9e6c-efc965a82b68	true	include.in.token.scope
b4be1054-0cdc-49c5-bc73-055d8da3933c	true	display.on.consent.screen
b4be1054-0cdc-49c5-bc73-055d8da3933c	${rolesScopeConsentText}	consent.screen.text
b4be1054-0cdc-49c5-bc73-055d8da3933c	false	include.in.token.scope
09d26c1c-e365-476e-be1b-9a2eb90c750b	false	display.on.consent.screen
09d26c1c-e365-476e-be1b-9a2eb90c750b		consent.screen.text
09d26c1c-e365-476e-be1b-9a2eb90c750b	false	include.in.token.scope
295004d4-ae34-4135-9093-7b35a1f9df31	false	display.on.consent.screen
295004d4-ae34-4135-9093-7b35a1f9df31	true	include.in.token.scope
cba4b270-00c3-4930-aaae-d53dfb43b5c3	true	display.on.consent.screen
cba4b270-00c3-4930-aaae-d53dfb43b5c3	${offlineAccessScopeConsentText}	consent.screen.text
e5aa98e6-a31e-41f0-aaca-c99a52473689	true	display.on.consent.screen
e5aa98e6-a31e-41f0-aaca-c99a52473689	${samlRoleListScopeConsentText}	consent.screen.text
2ab8bc7f-7373-4a64-ac43-13b2419af337	true	display.on.consent.screen
2ab8bc7f-7373-4a64-ac43-13b2419af337	${profileScopeConsentText}	consent.screen.text
2ab8bc7f-7373-4a64-ac43-13b2419af337	true	include.in.token.scope
9775950f-5ca6-4e0b-8358-55ff4eae5144	true	display.on.consent.screen
9775950f-5ca6-4e0b-8358-55ff4eae5144	${emailScopeConsentText}	consent.screen.text
9775950f-5ca6-4e0b-8358-55ff4eae5144	true	include.in.token.scope
15a581f1-7876-468a-a959-d8e8cced7906	true	display.on.consent.screen
15a581f1-7876-468a-a959-d8e8cced7906	${addressScopeConsentText}	consent.screen.text
15a581f1-7876-468a-a959-d8e8cced7906	true	include.in.token.scope
c84e32dd-96aa-416c-87de-00b29660bbac	true	display.on.consent.screen
c84e32dd-96aa-416c-87de-00b29660bbac	${phoneScopeConsentText}	consent.screen.text
c84e32dd-96aa-416c-87de-00b29660bbac	true	include.in.token.scope
ea79f985-5024-4c5b-b2c7-ab78edf9f130	true	display.on.consent.screen
ea79f985-5024-4c5b-b2c7-ab78edf9f130	${rolesScopeConsentText}	consent.screen.text
ea79f985-5024-4c5b-b2c7-ab78edf9f130	false	include.in.token.scope
5b864830-f859-44e6-814d-251210334c72	false	display.on.consent.screen
5b864830-f859-44e6-814d-251210334c72		consent.screen.text
5b864830-f859-44e6-814d-251210334c72	false	include.in.token.scope
be0cd9db-06d7-4cbf-8722-608b252ebdba	false	display.on.consent.screen
be0cd9db-06d7-4cbf-8722-608b252ebdba	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
8d28d30b-6f86-4660-bb86-5675f4d7c84b	b4be1054-0cdc-49c5-bc73-055d8da3933c	t
8d28d30b-6f86-4660-bb86-5675f4d7c84b	4c8c7fec-7401-4549-b96d-c5d63adf1971	t
8d28d30b-6f86-4660-bb86-5675f4d7c84b	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4	t
8d28d30b-6f86-4660-bb86-5675f4d7c84b	09d26c1c-e365-476e-be1b-9a2eb90c750b	t
8d28d30b-6f86-4660-bb86-5675f4d7c84b	295004d4-ae34-4135-9093-7b35a1f9df31	f
8d28d30b-6f86-4660-bb86-5675f4d7c84b	82a71695-8f28-40ad-9e6c-efc965a82b68	f
8d28d30b-6f86-4660-bb86-5675f4d7c84b	09e1062e-9b80-4b9a-9196-79e852ba3288	f
8d28d30b-6f86-4660-bb86-5675f4d7c84b	abfd8b39-f065-4862-82d9-1a1ed8273bc7	f
b545aafd-591f-41e5-b26f-17435382e410	b4be1054-0cdc-49c5-bc73-055d8da3933c	t
b545aafd-591f-41e5-b26f-17435382e410	4c8c7fec-7401-4549-b96d-c5d63adf1971	t
b545aafd-591f-41e5-b26f-17435382e410	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4	t
b545aafd-591f-41e5-b26f-17435382e410	09d26c1c-e365-476e-be1b-9a2eb90c750b	t
b545aafd-591f-41e5-b26f-17435382e410	295004d4-ae34-4135-9093-7b35a1f9df31	f
b545aafd-591f-41e5-b26f-17435382e410	82a71695-8f28-40ad-9e6c-efc965a82b68	f
b545aafd-591f-41e5-b26f-17435382e410	09e1062e-9b80-4b9a-9196-79e852ba3288	f
b545aafd-591f-41e5-b26f-17435382e410	abfd8b39-f065-4862-82d9-1a1ed8273bc7	f
d1228e78-7937-45d4-ba50-a43daf807f23	b4be1054-0cdc-49c5-bc73-055d8da3933c	t
d1228e78-7937-45d4-ba50-a43daf807f23	4c8c7fec-7401-4549-b96d-c5d63adf1971	t
d1228e78-7937-45d4-ba50-a43daf807f23	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4	t
d1228e78-7937-45d4-ba50-a43daf807f23	09d26c1c-e365-476e-be1b-9a2eb90c750b	t
d1228e78-7937-45d4-ba50-a43daf807f23	295004d4-ae34-4135-9093-7b35a1f9df31	f
d1228e78-7937-45d4-ba50-a43daf807f23	82a71695-8f28-40ad-9e6c-efc965a82b68	f
d1228e78-7937-45d4-ba50-a43daf807f23	09e1062e-9b80-4b9a-9196-79e852ba3288	f
d1228e78-7937-45d4-ba50-a43daf807f23	abfd8b39-f065-4862-82d9-1a1ed8273bc7	f
6748f472-1b4e-43fa-8f69-93ffbd2ab457	b4be1054-0cdc-49c5-bc73-055d8da3933c	t
6748f472-1b4e-43fa-8f69-93ffbd2ab457	4c8c7fec-7401-4549-b96d-c5d63adf1971	t
6748f472-1b4e-43fa-8f69-93ffbd2ab457	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4	t
6748f472-1b4e-43fa-8f69-93ffbd2ab457	09d26c1c-e365-476e-be1b-9a2eb90c750b	t
6748f472-1b4e-43fa-8f69-93ffbd2ab457	295004d4-ae34-4135-9093-7b35a1f9df31	f
6748f472-1b4e-43fa-8f69-93ffbd2ab457	82a71695-8f28-40ad-9e6c-efc965a82b68	f
6748f472-1b4e-43fa-8f69-93ffbd2ab457	09e1062e-9b80-4b9a-9196-79e852ba3288	f
6748f472-1b4e-43fa-8f69-93ffbd2ab457	abfd8b39-f065-4862-82d9-1a1ed8273bc7	f
096f72b6-3b44-41a3-8c2e-0d8c275da221	b4be1054-0cdc-49c5-bc73-055d8da3933c	t
096f72b6-3b44-41a3-8c2e-0d8c275da221	4c8c7fec-7401-4549-b96d-c5d63adf1971	t
096f72b6-3b44-41a3-8c2e-0d8c275da221	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4	t
096f72b6-3b44-41a3-8c2e-0d8c275da221	09d26c1c-e365-476e-be1b-9a2eb90c750b	t
096f72b6-3b44-41a3-8c2e-0d8c275da221	295004d4-ae34-4135-9093-7b35a1f9df31	f
096f72b6-3b44-41a3-8c2e-0d8c275da221	82a71695-8f28-40ad-9e6c-efc965a82b68	f
096f72b6-3b44-41a3-8c2e-0d8c275da221	09e1062e-9b80-4b9a-9196-79e852ba3288	f
096f72b6-3b44-41a3-8c2e-0d8c275da221	abfd8b39-f065-4862-82d9-1a1ed8273bc7	f
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	b4be1054-0cdc-49c5-bc73-055d8da3933c	t
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	4c8c7fec-7401-4549-b96d-c5d63adf1971	t
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4	t
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	09d26c1c-e365-476e-be1b-9a2eb90c750b	t
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	295004d4-ae34-4135-9093-7b35a1f9df31	f
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	82a71695-8f28-40ad-9e6c-efc965a82b68	f
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	09e1062e-9b80-4b9a-9196-79e852ba3288	f
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	abfd8b39-f065-4862-82d9-1a1ed8273bc7	f
4f038b8e-0ad1-446b-9e90-ead3e85d653e	5b864830-f859-44e6-814d-251210334c72	t
4f038b8e-0ad1-446b-9e90-ead3e85d653e	9775950f-5ca6-4e0b-8358-55ff4eae5144	t
4f038b8e-0ad1-446b-9e90-ead3e85d653e	ea79f985-5024-4c5b-b2c7-ab78edf9f130	t
4f038b8e-0ad1-446b-9e90-ead3e85d653e	2ab8bc7f-7373-4a64-ac43-13b2419af337	t
4f038b8e-0ad1-446b-9e90-ead3e85d653e	cba4b270-00c3-4930-aaae-d53dfb43b5c3	f
4f038b8e-0ad1-446b-9e90-ead3e85d653e	c84e32dd-96aa-416c-87de-00b29660bbac	f
4f038b8e-0ad1-446b-9e90-ead3e85d653e	be0cd9db-06d7-4cbf-8722-608b252ebdba	f
4f038b8e-0ad1-446b-9e90-ead3e85d653e	15a581f1-7876-468a-a959-d8e8cced7906	f
86153581-a8b1-479c-b29c-061271c84de5	5b864830-f859-44e6-814d-251210334c72	t
86153581-a8b1-479c-b29c-061271c84de5	9775950f-5ca6-4e0b-8358-55ff4eae5144	t
86153581-a8b1-479c-b29c-061271c84de5	ea79f985-5024-4c5b-b2c7-ab78edf9f130	t
86153581-a8b1-479c-b29c-061271c84de5	2ab8bc7f-7373-4a64-ac43-13b2419af337	t
86153581-a8b1-479c-b29c-061271c84de5	cba4b270-00c3-4930-aaae-d53dfb43b5c3	f
86153581-a8b1-479c-b29c-061271c84de5	c84e32dd-96aa-416c-87de-00b29660bbac	f
86153581-a8b1-479c-b29c-061271c84de5	be0cd9db-06d7-4cbf-8722-608b252ebdba	f
86153581-a8b1-479c-b29c-061271c84de5	15a581f1-7876-468a-a959-d8e8cced7906	f
bc759ebf-a7fe-4c58-b409-23b7c97d1da1	5b864830-f859-44e6-814d-251210334c72	t
bc759ebf-a7fe-4c58-b409-23b7c97d1da1	9775950f-5ca6-4e0b-8358-55ff4eae5144	t
bc759ebf-a7fe-4c58-b409-23b7c97d1da1	ea79f985-5024-4c5b-b2c7-ab78edf9f130	t
bc759ebf-a7fe-4c58-b409-23b7c97d1da1	2ab8bc7f-7373-4a64-ac43-13b2419af337	t
bc759ebf-a7fe-4c58-b409-23b7c97d1da1	cba4b270-00c3-4930-aaae-d53dfb43b5c3	f
bc759ebf-a7fe-4c58-b409-23b7c97d1da1	c84e32dd-96aa-416c-87de-00b29660bbac	f
bc759ebf-a7fe-4c58-b409-23b7c97d1da1	be0cd9db-06d7-4cbf-8722-608b252ebdba	f
bc759ebf-a7fe-4c58-b409-23b7c97d1da1	15a581f1-7876-468a-a959-d8e8cced7906	f
5da2b98f-cfdc-41fa-8ca3-df2c043e9337	5b864830-f859-44e6-814d-251210334c72	t
5da2b98f-cfdc-41fa-8ca3-df2c043e9337	9775950f-5ca6-4e0b-8358-55ff4eae5144	t
5da2b98f-cfdc-41fa-8ca3-df2c043e9337	ea79f985-5024-4c5b-b2c7-ab78edf9f130	t
5da2b98f-cfdc-41fa-8ca3-df2c043e9337	2ab8bc7f-7373-4a64-ac43-13b2419af337	t
5da2b98f-cfdc-41fa-8ca3-df2c043e9337	cba4b270-00c3-4930-aaae-d53dfb43b5c3	f
5da2b98f-cfdc-41fa-8ca3-df2c043e9337	c84e32dd-96aa-416c-87de-00b29660bbac	f
5da2b98f-cfdc-41fa-8ca3-df2c043e9337	be0cd9db-06d7-4cbf-8722-608b252ebdba	f
5da2b98f-cfdc-41fa-8ca3-df2c043e9337	15a581f1-7876-468a-a959-d8e8cced7906	f
790e9137-6d96-4c13-a099-ab842c14f32b	5b864830-f859-44e6-814d-251210334c72	t
790e9137-6d96-4c13-a099-ab842c14f32b	9775950f-5ca6-4e0b-8358-55ff4eae5144	t
790e9137-6d96-4c13-a099-ab842c14f32b	ea79f985-5024-4c5b-b2c7-ab78edf9f130	t
790e9137-6d96-4c13-a099-ab842c14f32b	2ab8bc7f-7373-4a64-ac43-13b2419af337	t
790e9137-6d96-4c13-a099-ab842c14f32b	cba4b270-00c3-4930-aaae-d53dfb43b5c3	f
790e9137-6d96-4c13-a099-ab842c14f32b	c84e32dd-96aa-416c-87de-00b29660bbac	f
790e9137-6d96-4c13-a099-ab842c14f32b	be0cd9db-06d7-4cbf-8722-608b252ebdba	f
790e9137-6d96-4c13-a099-ab842c14f32b	15a581f1-7876-468a-a959-d8e8cced7906	f
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	5b864830-f859-44e6-814d-251210334c72	t
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	9775950f-5ca6-4e0b-8358-55ff4eae5144	t
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	ea79f985-5024-4c5b-b2c7-ab78edf9f130	t
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	2ab8bc7f-7373-4a64-ac43-13b2419af337	t
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	cba4b270-00c3-4930-aaae-d53dfb43b5c3	f
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	c84e32dd-96aa-416c-87de-00b29660bbac	f
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	be0cd9db-06d7-4cbf-8722-608b252ebdba	f
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	15a581f1-7876-468a-a959-d8e8cced7906	f
beba6298-e40f-445e-ab0d-233b70a7d5cc	5b864830-f859-44e6-814d-251210334c72	t
beba6298-e40f-445e-ab0d-233b70a7d5cc	9775950f-5ca6-4e0b-8358-55ff4eae5144	t
beba6298-e40f-445e-ab0d-233b70a7d5cc	ea79f985-5024-4c5b-b2c7-ab78edf9f130	t
beba6298-e40f-445e-ab0d-233b70a7d5cc	2ab8bc7f-7373-4a64-ac43-13b2419af337	t
beba6298-e40f-445e-ab0d-233b70a7d5cc	cba4b270-00c3-4930-aaae-d53dfb43b5c3	f
beba6298-e40f-445e-ab0d-233b70a7d5cc	c84e32dd-96aa-416c-87de-00b29660bbac	f
beba6298-e40f-445e-ab0d-233b70a7d5cc	be0cd9db-06d7-4cbf-8722-608b252ebdba	f
beba6298-e40f-445e-ab0d-233b70a7d5cc	15a581f1-7876-468a-a959-d8e8cced7906	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
abfd8b39-f065-4862-82d9-1a1ed8273bc7	faf59957-e96e-43f0-a443-7cad62e9149d
cba4b270-00c3-4930-aaae-d53dfb43b5c3	85218571-5a13-4ab8-be3a-96f7e860c605
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
f498d630-27b9-4b59-99cb-a9cafeee94ac	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
6d469cf8-2621-44a0-b400-2bcb0adef4ec	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
322c2383-7b51-4387-8e17-9f787538e755	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
a5d5e398-6deb-4d71-a19a-82d3a8854676	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
dc322b80-7b1c-4088-a2a9-ea44e03fbd71	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
eca688c3-fd51-430d-a20c-bb4cd2b7fcc7	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
598de661-9abb-4cf1-8cf8-d75a4a509653	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
e79636d8-19f6-4053-8394-2b2af570938c	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
c820cc1f-c793-4c58-892e-e9ea950b23b3	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
550cff63-198a-4d62-be91-5278aad7f4b6	rsa-enc-generated	master	rsa-enc-generated	org.keycloak.keys.KeyProvider	master	\N
9193e7de-266e-42bc-acd0-93920b619cd1	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
8362d25a-56c7-4c31-9c4e-11c515a059ca	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
5bce3483-5e14-48c4-949a-e4ba2b268bd4	rsa-generated	App	rsa-generated	org.keycloak.keys.KeyProvider	App	\N
0f84bceb-faff-4549-b8d5-7e197776d25e	rsa-enc-generated	App	rsa-enc-generated	org.keycloak.keys.KeyProvider	App	\N
7e1270b8-918d-4dbb-b05e-00b45c1b6de7	hmac-generated	App	hmac-generated	org.keycloak.keys.KeyProvider	App	\N
6ed9f2db-e70d-4b94-aed9-9557a62e93bc	aes-generated	App	aes-generated	org.keycloak.keys.KeyProvider	App	\N
5e91b967-ec7b-42e6-bb76-7ac4deb49062	Trusted Hosts	App	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	App	anonymous
dc28e306-4c10-4583-a2b4-26aceef27346	Consent Required	App	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	App	anonymous
2bade9a5-adc9-4ec2-bc28-d9470d0b9563	Full Scope Disabled	App	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	App	anonymous
89cd6443-2ce5-4f7e-9340-b27331e87b6c	Max Clients Limit	App	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	App	anonymous
3b9c6e7a-7f5b-4f6b-b435-ab0bbb6df19d	Allowed Protocol Mapper Types	App	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	App	anonymous
8a38eb0e-a736-4a5d-aa0f-e1cdc9b9b807	Allowed Client Scopes	App	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	App	anonymous
eb7060bf-4ac3-46bf-bee3-0b6e569b7fc5	Allowed Protocol Mapper Types	App	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	App	authenticated
9cc5e7ef-6a3a-442d-9a02-fa381755132b	Allowed Client Scopes	App	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	App	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
acbdf1b6-ac11-4a32-aef5-b34e3ea3e576	a5d5e398-6deb-4d71-a19a-82d3a8854676	max-clients	200
1c42b671-4ba6-4cac-ae54-04fe6a57d9ec	f498d630-27b9-4b59-99cb-a9cafeee94ac	host-sending-registration-request-must-match	true
c389c7c9-c499-4c1a-b583-5c2891596422	f498d630-27b9-4b59-99cb-a9cafeee94ac	client-uris-must-match	true
d6f5a046-7249-4cc1-8c6e-84361172bc68	dc322b80-7b1c-4088-a2a9-ea44e03fbd71	allowed-protocol-mapper-types	oidc-full-name-mapper
5abd2345-3c8f-40b9-a74e-9c0490d8f7c1	dc322b80-7b1c-4088-a2a9-ea44e03fbd71	allowed-protocol-mapper-types	saml-role-list-mapper
6d64631c-7218-4a2b-bfd3-09925f5f59db	dc322b80-7b1c-4088-a2a9-ea44e03fbd71	allowed-protocol-mapper-types	saml-user-attribute-mapper
305606cc-456f-4b85-ab41-8fc2bc784a5c	dc322b80-7b1c-4088-a2a9-ea44e03fbd71	allowed-protocol-mapper-types	saml-user-property-mapper
e53513ca-1302-46af-a727-47cda1e899a1	dc322b80-7b1c-4088-a2a9-ea44e03fbd71	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
a4e23626-6969-4ee1-8c45-35839f314bcb	dc322b80-7b1c-4088-a2a9-ea44e03fbd71	allowed-protocol-mapper-types	oidc-address-mapper
1a468745-ad26-49b4-b927-c4a8ce80ec7d	dc322b80-7b1c-4088-a2a9-ea44e03fbd71	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
31e917b7-79ea-41da-9a18-dff3cad5164c	dc322b80-7b1c-4088-a2a9-ea44e03fbd71	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a52a85d4-6c39-4d54-8d7d-4d3e654f4912	598de661-9abb-4cf1-8cf8-d75a4a509653	allowed-protocol-mapper-types	saml-user-attribute-mapper
5ef2fb1f-704b-4e58-a7f0-ed84b554c1af	598de661-9abb-4cf1-8cf8-d75a4a509653	allowed-protocol-mapper-types	oidc-address-mapper
d6492ec7-2a83-4ddd-ab9f-93c9bb58b1fd	598de661-9abb-4cf1-8cf8-d75a4a509653	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f08e93ee-6b9d-4510-821a-352198964835	598de661-9abb-4cf1-8cf8-d75a4a509653	allowed-protocol-mapper-types	saml-role-list-mapper
813adf1a-ffec-4f16-bd90-67fbfedf4c1d	598de661-9abb-4cf1-8cf8-d75a4a509653	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
09b93396-ab15-4d88-9f17-31a0d6a07677	598de661-9abb-4cf1-8cf8-d75a4a509653	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e43afc20-60b1-4830-a2d1-8525f5dc78da	598de661-9abb-4cf1-8cf8-d75a4a509653	allowed-protocol-mapper-types	saml-user-property-mapper
deeaf161-e21b-4304-a821-d7a343f86fa6	598de661-9abb-4cf1-8cf8-d75a4a509653	allowed-protocol-mapper-types	oidc-full-name-mapper
80f25533-2b8a-4cb5-badb-8382d8711515	e79636d8-19f6-4053-8394-2b2af570938c	allow-default-scopes	true
0cd9e434-5059-4a8c-8b4e-23d07782b4a7	eca688c3-fd51-430d-a20c-bb4cd2b7fcc7	allow-default-scopes	true
e53f8d93-b8f8-4a6c-9b74-cea9e0e92a1e	8362d25a-56c7-4c31-9c4e-11c515a059ca	kid	0606a7b7-4dc4-45e9-83e6-d21104c5920e
412982b6-a8c8-479f-8693-3472e5701ded	8362d25a-56c7-4c31-9c4e-11c515a059ca	secret	mTdN9HAHXLkVzNKdJtgfWA
cb6776d2-8d37-4639-9e46-2a5ad15c6726	8362d25a-56c7-4c31-9c4e-11c515a059ca	priority	100
6f5159c8-d69e-4b62-af0a-4baedef9b20b	c820cc1f-c793-4c58-892e-e9ea950b23b3	privateKey	MIIEpAIBAAKCAQEAupUq7zAWShJdgYBdsVNUCWw/lJJAonBXiUwvZS7rVseUBveWQFbjOD97G6fJANyPiig4ytSNAfpOmeDsK+q53GBDZMqWPHu3ItxgL9YzEJE+/9tYBZrv5s8SWhk+021K2BUrglPJfexRlB+tfIQIjsNNDdgvS/UM7Tq5JwgNlMvfpKyh8Ot4qqyQQKTgr3fErE37iv/7FZMnmYURxvgInqQ7+6Lha3MTgOC32VagUPEfvKimuuJ3YnyzUxPLXIComngK7qWWFTmrXsyXOc/+YBL67zDicRuAO3rB1C9uPq/CPPOVn5u1ysnNHZVzw2GAYr3vNu7Z9qLWoLZkKIVolwIDAQABAoIBAETNkvqG6gFAinihxGsKhle/MibwU6NS+ASqMmQGjEQA7qYvEJoDMGDij9wf4DBQJSJWOLMa9DCBhBCcb5q2QPlyCggV6Ja/LEZPq6yYOVZnqSqiUPAoNUUQoPzWiGNgzxOloti5WvjzdxW/JLNg4OL8Q+LSEIbbA3xLhlFNV+zBK6HpuiAUIEzkJtdJv88vW2J1565lGebf4zPJHx8kJX45GkXl98syN7gvJyJ+K3uzt0qSFsZqVhy2sq0y53RKvt3q6V8rr3dl/frPTUNBePkm1MQum/SHY5Sagj+2kp83gDxrI3dGwoJ49gbsuT0yZTb5UjMFAlbD//glyqEv3BkCgYEA7cVLbsh73fxfDEVIcylYekuoFigTfFxSNDHVo7ToQsIWBhjjOReqpLlLMque20kgbtC490y69hfljb+0jALavohkcC7Z21qAgPcyCw0CXTUrVR3Y7B8M0rCXd3P3I5lbWjOkX9dDh3aeuLlYaWZ2mpVX3jt8cOeT6m/kMh5mKqsCgYEAyOM15TpFlqp8CuvAWaRB5vxZ0OASQXm1c4p4F+ThOzeNpNCvY9eR3oqqUkh+Xd34jW6jhKv5QCedTsiK5OUUweJuir4MILpj20cES9lCZ2XIWK4AY4WZWWGuKGbifuR7zrGNqtoAInOdIPS9VzSCYhify858+nXLuUTQAU0zucUCgYEAsSDHHxJvZGG7lPKQFGp6pTBzWX4ldgF4o7V0R+5fEExyB7zGmSOOVgRLhsXfI9EIPkVzZZdduDL5KW3k3GDMACCvYfslBIoZLPn5582bM0CGtXP0w4ImFVbEn5JeS8DVEw9hppxAjEvL1iUNPge810/mE4IRJDMAOCd+we9vgN0CgYAMXxG+oCwQ70bcVVBvNNJqKzhMyL/XEGvARdLHhezo/K7Ya5GhkHEHR3rdvmEp3rWj4CBp1z1uWgIyC9+h4Qm6Nvufx7xvd4sWwfTdxu9z9qyz6WNUvbGH86AKFOv17JRDUmPrFanUdVJD6U6PxEgTSnjs0DaaJg75xecZbWu2EQKBgQCrPxonAQQkVS6mcDAp8baBWuMDOB6QiNmq2DS8gXU99C00NDSDCxrgjHwV4IWqCLUYJVeFL7Arr6evGTAGG664NwxbQoHwCXATlH4aSxQ4xGM9exUt9NOqis95v2V0xuwn65ObkIWVYTay1EC9Ryjoy+d5zMkwCkjDB2zAFoP8Zg==
d979a461-15fd-48c9-9b33-dd5b7d6d82cf	c820cc1f-c793-4c58-892e-e9ea950b23b3	certificate	MIICmzCCAYMCBgGGEpt7qDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwMjAyMTQ0ODQ1WhcNMzMwMjAyMTQ1MDI1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC6lSrvMBZKEl2BgF2xU1QJbD+UkkCicFeJTC9lLutWx5QG95ZAVuM4P3sbp8kA3I+KKDjK1I0B+k6Z4Owr6rncYENkypY8e7ci3GAv1jMQkT7/21gFmu/mzxJaGT7TbUrYFSuCU8l97FGUH618hAiOw00N2C9L9QztOrknCA2Uy9+krKHw63iqrJBApOCvd8SsTfuK//sVkyeZhRHG+AiepDv7ouFrcxOA4LfZVqBQ8R+8qKa64ndifLNTE8tcgKiaeArupZYVOatezJc5z/5gEvrvMOJxG4A7esHUL24+r8I885Wfm7XKyc0dlXPDYYBive827tn2otagtmQohWiXAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAhpTzQSNHw/dlI9s/dEIYEG2JfAY2cDcZ2E6byXRlgEMlfb/XhVWj67Hs5fjhDTuwBewuSRflgz/lvZn3dEkFvZ4OKVnjTeLgPUaNu/X/C03UwbWI5FsC8rbyKsefcsp5KuNU3Gq2L1c+mz6+ea+GEV1vcytmyJ7BXTz3/sATATltNUuZRujnMcgbdIH5iClFp+QeYaf7+fY5DF1amTdinHrH7jZzS4GypZn+zRRQcWtrWyWA4L20DcF/nuRbQ/T7b8m2wQkwUH/qzpEoBKVpW3mjMEIuEr73JlYUgUCw5f+3qTkm4R2ZnY21JoulcTlsQ5U1cPCsnJMXZumb1xDCQ=
a4f576c2-1fbb-4274-97a2-e2f1d1492cce	c820cc1f-c793-4c58-892e-e9ea950b23b3	keyUse	SIG
2e87773b-ac93-4d9a-a230-c49fe60a9209	c820cc1f-c793-4c58-892e-e9ea950b23b3	priority	100
67ccd528-42ba-46e7-ab3d-ff335eabd8ae	9193e7de-266e-42bc-acd0-93920b619cd1	algorithm	HS256
41bd0c38-9fe1-47c2-8482-9e7bab30e72b	9193e7de-266e-42bc-acd0-93920b619cd1	priority	100
0a8ffdfc-235d-47bc-b1e2-7a49da928386	9193e7de-266e-42bc-acd0-93920b619cd1	kid	e28e363f-d4b5-4537-af4f-5d85ba77b0ce
7ee90059-a1fb-4afc-91f2-0962f4320b34	9193e7de-266e-42bc-acd0-93920b619cd1	secret	AfSm4O74aRgySDb_9jI2L9QON9mgum-khOY2JcdhMtRl32tTQCRVGw5_lnDxq_C-Gz7A0s5b6pKnf9UZn5er7w
8a18c1b9-45a7-434f-b374-5491346e2f99	550cff63-198a-4d62-be91-5278aad7f4b6	algorithm	RSA-OAEP
6d635c85-c3f4-41c9-b2b5-545cd9af430d	0f84bceb-faff-4549-b8d5-7e197776d25e	keyUse	ENC
98cd41ca-76ea-4d40-a06c-e64c34dd9287	550cff63-198a-4d62-be91-5278aad7f4b6	certificate	MIICmzCCAYMCBgGGEpt8LzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwMjAyMTQ0ODQ1WhcNMzMwMjAyMTQ1MDI1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCMjEWF+cnhzT4vWqtQNlKFabI9kHlLxtVDTrhapVyhoXYdWS4QTqJP+xgpMQ/+R/TzEiFxwRTq547ftBvQQ9Jk0s4K1XyCTj4j2lAJzhJON4Ax60DE/PNPUN81r5aAjX/bEsEuUEIPv0J1I/fKkNU/1lensbFTuWpztbcDRkF2rS2tkGuMJIAMWXKNnUbZpqqNTDL6rb/7ehNedLeCpUs40c463kuxzPZh2HvBPD+Fe0Oouq0mjG6oS8L2QsCLfc2o62Y7QIhkR40p6XWg/QgRiY26hpM6mg6xb3oEGb47O/BlF34NV36X2bpqoo2pmlFh/eHR90DPYGvc7kCokmaNAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIXJRVNEKXLU4aldFqnTGmsNBoyl5vFvEMxUSceLuJEkvbZoltjBagSrC7tjEub73wz/S+CQDozu0BzFiHU++Lv794BalaYrkl6T0peS/Jst2THXfeu37CZ/n2YPtJ3ux9poy8d7Lv9EPsMYWn7SVzaSePip66fVaBr9IMJfeZaPVyfnxGc3n9La5pYMElAPUqoBS+EjbBAdbH5y5+2BkYXg+m9x9gPvNW0T2YDS81dtiX/lguae5ttJWTrqveRAiQAo3Brf+sBvNCEzk7iiQ8xSwZ0+5PuVb1ZRvT8o8cv9MJOTCZwDC8SEmHapIXrSXnPSqOodtsXP/wglG863/ec=
83f3e7ae-cf74-4eac-af38-36b29d7d104f	550cff63-198a-4d62-be91-5278aad7f4b6	privateKey	MIIEogIBAAKCAQEAjIxFhfnJ4c0+L1qrUDZShWmyPZB5S8bVQ064WqVcoaF2HVkuEE6iT/sYKTEP/kf08xIhccEU6ueO37Qb0EPSZNLOCtV8gk4+I9pQCc4STjeAMetAxPzzT1DfNa+WgI1/2xLBLlBCD79CdSP3ypDVP9ZXp7GxU7lqc7W3A0ZBdq0trZBrjCSADFlyjZ1G2aaqjUwy+q2/+3oTXnS3gqVLONHOOt5Lscz2Ydh7wTw/hXtDqLqtJoxuqEvC9kLAi33NqOtmO0CIZEeNKel1oP0IEYmNuoaTOpoOsW96BBm+OzvwZRd+DVd+l9m6aqKNqZpRYf3h0fdAz2Br3O5AqJJmjQIDAQABAoIBAAlenI/m7Bd6iEe94qfRR0UPm8tQ41Uy5yq6h727QmagDfC87j42D8oHMkAkvi00fNbrgYFE3vEeCL9PEX+b1d3U09mTC97f+nKHbkiJDV1bg9dQGJxJRKsn+AlrMDxXsotXP7unrA/Cr1qB0FYXu6+qyWMrjGfJd5hJJ+828sxHe/IxejcTjfzv/CUMIA8AMXbJD3XvTAKZ4G9iJ5LSmVAkJmzbmOV+pUOcrkVnsuUOSRWN/UQlzuCA5s8oCxhlpXubMorcvZuiWao+/CM0xm4MZZaw0y6Ye45jXnqGr3ZPfL7r1Xjm24fGMpux++eKtNXR5i6he3fw+N3VG4Km1P0CgYEAxNELu0W+4X7re3riHMV6YHLJvZsKraq06+qocDxR1w5NNZX0chSdReqsW3rDUv+ygJGIpRg6G6haIX8kVjvsm1V64eqWjLJyyPw9qMNr6tzhw3qwjYVvFUT1ccYOIVinN6NvjtM3ulJD10Q0Cdun17wDidEM9O5S9ZR11qcCZusCgYEAts+pSUqwFuCEse35+LwXKwy1ieHKN0tx1JWSkLH0ScJAPeFwv9O0xZpkFz8mWLPjPRgR7p4qxXm3bYwLtXZBONCszVINvgf3utOwsyGZsLLg4eqdfGVSsU0iB+WdzqHWOisIprPOS3ijKndQ8rF+M4nPN83XIVCISaU6Kp7temcCgYBrEiKktbO7LvXijh5WcqQ5thjEOoVbpyOXuGf77wTCzvf37+U07rwEnj834RhDnfE4+nNxBTYPd83YrTdSZnU4qA8auik+z5Gcf4T3u6CI+7MiSiukQfQFiSdRxuJHB9iobxQwif2mMjzP7j21IzczKQhvwDehQ8oD6ckVhnPLEwKBgH06l76rOSESwBOa76fiQQSuehVv5LQoLFvx8irInI2CUbuSGUhu3+CVOIdsLPqKj9mkCXSqSKZqEKssSkEONvOSjy0/Tkak8qC6rsqm879FaiOYMjWquxDVw8AhHQ8Vccj6/bwkY+bzRuKqRXta9xabCqYxjXM21YWNd+EGaat1AoGAK+VAc7rjuIIX3iQvqg1A3h8P8zpYw/4+vHJRQ1kMq9tEe/Hcdy7uJEv80/zsd9ich2adPQbwfeZX9Onxo1h9apbf3jZynERO9zpEOcXOmUfKa+111JkMSBY0A0xazXV2mMK84tNbmDnrQWA8T+sKsO6WVgwR2ydbn0/JdBOpBJE=
cfbdef03-04b1-441a-87eb-f5fbede6cab2	550cff63-198a-4d62-be91-5278aad7f4b6	keyUse	ENC
99fa8baa-507d-4c10-ba41-a8bd9fb2a41b	550cff63-198a-4d62-be91-5278aad7f4b6	priority	100
008b30ec-f938-441a-b337-634350cccf76	6ed9f2db-e70d-4b94-aed9-9557a62e93bc	secret	6JNyU3IceODusKujgdpteA
ca0ae7f1-1bdc-4e1b-b9c1-e49cc8cf73ba	6ed9f2db-e70d-4b94-aed9-9557a62e93bc	priority	100
ae8e54a1-d6a3-48e0-9dcf-8a065e1fb451	6ed9f2db-e70d-4b94-aed9-9557a62e93bc	kid	8a20fa3b-5a1d-4c1d-ac78-b49d36ae298c
5d718f52-35ba-4c81-a049-e8ce05b18fa4	5bce3483-5e14-48c4-949a-e4ba2b268bd4	priority	100
b58d6e71-2125-4a92-84ae-6461eee03850	5bce3483-5e14-48c4-949a-e4ba2b268bd4	certificate	MIICpTCCAY0CBgGGEvkZvzANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtLTVMgUGhvZW5peDAeFw0yMzAyMDIxNjMxMDBaFw0zMzAyMDIxNjMyNDBaMBYxFDASBgNVBAMMC0tNUyBQaG9lbml4MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqQCB/qzQ9xHT5Buzrd6s5PuyP+8VdCwLBrhJCjNWJu4EM8OLiqCucIckQfLRSHrZahuP303/H1+26zZWlqIJBYXEdeCvO6DHXoXyDqhxeK4sZ/XKV2MZxUVZRatK+ZqbQwYZ5tuBW0azm6Vu3T+LK5azIU69AAsje0TTgn2mPqvZ9dft4mxk2Sh0b2ffPkAnc2K6BGL8aijKmOQFpBAoQUb2c3UA6ceYJC5T+ajMZp7O4gVnQePszeqvpo8zIexQNb+ABBaoj4EtudEmx6u8VN5U6xMea9mgnAuuZZgBBMMStPJMgmPibiLwPd/iWp6BEybNh5U/v7HUg/nIdh21YQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAOQlsAhPSDIKnx8bDzZqisuDPzMPWXUFqBfULLlkd5tlBx+JbtaIqYUbX1VA9xAEXuN08oYAoWTJg2A7YZy1e5I3BHAe2ZqOgJDtxXx71I/+PfB7dkKakBxi0hb+kPTqu+FYjTRaZGRuky4/wnuToDjMl4FeuHfYQD9gJnkFiXD++a5OKPPNlTDtASjj/aQV9RKhITk2le+j0rxqqkDUxHKvr32a+COmmK8k4H9xxfNqF8OEnWE2TbhdUvihIruNp7ZA0Jf5b66aFeFBlB4NKkr6QzsOijRwuFzPAEv1OLmF14oYSjEV7v+ZBabpD66wSh22cOamM22clYaVNO80dD
286c6dec-39bf-4c74-9d8c-3bb76f93db96	5bce3483-5e14-48c4-949a-e4ba2b268bd4	keyUse	SIG
7850ddee-13f7-4567-bf38-ea8e3a045eb4	5bce3483-5e14-48c4-949a-e4ba2b268bd4	privateKey	MIIEogIBAAKCAQEAqQCB/qzQ9xHT5Buzrd6s5PuyP+8VdCwLBrhJCjNWJu4EM8OLiqCucIckQfLRSHrZahuP303/H1+26zZWlqIJBYXEdeCvO6DHXoXyDqhxeK4sZ/XKV2MZxUVZRatK+ZqbQwYZ5tuBW0azm6Vu3T+LK5azIU69AAsje0TTgn2mPqvZ9dft4mxk2Sh0b2ffPkAnc2K6BGL8aijKmOQFpBAoQUb2c3UA6ceYJC5T+ajMZp7O4gVnQePszeqvpo8zIexQNb+ABBaoj4EtudEmx6u8VN5U6xMea9mgnAuuZZgBBMMStPJMgmPibiLwPd/iWp6BEybNh5U/v7HUg/nIdh21YQIDAQABAoIBAE15qh5yYymgxp6gBHMEzgX7TO/6Tr9/IV7nRLSkbC5UlyCT2HioyM9VZM3G3yJ3DwyRrhcUzow3eMfDlVZg2fnqJPJVGoAfaMZwaVNG7R4B2uGd0DDXgYzqCc7ig/CBbAQB3AX1QwvxEY2c/YH4C3jkESKH0iUe9hkgqEX+DCRWKsx3pimrQ/K6+KR8qirz5ptT88qDTPEd+PR6eJADdpVedaZaYezLNF0SEd6RQgrUQl3msc5DaGeY/VpuOttawA9xUSKNe8846h6qoWE2Vva7GlxIbLSZ7O/rPo2uN9oQxROzrQpY2FbhlA7rVBa9l+JAaM1BlaUxInY3mCQWWzECgYEA9L2vRtd5kSxmi18RFeCvmA2I9F74om7to+I73eRWMUezfWzr1PYzVBbb1Ybg3miO4Ma1Z0uextCRHtO87TSi0tyKe5pEr+C+O89PVbi4EP0KWWKkJiOwAdfTm9NdEbQtukwlZsRBI+QX9xehClT2HFYVk4UwtbR211qCdkMucnsCgYEAsMbYS7AsJCml5jSXsVcJgjbT84kQ2nAcsnfqEEdGkgwKVGnAjgQrCmotuh90Yt0MyMRbWiNrkllc7o7Cr6PS4nR/Adu0VTaCYTOkwG1UvLdqCs65Q1vXIBjYr7ADMgwsPVfaw1Xb0/rgYMroR9T48bVlYu3jaCQwmLCWy0QF7tMCgYB2n33WM1hb8g5d3R014mqZo23PLD0M1gFe3qevvB2+0wb/cwy3cwGb71xsGWziwAEIl6eTQobZzHuaWnyG6G1HENgaYsKKEL+D086bOOYWbd9XRcVUKxYDPq31KDRDAXbshj3WmqcME2E+RXirvlRvlZXto6/hUnALn3X+hj98AwKBgFk3wipQ+7Y0ntoUaQrD1rS1XztmTe8w7grUonkcv+0tznjT9q62Q9K5y+JHxcGvtqgNEd3oSn5OQ6zSuEdU8zX/fao+bEElhZ/xJJFJnJ6yIv7ZXn80dtpoL9RbjQFRS3KaSHqVdqEB2QSA48J9Jjc3SbgoP8FromstlK1541SpAoGAaFdhJRkBHrT3odMC8sUtVHsDPM82ifTfhye/kfZlPU6qe+0g/Z9RCZ+2mRV7nvYXdwbA0gut6HshbpkOdj2aZFui0DrG3rs5ocQUNa3uv549zrkEWm8p0/WY3Khzp03oPqMbvQXrEpVXFX4poxiS5+tUADTox+PFoKHCKg5ojTo=
e4fb71d4-3228-4d6a-8c6d-05d585dce1e6	7e1270b8-918d-4dbb-b05e-00b45c1b6de7	secret	I4-1SqFQde9MdAPYl__A5lRCuh_XiL3jtpoujugfC6XymBR0JREV8m-khQULLJ2UM0aG6l-uzA6xt8_hti3f-A
9b7119b6-efcf-4b5f-9850-d6e80f01d741	7e1270b8-918d-4dbb-b05e-00b45c1b6de7	algorithm	HS256
20695d98-61b0-4606-a763-957b69b3e9b7	7e1270b8-918d-4dbb-b05e-00b45c1b6de7	priority	100
7f6fa5fb-82ef-4c34-ac8b-4862de80fceb	7e1270b8-918d-4dbb-b05e-00b45c1b6de7	kid	d4b46e9f-56c8-4f06-896d-4ad6b1293e28
10c8cf93-fd95-4352-948a-c6ba6375737f	0f84bceb-faff-4549-b8d5-7e197776d25e	certificate	MIICpTCCAY0CBgGGEvkbCjANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtLTVMgUGhvZW5peDAeFw0yMzAyMDIxNjMxMDBaFw0zMzAyMDIxNjMyNDBaMBYxFDASBgNVBAMMC0tNUyBQaG9lbml4MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAi8dk7SsAMNnDkncDoNEdJgKZXR/yHvBvLFENVeqjwDJ69u3OeJ/mRGM+J/qroeDp9rpPDR0ez0nA4NR0YoK3lrwY62ZcF03TPFNLGRMsFaDNx3TLlNsDKpgPnczCcThsYg4Y4gLh5VM+BNHYB1zjNAOI6Zj/R8Ei4aPk+9gNoznzuf9x1VKGLvss0nBskYlvQvvKul2aSbK9GpRwH5ZujekNzf8uaWMtq2fiqZnozET+zNdrBqqeyUanzidJB6CVKsgbKFPVkPh6zYuOSl9zpyim3xOy109yk83fCTVtOJLmoI3TMig9Fb3Fw19kWl4DOmh//pX1vZ4tK3anx/dSNwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAZoO4/pR1XPobWOSGlrozYzBP+/9nPna2gA7t2OL5CXpVi6FO7cp1AW0dZVexP0hXnpys0w/U+EHxbfwR/7ytHF2vfHwpsm89mMuMydQHDXdXE0t+kplVCVIMboaBD0GK3AhjVocLt/uhz99rqwM7qHFeu1VjXz9QS7oCCAMQ4pjpj/YNMqburuNThhQJkrsp2UglRl4fT2mZ1dAbSQmCvvVLnPx9NqULcMsb13eU4duqqrUaDHXXqJGhErA+9GJeJbP8/IcALO0OhkqDkLOW4KulLAyfNs27mNJ6Kf8Xw7L6LOLvNmvGyVKcIKBF+4Q+aqDwaw16oIxtPkFS0Cess
94ac7edb-e32a-40a2-98a2-b9dcace7ba46	0f84bceb-faff-4549-b8d5-7e197776d25e	algorithm	RSA-OAEP
5b68f19c-4b85-4ba9-be66-377af458ce80	0f84bceb-faff-4549-b8d5-7e197776d25e	privateKey	MIIEpAIBAAKCAQEAi8dk7SsAMNnDkncDoNEdJgKZXR/yHvBvLFENVeqjwDJ69u3OeJ/mRGM+J/qroeDp9rpPDR0ez0nA4NR0YoK3lrwY62ZcF03TPFNLGRMsFaDNx3TLlNsDKpgPnczCcThsYg4Y4gLh5VM+BNHYB1zjNAOI6Zj/R8Ei4aPk+9gNoznzuf9x1VKGLvss0nBskYlvQvvKul2aSbK9GpRwH5ZujekNzf8uaWMtq2fiqZnozET+zNdrBqqeyUanzidJB6CVKsgbKFPVkPh6zYuOSl9zpyim3xOy109yk83fCTVtOJLmoI3TMig9Fb3Fw19kWl4DOmh//pX1vZ4tK3anx/dSNwIDAQABAoIBADRxqodlo9uwSLWSW9UhwGr7fKk5DDHZigy5mGRM9gVtqz8seFQ/wjiUd8SuQ2koJwBAZNqJu36QsIJqlARGATXX+w2PSSwhMgknQzz0OY0f2TVlt+Bwz95SUUGmiqnKPrgHjAR4imLteY57YS9aBZEFZoAmvFkiuMCqKobnSC6eR79fpI6awk60CK+MvlbSOabTw4BIdHJVhR9hC9wFMtsZijiNxSvk10o2vog0W8X7sj9xpvmRhY6F73IXpcQZ5mEYL+87lPB7ue3CGHdibOWutlMcTKp5qCMG5/SofKnplhcsNwiU3UfzzeBEt79RYQgCUFPgn/LaMfja++Fi1IkCgYEA1VBDZXKuJVsSKFumnKckZ/Qb/f+2bL8JwcoZl7GW4qhYYXMAwSz8DthqivLIZoYUz2YAuBB2rs8cPpq36K6XXphj8AUnHjaUA50Di5ABNzYJX7rZ13mykJ8YesZYOWGTHfLDBTRF4Ih6IdvVg/zgCfVh4gICypS8uz0lTsYS0csCgYEAp8APUUtRXE306dDXI72JmRhTaYf2KOaEoa+NhUO/x4dcX+ptsZFg6ddZ/oMI0C1k9PkLKr1k+QDS3SOpQ42a/DekR7Yvboa/WciOBqXj9uo/6rPiEoQUJYG82KGZ3BnQvGAZ2BJlMIkL++YYfQLZ6TjUroR+OSBiNkuXgDZDg8UCgYEAyCXLVwDHjZ1p6Bw2tH3PlwpgyW6JiHenfAFZChBDduBmLOlvJ9JBntxI+57Zkfj0xbT7r7ki4trJsaQSM2y98rAh9S+giKTFNK66iNTRjzBQk1YK2DcD6NaebXR1i0GWfF8vxU5K0ma70dEnAfTfcfifoyQn4lS00SqKOuN2/QkCgYAbt9uQFj7qXqNCY1S5Ph9XYbKetG2TUovF36klxQ0SXiaAXs8jUR9PZFsld+dj5qxQ4jnbJRJjJqSxD6xvUh2y4UrO4qaxv6gsoLv/Ezg423oWQQTxBEwD6o0WypUOzmE0TzjWACwiOfL1+44+UdNJ+y8BazkkHVq9F/5/m/fJ9QKBgQCBcheCtR/sKedILOvPRQubDwSa8e8VyRNbvyEKEGQet81iooV62k1QYYd5Kmsw6ZgYtjrtBAnTNHtmQb4zL0wgMPMX/cvi9mpNk1pIc7e8lKGohybbad5bA+arMA/W7l7ucxzq/4lDckXqTD8q6mH7clxZCwq61Rb60oHDkp2UqQ==
b0c87e13-3c57-4284-9eed-0c29900e866c	0f84bceb-faff-4549-b8d5-7e197776d25e	priority	100
d45f618f-5093-4cbf-9766-ec77cfe4bb23	5e91b967-ec7b-42e6-bb76-7ac4deb49062	client-uris-must-match	true
a27c23c5-d99a-493c-93af-eb6dcbc36df9	5e91b967-ec7b-42e6-bb76-7ac4deb49062	host-sending-registration-request-must-match	true
54d3ad95-1f74-4d50-bd3c-27c641ea1d09	9cc5e7ef-6a3a-442d-9a02-fa381755132b	allow-default-scopes	true
222dcb5d-6100-4d7e-8bb4-5868cbde88ff	3b9c6e7a-7f5b-4f6b-b435-ab0bbb6df19d	allowed-protocol-mapper-types	saml-role-list-mapper
af4a6fbf-be45-4ad9-b5cc-f1dd2549b906	3b9c6e7a-7f5b-4f6b-b435-ab0bbb6df19d	allowed-protocol-mapper-types	oidc-address-mapper
dd3dc13c-e4fe-437a-9c33-cf6c05becbda	3b9c6e7a-7f5b-4f6b-b435-ab0bbb6df19d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ea48082b-3f0d-47da-a231-bed8db2a90b7	3b9c6e7a-7f5b-4f6b-b435-ab0bbb6df19d	allowed-protocol-mapper-types	oidc-full-name-mapper
ec6adbfc-7703-4546-b768-fae9585fd7fa	3b9c6e7a-7f5b-4f6b-b435-ab0bbb6df19d	allowed-protocol-mapper-types	saml-user-property-mapper
fe8ab5f1-9feb-48be-b1d3-c88eb622770c	3b9c6e7a-7f5b-4f6b-b435-ab0bbb6df19d	allowed-protocol-mapper-types	saml-user-attribute-mapper
aa5f1949-6fde-45eb-9394-ba527a12dcb3	3b9c6e7a-7f5b-4f6b-b435-ab0bbb6df19d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d5f4930f-332d-4258-b6ad-b2bf7dbb2d7e	3b9c6e7a-7f5b-4f6b-b435-ab0bbb6df19d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
73ec3318-a027-48ef-8d44-bd51f122aea0	89cd6443-2ce5-4f7e-9340-b27331e87b6c	max-clients	200
7c226cc3-0859-4427-ba3a-c14f715bd419	8a38eb0e-a736-4a5d-aa0f-e1cdc9b9b807	allow-default-scopes	true
7d6f0aa8-20ff-4db5-95bd-7b02d9c99b2f	eb7060bf-4ac3-46bf-bee3-0b6e569b7fc5	allowed-protocol-mapper-types	saml-role-list-mapper
7d82ba52-56d8-4647-802b-10aaa8e2b91d	eb7060bf-4ac3-46bf-bee3-0b6e569b7fc5	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
14674a72-7748-4448-8b60-147e8a6f23e0	eb7060bf-4ac3-46bf-bee3-0b6e569b7fc5	allowed-protocol-mapper-types	saml-user-property-mapper
174f2852-1f16-40ad-8d69-ce4ddea35592	eb7060bf-4ac3-46bf-bee3-0b6e569b7fc5	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
8546ff50-abdb-4bb3-91e9-6008e146f04f	eb7060bf-4ac3-46bf-bee3-0b6e569b7fc5	allowed-protocol-mapper-types	saml-user-attribute-mapper
fe823706-7cf9-4bff-8d19-5831455334e2	eb7060bf-4ac3-46bf-bee3-0b6e569b7fc5	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1a9f9fb0-142b-43ee-b25d-80136117a758	eb7060bf-4ac3-46bf-bee3-0b6e569b7fc5	allowed-protocol-mapper-types	oidc-full-name-mapper
35385d8b-cb48-44a8-b3b3-3a18c39fb899	eb7060bf-4ac3-46bf-bee3-0b6e569b7fc5	allowed-protocol-mapper-types	oidc-address-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.composite_role (composite, child_role) FROM stdin;
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	1faf54d7-26e7-406b-aa19-0fc24e63409a
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	14fede5b-ed64-4a22-9a77-8cc0dbee25a9
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	96931b1c-ee8b-4485-87cc-eadcf71f1ecd
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	ba4fa631-49d6-4062-8d8a-9244755562cd
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	9d2f164f-9ce1-427d-8818-eb01642f99fe
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	212eece6-858a-49d9-860f-07c4bed0a15a
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	6ba74b2a-3f7d-4eac-a3ea-23465133a63c
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	419f2f9f-7892-4adc-b45e-0714e35dc86b
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	f2eb050e-223d-4112-9917-1ac58c4d9649
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	42dbcbaa-a774-41e3-89e3-06cfbca47c67
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	d7d1a059-4ee0-41be-9bbe-de1492ba6f69
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	388be970-2b73-4b9e-8711-de1e303e6a29
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	527c45d9-f8a9-43f1-ab37-5b08be126996
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	94096c6f-a278-45ce-b0f9-7ca005fdba8a
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	808a7064-2453-475c-9d5b-4f68a1aa769d
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	5d04dd01-fb03-4ef0-8ba8-40a66ca47d7e
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	cb1ed0bc-1538-4547-9763-df6817003c59
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	f796853b-df5c-4268-b055-ab192ed66b74
9d2f164f-9ce1-427d-8818-eb01642f99fe	5d04dd01-fb03-4ef0-8ba8-40a66ca47d7e
ba4fa631-49d6-4062-8d8a-9244755562cd	f796853b-df5c-4268-b055-ab192ed66b74
ba4fa631-49d6-4062-8d8a-9244755562cd	808a7064-2453-475c-9d5b-4f68a1aa769d
becb0a78-f494-41ac-af29-fd1e9e1846f2	b4baeba7-067d-454d-b8c5-6a05f689d608
becb0a78-f494-41ac-af29-fd1e9e1846f2	3b3c65ef-cfa1-4157-af41-1dbbbf466987
3b3c65ef-cfa1-4157-af41-1dbbbf466987	c2013f0e-54ca-4c3f-8c88-0214b879e067
80261623-6384-46c3-b6f4-a93e832fc658	9b93f5cd-b3ba-46ab-9894-44ddd8c92940
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	81ee01c6-a3d0-4c71-ae61-cfd899771da5
becb0a78-f494-41ac-af29-fd1e9e1846f2	faf59957-e96e-43f0-a443-7cad62e9149d
becb0a78-f494-41ac-af29-fd1e9e1846f2	e4c21e1b-e670-4e29-a06a-6d41f3eb5a86
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	72a011e7-748a-4232-b1f0-ea6deaa99859
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	cf801b92-11b2-43b9-8099-4d6d071f8025
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	f1cdef04-edfb-4d82-ae21-2e1b6a7ad964
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	f5506ff8-febd-4c1e-8cdb-d9711b371c25
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	513370d2-7503-4456-93db-2bb4cdb611a9
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	68d9f22f-8588-45f2-ac94-526e307b8791
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	a3d5ebc3-e5bb-4e60-be23-938b13fd2d61
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	1bfaa893-63d9-4a04-a75f-253f2c2acce6
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	6dbad5c5-7f5f-4cbd-99cf-b71af22bf525
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	9517d3d9-95df-41bd-9841-614e0d68eaf0
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	4052ef5d-b7b7-461e-a4bd-d7f0cf9fe16e
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	7976033b-597d-4aed-8b7b-af1efb17ea59
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	e98c44c6-c19b-4446-8de5-046989b5250c
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	8d090dc3-0552-4e3d-b30a-1725f699fce0
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	56fa1ce8-812c-4508-90fb-3709ef05f380
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	569d7bb1-7043-4fb2-8292-f19747b0f35b
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	6b9a3ec7-7aca-422c-867c-2ac3fc1077b1
f5506ff8-febd-4c1e-8cdb-d9711b371c25	56fa1ce8-812c-4508-90fb-3709ef05f380
f1cdef04-edfb-4d82-ae21-2e1b6a7ad964	8d090dc3-0552-4e3d-b30a-1725f699fce0
f1cdef04-edfb-4d82-ae21-2e1b6a7ad964	6b9a3ec7-7aca-422c-867c-2ac3fc1077b1
4c77b612-ef6a-47c4-8821-60624d68d1aa	dd95cc94-d412-446b-843f-bc8786670830
4c77b612-ef6a-47c4-8821-60624d68d1aa	12956fc2-54e5-448c-be7c-6f1cbb576044
4c77b612-ef6a-47c4-8821-60624d68d1aa	2d633d58-4f27-48d2-84e6-f3f8ec0c999e
4c77b612-ef6a-47c4-8821-60624d68d1aa	aacebb92-3539-4e9a-aef8-f7a45a5a30d6
4c77b612-ef6a-47c4-8821-60624d68d1aa	00249fae-6809-4b40-9b4f-8b850226ba89
4c77b612-ef6a-47c4-8821-60624d68d1aa	cb8bc2c7-f018-4317-886f-c408a83ff480
4c77b612-ef6a-47c4-8821-60624d68d1aa	ddfeccf5-1034-42f1-80cd-6c7d8c3b818a
4c77b612-ef6a-47c4-8821-60624d68d1aa	59b2f883-8259-4e5a-b12e-ec2077873542
4c77b612-ef6a-47c4-8821-60624d68d1aa	45230f50-c0d9-489a-98cb-b256db33fa79
4c77b612-ef6a-47c4-8821-60624d68d1aa	cca996ab-8231-4e85-88f9-7a3b7ce0c311
4c77b612-ef6a-47c4-8821-60624d68d1aa	04816420-e920-40b4-894f-663a47b18707
4c77b612-ef6a-47c4-8821-60624d68d1aa	1d9b6ce1-f662-4d1e-8b58-20a5c3d156fe
4c77b612-ef6a-47c4-8821-60624d68d1aa	3e1cf69a-a53a-46bf-97b1-136fcc11671f
4c77b612-ef6a-47c4-8821-60624d68d1aa	800c3ab0-cc66-4eea-a799-0441a89019a3
4c77b612-ef6a-47c4-8821-60624d68d1aa	938aaae7-a8c8-4bcc-8f95-6df1a26ba9e1
4c77b612-ef6a-47c4-8821-60624d68d1aa	bde3283e-9bac-475e-ba7f-77a1006d0576
4c77b612-ef6a-47c4-8821-60624d68d1aa	10b76f29-216e-4bab-a172-0b15ce14c60f
aacebb92-3539-4e9a-aef8-f7a45a5a30d6	938aaae7-a8c8-4bcc-8f95-6df1a26ba9e1
2d633d58-4f27-48d2-84e6-f3f8ec0c999e	10b76f29-216e-4bab-a172-0b15ce14c60f
2d633d58-4f27-48d2-84e6-f3f8ec0c999e	800c3ab0-cc66-4eea-a799-0441a89019a3
64b440b8-75d2-4a27-9391-54f9d17581ea	8fecdda7-a87d-4694-8226-8ad15af94a8c
64b440b8-75d2-4a27-9391-54f9d17581ea	12d1e022-1102-4e05-aeb7-4826e0633c91
12d1e022-1102-4e05-aeb7-4826e0633c91	9b02f36b-648c-4820-9dbe-13ce7d12dbe7
bad6d2d0-72a8-43e4-9f08-94d130ef971e	895b5796-afa9-4d6d-85cf-e73826c31afb
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	46a23ae1-eee7-4104-9e50-b963d4d1ee79
4c77b612-ef6a-47c4-8821-60624d68d1aa	cb947cfb-de30-4a54-b997-a365fb12fadb
64b440b8-75d2-4a27-9391-54f9d17581ea	85218571-5a13-4ab8-be3a-96f7e860c605
64b440b8-75d2-4a27-9391-54f9d17581ea	a1cca6da-c55e-4c27-b056-6933c6f2d95e
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
26b9001a-5ac0-41aa-9234-a27a4020c717	\N	password	e395744f-9137-491c-a1b5-488804efc31f	1675355324261	\N	{"value":"+J9ANUS00T9BkVmglPCWUPVO8blBYqVDX0QalmDc0cruvO8d6kHrBSaLDRtwLe75XaIwCt2YNO/33Tx7k1KykA==","salt":"aialnnaq1gJ0uxdSxlxDHg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
8fbbc1e9-7d5d-4db5-9bf9-1807a86e40f0	\N	password	a52ce474-8225-4628-ba09-5a82e41a6c34	1675355710147	\N	{"value":"N1h89mB7SawZKXAk+yzRLwBjeWe10cuzJOd2ibFyAgDIvgzQwOECbQiiDH6nwd/JY5qI9PV2msyFHDRXi+UCMg==","salt":"SKETY1rAsI+yUXnyjI7g/A==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-02-02 14:50:18.44636	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	5349418094
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-02-02 14:50:18.458042	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	5349418094
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-02-02 14:50:18.500055	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	5349418094
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-02-02 14:50:18.504664	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	5349418094
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-02-02 14:50:18.604269	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	5349418094
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-02-02 14:50:18.609005	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	5349418094
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-02-02 14:50:18.692445	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	5349418094
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-02-02 14:50:18.697161	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	5349418094
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-02-02 14:50:18.701979	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	5349418094
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-02-02 14:50:18.827086	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	5349418094
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-02-02 14:50:18.906438	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5349418094
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-02-02 14:50:18.913112	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5349418094
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-02-02 14:50:18.936879	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5349418094
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-02-02 14:50:18.959899	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	5349418094
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-02-02 14:50:18.962023	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5349418094
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-02-02 14:50:18.96406	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	5349418094
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-02-02 14:50:18.966115	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	5349418094
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-02-02 14:50:19.009733	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	5349418094
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-02-02 14:50:19.051315	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	5349418094
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-02-02 14:50:19.055826	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	5349418094
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-02-02 14:50:20.291507	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	5349418094
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-02-02 14:50:19.058232	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	5349418094
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-02-02 14:50:19.060886	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	5349418094
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-02-02 14:50:19.100969	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	5349418094
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-02-02 14:50:19.10639	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	5349418094
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-02-02 14:50:19.10863	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	5349418094
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-02-02 14:50:19.329089	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	5349418094
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-02-02 14:50:19.416007	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	5349418094
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-02-02 14:50:19.419203	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	5349418094
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-02-02 14:50:19.5025	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	5349418094
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-02-02 14:50:19.523166	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	5349418094
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-02-02 14:50:19.552992	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	5349418094
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-02-02 14:50:19.561625	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	5349418094
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-02-02 14:50:19.571276	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5349418094
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-02-02 14:50:19.57653	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	5349418094
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-02-02 14:50:19.61703	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	5349418094
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-02-02 14:50:19.621939	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	5349418094
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-02-02 14:50:19.629178	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5349418094
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-02-02 14:50:19.633091	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	5349418094
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-02-02 14:50:19.636892	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	5349418094
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-02-02 14:50:19.639101	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	5349418094
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-02-02 14:50:19.641497	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	5349418094
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-02-02 14:50:19.645612	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	5349418094
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-02-02 14:50:20.281778	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	5349418094
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-02-02 14:50:20.286966	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	5349418094
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-02-02 14:50:20.295689	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	5349418094
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-02-02 14:50:20.297801	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	5349418094
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-02-02 14:50:20.367631	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	5349418094
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-02-02 14:50:20.371911	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	5349418094
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-02-02 14:50:20.432956	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	5349418094
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-02-02 14:50:20.665513	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	5349418094
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-02-02 14:50:20.669609	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5349418094
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-02-02 14:50:20.672552	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	5349418094
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-02-02 14:50:20.67531	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	5349418094
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-02-02 14:50:20.68636	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	5349418094
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-02-02 14:50:20.698141	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	5349418094
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-02-02 14:50:20.733024	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	5349418094
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-02-02 14:50:20.919656	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	5349418094
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-02-02 14:50:20.946629	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	5349418094
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-02-02 14:50:20.951769	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	5349418094
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-02-02 14:50:20.958062	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	5349418094
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-02-02 14:50:20.964988	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	5349418094
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-02-02 14:50:20.968488	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	5349418094
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-02-02 14:50:20.970951	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	5349418094
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-02-02 14:50:20.973284	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	5349418094
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-02-02 14:50:20.996086	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	5349418094
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-02-02 14:50:21.011135	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	5349418094
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-02-02 14:50:21.015211	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	5349418094
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-02-02 14:50:21.031905	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	5349418094
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-02-02 14:50:21.036442	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	5349418094
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-02-02 14:50:21.039999	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	5349418094
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-02-02 14:50:21.044875	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5349418094
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-02-02 14:50:21.049675	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5349418094
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-02-02 14:50:21.051758	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5349418094
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-02-02 14:50:21.061801	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	5349418094
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-02-02 14:50:21.080662	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	5349418094
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-02-02 14:50:21.083976	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	5349418094
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-02-02 14:50:21.085705	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	5349418094
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-02-02 14:50:21.105697	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	5349418094
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-02-02 14:50:21.110181	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	5349418094
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-02-02 14:50:21.144857	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	5349418094
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-02-02 14:50:21.147298	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5349418094
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-02-02 14:50:21.151833	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5349418094
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-02-02 14:50:21.153964	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5349418094
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-02-02 14:50:21.169933	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	5349418094
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-02-02 14:50:21.174508	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	5349418094
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-02-02 14:50:21.180287	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	5349418094
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-02-02 14:50:21.192229	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	5349418094
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-02-02 14:50:21.197473	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	5349418094
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-02-02 14:50:21.202738	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	5349418094
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-02-02 14:50:21.217433	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5349418094
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-02-02 14:50:21.223261	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	5349418094
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-02-02 14:50:21.225371	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	5349418094
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-02-02 14:50:21.233882	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	5349418094
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-02-02 14:50:21.236068	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	5349418094
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-02-02 14:50:21.240378	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	5349418094
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-02-02 14:50:21.277308	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5349418094
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-02-02 14:50:21.279272	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5349418094
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-02-02 14:50:21.286994	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5349418094
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-02-02 14:50:21.303498	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5349418094
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-02-02 14:50:21.305678	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5349418094
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-02-02 14:50:21.321327	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	5349418094
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-02-02 14:50:21.324684	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	5349418094
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-02-02 14:50:21.329388	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	5349418094
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	abfd8b39-f065-4862-82d9-1a1ed8273bc7	f
master	e083d442-9125-4b10-9ec1-27e8fe6a286d	t
master	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4	t
master	4c8c7fec-7401-4549-b96d-c5d63adf1971	t
master	09e1062e-9b80-4b9a-9196-79e852ba3288	f
master	82a71695-8f28-40ad-9e6c-efc965a82b68	f
master	b4be1054-0cdc-49c5-bc73-055d8da3933c	t
master	09d26c1c-e365-476e-be1b-9a2eb90c750b	t
master	295004d4-ae34-4135-9093-7b35a1f9df31	f
App	cba4b270-00c3-4930-aaae-d53dfb43b5c3	f
App	e5aa98e6-a31e-41f0-aaca-c99a52473689	t
App	2ab8bc7f-7373-4a64-ac43-13b2419af337	t
App	9775950f-5ca6-4e0b-8358-55ff4eae5144	t
App	15a581f1-7876-468a-a959-d8e8cced7906	f
App	c84e32dd-96aa-416c-87de-00b29660bbac	f
App	ea79f985-5024-4c5b-b2c7-ab78edf9f130	t
App	5b864830-f859-44e6-814d-251210334c72	t
App	be0cd9db-06d7-4cbf-8722-608b252ebdba	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
becb0a78-f494-41ac-af29-fd1e9e1846f2	master	f	${role_default-roles}	default-roles-master	master	\N	\N
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	master	f	${role_admin}	admin	master	\N	\N
1faf54d7-26e7-406b-aa19-0fc24e63409a	master	f	${role_create-realm}	create-realm	master	\N	\N
14fede5b-ed64-4a22-9a77-8cc0dbee25a9	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_create-client}	create-client	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
96931b1c-ee8b-4485-87cc-eadcf71f1ecd	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_view-realm}	view-realm	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
ba4fa631-49d6-4062-8d8a-9244755562cd	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_view-users}	view-users	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
9d2f164f-9ce1-427d-8818-eb01642f99fe	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_view-clients}	view-clients	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
212eece6-858a-49d9-860f-07c4bed0a15a	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_view-events}	view-events	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
6ba74b2a-3f7d-4eac-a3ea-23465133a63c	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_view-identity-providers}	view-identity-providers	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
419f2f9f-7892-4adc-b45e-0714e35dc86b	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_view-authorization}	view-authorization	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
f2eb050e-223d-4112-9917-1ac58c4d9649	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_manage-realm}	manage-realm	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
42dbcbaa-a774-41e3-89e3-06cfbca47c67	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_manage-users}	manage-users	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
d7d1a059-4ee0-41be-9bbe-de1492ba6f69	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_manage-clients}	manage-clients	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
388be970-2b73-4b9e-8711-de1e303e6a29	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_manage-events}	manage-events	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
527c45d9-f8a9-43f1-ab37-5b08be126996	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_manage-identity-providers}	manage-identity-providers	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
94096c6f-a278-45ce-b0f9-7ca005fdba8a	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_manage-authorization}	manage-authorization	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
808a7064-2453-475c-9d5b-4f68a1aa769d	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_query-users}	query-users	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
5d04dd01-fb03-4ef0-8ba8-40a66ca47d7e	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_query-clients}	query-clients	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
cb1ed0bc-1538-4547-9763-df6817003c59	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_query-realms}	query-realms	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
f796853b-df5c-4268-b055-ab192ed66b74	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_query-groups}	query-groups	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
b4baeba7-067d-454d-b8c5-6a05f689d608	8d28d30b-6f86-4660-bb86-5675f4d7c84b	t	${role_view-profile}	view-profile	master	8d28d30b-6f86-4660-bb86-5675f4d7c84b	\N
3b3c65ef-cfa1-4157-af41-1dbbbf466987	8d28d30b-6f86-4660-bb86-5675f4d7c84b	t	${role_manage-account}	manage-account	master	8d28d30b-6f86-4660-bb86-5675f4d7c84b	\N
c2013f0e-54ca-4c3f-8c88-0214b879e067	8d28d30b-6f86-4660-bb86-5675f4d7c84b	t	${role_manage-account-links}	manage-account-links	master	8d28d30b-6f86-4660-bb86-5675f4d7c84b	\N
47d2057f-a2c3-40ac-bb08-33de8143339b	8d28d30b-6f86-4660-bb86-5675f4d7c84b	t	${role_view-applications}	view-applications	master	8d28d30b-6f86-4660-bb86-5675f4d7c84b	\N
9b93f5cd-b3ba-46ab-9894-44ddd8c92940	8d28d30b-6f86-4660-bb86-5675f4d7c84b	t	${role_view-consent}	view-consent	master	8d28d30b-6f86-4660-bb86-5675f4d7c84b	\N
80261623-6384-46c3-b6f4-a93e832fc658	8d28d30b-6f86-4660-bb86-5675f4d7c84b	t	${role_manage-consent}	manage-consent	master	8d28d30b-6f86-4660-bb86-5675f4d7c84b	\N
b52aedd8-257c-49f4-b56e-e2193c4e1ceb	8d28d30b-6f86-4660-bb86-5675f4d7c84b	t	${role_delete-account}	delete-account	master	8d28d30b-6f86-4660-bb86-5675f4d7c84b	\N
abd6fcd2-7ce6-434a-ba74-72f332eaa5e0	6748f472-1b4e-43fa-8f69-93ffbd2ab457	t	${role_read-token}	read-token	master	6748f472-1b4e-43fa-8f69-93ffbd2ab457	\N
81ee01c6-a3d0-4c71-ae61-cfd899771da5	096f72b6-3b44-41a3-8c2e-0d8c275da221	t	${role_impersonation}	impersonation	master	096f72b6-3b44-41a3-8c2e-0d8c275da221	\N
faf59957-e96e-43f0-a443-7cad62e9149d	master	f	${role_offline-access}	offline_access	master	\N	\N
e4c21e1b-e670-4e29-a06a-6d41f3eb5a86	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
64b440b8-75d2-4a27-9391-54f9d17581ea	App	f	${role_default-roles}	default-roles-app	App	\N	\N
72a011e7-748a-4232-b1f0-ea6deaa99859	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_create-client}	create-client	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
cf801b92-11b2-43b9-8099-4d6d071f8025	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_view-realm}	view-realm	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
f1cdef04-edfb-4d82-ae21-2e1b6a7ad964	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_view-users}	view-users	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
f5506ff8-febd-4c1e-8cdb-d9711b371c25	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_view-clients}	view-clients	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
513370d2-7503-4456-93db-2bb4cdb611a9	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_view-events}	view-events	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
68d9f22f-8588-45f2-ac94-526e307b8791	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_view-identity-providers}	view-identity-providers	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
a3d5ebc3-e5bb-4e60-be23-938b13fd2d61	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_view-authorization}	view-authorization	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
1bfaa893-63d9-4a04-a75f-253f2c2acce6	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_manage-realm}	manage-realm	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
6dbad5c5-7f5f-4cbd-99cf-b71af22bf525	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_manage-users}	manage-users	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
9517d3d9-95df-41bd-9841-614e0d68eaf0	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_manage-clients}	manage-clients	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
4052ef5d-b7b7-461e-a4bd-d7f0cf9fe16e	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_manage-events}	manage-events	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
7976033b-597d-4aed-8b7b-af1efb17ea59	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_manage-identity-providers}	manage-identity-providers	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
e98c44c6-c19b-4446-8de5-046989b5250c	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_manage-authorization}	manage-authorization	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
8d090dc3-0552-4e3d-b30a-1725f699fce0	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_query-users}	query-users	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
56fa1ce8-812c-4508-90fb-3709ef05f380	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_query-clients}	query-clients	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
569d7bb1-7043-4fb2-8292-f19747b0f35b	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_query-realms}	query-realms	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
6b9a3ec7-7aca-422c-867c-2ac3fc1077b1	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_query-groups}	query-groups	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
4c77b612-ef6a-47c4-8821-60624d68d1aa	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_realm-admin}	realm-admin	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
dd95cc94-d412-446b-843f-bc8786670830	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_create-client}	create-client	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
12956fc2-54e5-448c-be7c-6f1cbb576044	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_view-realm}	view-realm	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
2d633d58-4f27-48d2-84e6-f3f8ec0c999e	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_view-users}	view-users	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
aacebb92-3539-4e9a-aef8-f7a45a5a30d6	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_view-clients}	view-clients	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
00249fae-6809-4b40-9b4f-8b850226ba89	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_view-events}	view-events	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
cb8bc2c7-f018-4317-886f-c408a83ff480	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_view-identity-providers}	view-identity-providers	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
ddfeccf5-1034-42f1-80cd-6c7d8c3b818a	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_view-authorization}	view-authorization	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
59b2f883-8259-4e5a-b12e-ec2077873542	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_manage-realm}	manage-realm	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
45230f50-c0d9-489a-98cb-b256db33fa79	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_manage-users}	manage-users	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
cca996ab-8231-4e85-88f9-7a3b7ce0c311	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_manage-clients}	manage-clients	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
04816420-e920-40b4-894f-663a47b18707	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_manage-events}	manage-events	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
1d9b6ce1-f662-4d1e-8b58-20a5c3d156fe	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_manage-identity-providers}	manage-identity-providers	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
3e1cf69a-a53a-46bf-97b1-136fcc11671f	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_manage-authorization}	manage-authorization	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
800c3ab0-cc66-4eea-a799-0441a89019a3	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_query-users}	query-users	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
938aaae7-a8c8-4bcc-8f95-6df1a26ba9e1	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_query-clients}	query-clients	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
bde3283e-9bac-475e-ba7f-77a1006d0576	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_query-realms}	query-realms	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
10b76f29-216e-4bab-a172-0b15ce14c60f	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_query-groups}	query-groups	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
8fecdda7-a87d-4694-8226-8ad15af94a8c	4f038b8e-0ad1-446b-9e90-ead3e85d653e	t	${role_view-profile}	view-profile	App	4f038b8e-0ad1-446b-9e90-ead3e85d653e	\N
12d1e022-1102-4e05-aeb7-4826e0633c91	4f038b8e-0ad1-446b-9e90-ead3e85d653e	t	${role_manage-account}	manage-account	App	4f038b8e-0ad1-446b-9e90-ead3e85d653e	\N
9b02f36b-648c-4820-9dbe-13ce7d12dbe7	4f038b8e-0ad1-446b-9e90-ead3e85d653e	t	${role_manage-account-links}	manage-account-links	App	4f038b8e-0ad1-446b-9e90-ead3e85d653e	\N
f2718aab-7043-417a-95d8-23197192bd4d	4f038b8e-0ad1-446b-9e90-ead3e85d653e	t	${role_view-applications}	view-applications	App	4f038b8e-0ad1-446b-9e90-ead3e85d653e	\N
895b5796-afa9-4d6d-85cf-e73826c31afb	4f038b8e-0ad1-446b-9e90-ead3e85d653e	t	${role_view-consent}	view-consent	App	4f038b8e-0ad1-446b-9e90-ead3e85d653e	\N
bad6d2d0-72a8-43e4-9f08-94d130ef971e	4f038b8e-0ad1-446b-9e90-ead3e85d653e	t	${role_manage-consent}	manage-consent	App	4f038b8e-0ad1-446b-9e90-ead3e85d653e	\N
03dcf816-a4bb-4b49-a5d9-83158635c34e	4f038b8e-0ad1-446b-9e90-ead3e85d653e	t	${role_delete-account}	delete-account	App	4f038b8e-0ad1-446b-9e90-ead3e85d653e	\N
46a23ae1-eee7-4104-9e50-b963d4d1ee79	399902fb-36bf-406f-b2f8-8c5184e7a293	t	${role_impersonation}	impersonation	master	399902fb-36bf-406f-b2f8-8c5184e7a293	\N
cb947cfb-de30-4a54-b997-a365fb12fadb	790e9137-6d96-4c13-a099-ab842c14f32b	t	${role_impersonation}	impersonation	App	790e9137-6d96-4c13-a099-ab842c14f32b	\N
8a85f4b6-63d5-42e5-b096-2f6086f7b84f	5da2b98f-cfdc-41fa-8ca3-df2c043e9337	t	${role_read-token}	read-token	App	5da2b98f-cfdc-41fa-8ca3-df2c043e9337	\N
85218571-5a13-4ab8-be3a-96f7e860c605	App	f	${role_offline-access}	offline_access	App	\N	\N
a1cca6da-c55e-4c27-b056-6933c6f2d95e	App	f	${role_uma_authorization}	uma_authorization	App	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.migration_model (id, version, update_time) FROM stdin;
dyqct	16.1.1	1675349423
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
e9a9ad91-3d71-4e4a-ba4f-4445034e85a3	audience resolve	openid-connect	oidc-audience-resolve-mapper	b545aafd-591f-41e5-b26f-17435382e410	\N
f8204e26-8805-4313-861d-9218fb539545	locale	openid-connect	oidc-usermodel-attribute-mapper	9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	\N
f15d4f91-3e4c-4e72-95f1-0d5667c33b4d	role list	saml	saml-role-list-mapper	\N	e083d442-9125-4b10-9ec1-27e8fe6a286d
8f0e98a4-6ac7-42f1-a6ac-961a044a5d70	full name	openid-connect	oidc-full-name-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
aaec7ca0-c655-4fa0-9211-a47efd466b76	family name	openid-connect	oidc-usermodel-property-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
1d9d1b51-7131-42ab-bfeb-2b7cac5141ff	given name	openid-connect	oidc-usermodel-property-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
78d5170c-a219-469d-8fb5-f4418daf0839	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
1914d121-d234-490f-88ac-6b6c69648806	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
9d1eee94-9401-4df1-8c1b-0bf2c63419d7	username	openid-connect	oidc-usermodel-property-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
cb0cbe31-68bd-4770-9794-39af655cdc78	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
7b391e53-745d-4277-b628-d76720bb85ab	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
cb5ba5cf-b74e-4e0c-8476-82bfcc99de50	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
3212dfc2-af9b-488d-bd64-40a59da27a7c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
0ebbf248-8486-40ea-8b42-994552c90e52	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
7bef449b-a8e1-4d18-b4f2-180745e4c59c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
8864b1fd-216a-4a83-960d-74058491c3b4	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
8d476529-3aea-4edf-93a8-4cd03a5b1f53	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d0e46b5a-aa7b-46fd-a2e0-75015c5ed8a4
811f407e-e702-4a14-92b6-04a20e1cf185	email	openid-connect	oidc-usermodel-property-mapper	\N	4c8c7fec-7401-4549-b96d-c5d63adf1971
929e6a5c-f854-4651-96e8-b6bdc9ab1db1	email verified	openid-connect	oidc-usermodel-property-mapper	\N	4c8c7fec-7401-4549-b96d-c5d63adf1971
5f6bb45b-9b37-408c-968b-898409a03354	address	openid-connect	oidc-address-mapper	\N	09e1062e-9b80-4b9a-9196-79e852ba3288
97d0f453-b6fa-48ae-9c2e-792d84ea3bba	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	82a71695-8f28-40ad-9e6c-efc965a82b68
07937b20-f0a2-468b-839b-8254dfb9f411	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	82a71695-8f28-40ad-9e6c-efc965a82b68
e2f2a886-4ec2-43fc-8d51-952e8b8a0814	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	b4be1054-0cdc-49c5-bc73-055d8da3933c
a926c3a0-1ed0-4edb-bf27-3946c2cf359c	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	b4be1054-0cdc-49c5-bc73-055d8da3933c
757ba319-e905-42a8-9e82-4d8322322e01	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	b4be1054-0cdc-49c5-bc73-055d8da3933c
903af9ff-7134-4d5f-845c-dc18350d564a	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	09d26c1c-e365-476e-be1b-9a2eb90c750b
66db74df-60bd-4a63-bcfc-6155c7c6f12f	upn	openid-connect	oidc-usermodel-property-mapper	\N	295004d4-ae34-4135-9093-7b35a1f9df31
87bbd790-0b76-4883-8e4d-135ba01dd4cb	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	295004d4-ae34-4135-9093-7b35a1f9df31
bcdcb2d0-3f36-4296-a9cb-41aa467f3ff1	audience resolve	openid-connect	oidc-audience-resolve-mapper	86153581-a8b1-479c-b29c-061271c84de5	\N
ba235078-2d51-4619-8da1-be4ec8f14102	role list	saml	saml-role-list-mapper	\N	e5aa98e6-a31e-41f0-aaca-c99a52473689
dccfc900-05d1-4e81-8cb9-525918ce8b7a	full name	openid-connect	oidc-full-name-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
e71c6515-5891-4da9-8364-394981b20890	family name	openid-connect	oidc-usermodel-property-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
1ecf8708-2b84-4fdb-9649-1174191ae079	given name	openid-connect	oidc-usermodel-property-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
bbb1da75-bd01-4098-9ff6-486c5f1b97cf	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
0b7b3d7b-4b88-4d87-99a3-d0cefee96711	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
49bf4292-bbe2-4a3f-b414-6df1469a0b2f	username	openid-connect	oidc-usermodel-property-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
dbbe2af6-7293-407c-ae06-53c4ec13f945	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
42b8e6fb-0479-4a02-8390-03e901b488fa	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
e42a0f35-4696-47c5-b99d-fa8f408e7c85	website	openid-connect	oidc-usermodel-attribute-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
c55c6484-adf0-4b95-b675-a9e2f0d9de88	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
fff4ae0f-3e71-4aff-bd45-ed1278adeb97	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
ed5227b6-13de-4d8a-9c7b-7273a83c8216	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
d78c8cb7-ae41-43dd-b02f-9cc3c2828feb	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
f6fd85e8-f0ca-4c59-8dd5-c0b7a650f9d4	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	2ab8bc7f-7373-4a64-ac43-13b2419af337
3c3a4bcc-a3c3-4707-b941-99067f6275e4	email	openid-connect	oidc-usermodel-property-mapper	\N	9775950f-5ca6-4e0b-8358-55ff4eae5144
b772774c-4a53-42c1-ba89-17c7b1ec5b6d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	9775950f-5ca6-4e0b-8358-55ff4eae5144
635ba1b3-3ab7-47c7-86cb-51dd1d9d31b6	address	openid-connect	oidc-address-mapper	\N	15a581f1-7876-468a-a959-d8e8cced7906
0438fa97-1c7a-4c50-917e-5bfa608211b5	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	c84e32dd-96aa-416c-87de-00b29660bbac
b5f19975-9e19-4a56-a66b-5eaf7a28d4b2	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	c84e32dd-96aa-416c-87de-00b29660bbac
25690c35-984b-4e59-88d1-05341aca11c9	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	ea79f985-5024-4c5b-b2c7-ab78edf9f130
f0e88c46-d739-450b-bc63-3eb22869a817	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	ea79f985-5024-4c5b-b2c7-ab78edf9f130
91c61120-7b80-41ea-b47d-4af19d2435e6	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	ea79f985-5024-4c5b-b2c7-ab78edf9f130
639b5bc7-e960-433a-bca5-8f6d49810ac9	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	5b864830-f859-44e6-814d-251210334c72
2028aa2a-d418-48e3-aef5-c3577f1fe2a8	upn	openid-connect	oidc-usermodel-property-mapper	\N	be0cd9db-06d7-4cbf-8722-608b252ebdba
3b9d2130-a824-42c9-97d0-b879218c752b	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	be0cd9db-06d7-4cbf-8722-608b252ebdba
7be5590d-5871-4741-9e35-fd598a332371	locale	openid-connect	oidc-usermodel-attribute-mapper	36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
f8204e26-8805-4313-861d-9218fb539545	true	userinfo.token.claim
f8204e26-8805-4313-861d-9218fb539545	locale	user.attribute
f8204e26-8805-4313-861d-9218fb539545	true	id.token.claim
f8204e26-8805-4313-861d-9218fb539545	true	access.token.claim
f8204e26-8805-4313-861d-9218fb539545	locale	claim.name
f8204e26-8805-4313-861d-9218fb539545	String	jsonType.label
f15d4f91-3e4c-4e72-95f1-0d5667c33b4d	false	single
f15d4f91-3e4c-4e72-95f1-0d5667c33b4d	Basic	attribute.nameformat
f15d4f91-3e4c-4e72-95f1-0d5667c33b4d	Role	attribute.name
8f0e98a4-6ac7-42f1-a6ac-961a044a5d70	true	userinfo.token.claim
8f0e98a4-6ac7-42f1-a6ac-961a044a5d70	true	id.token.claim
8f0e98a4-6ac7-42f1-a6ac-961a044a5d70	true	access.token.claim
aaec7ca0-c655-4fa0-9211-a47efd466b76	true	userinfo.token.claim
aaec7ca0-c655-4fa0-9211-a47efd466b76	lastName	user.attribute
aaec7ca0-c655-4fa0-9211-a47efd466b76	true	id.token.claim
aaec7ca0-c655-4fa0-9211-a47efd466b76	true	access.token.claim
aaec7ca0-c655-4fa0-9211-a47efd466b76	family_name	claim.name
aaec7ca0-c655-4fa0-9211-a47efd466b76	String	jsonType.label
1d9d1b51-7131-42ab-bfeb-2b7cac5141ff	true	userinfo.token.claim
1d9d1b51-7131-42ab-bfeb-2b7cac5141ff	firstName	user.attribute
1d9d1b51-7131-42ab-bfeb-2b7cac5141ff	true	id.token.claim
1d9d1b51-7131-42ab-bfeb-2b7cac5141ff	true	access.token.claim
1d9d1b51-7131-42ab-bfeb-2b7cac5141ff	given_name	claim.name
1d9d1b51-7131-42ab-bfeb-2b7cac5141ff	String	jsonType.label
78d5170c-a219-469d-8fb5-f4418daf0839	true	userinfo.token.claim
78d5170c-a219-469d-8fb5-f4418daf0839	middleName	user.attribute
78d5170c-a219-469d-8fb5-f4418daf0839	true	id.token.claim
78d5170c-a219-469d-8fb5-f4418daf0839	true	access.token.claim
78d5170c-a219-469d-8fb5-f4418daf0839	middle_name	claim.name
78d5170c-a219-469d-8fb5-f4418daf0839	String	jsonType.label
1914d121-d234-490f-88ac-6b6c69648806	true	userinfo.token.claim
1914d121-d234-490f-88ac-6b6c69648806	nickname	user.attribute
1914d121-d234-490f-88ac-6b6c69648806	true	id.token.claim
1914d121-d234-490f-88ac-6b6c69648806	true	access.token.claim
1914d121-d234-490f-88ac-6b6c69648806	nickname	claim.name
1914d121-d234-490f-88ac-6b6c69648806	String	jsonType.label
9d1eee94-9401-4df1-8c1b-0bf2c63419d7	true	userinfo.token.claim
9d1eee94-9401-4df1-8c1b-0bf2c63419d7	username	user.attribute
9d1eee94-9401-4df1-8c1b-0bf2c63419d7	true	id.token.claim
9d1eee94-9401-4df1-8c1b-0bf2c63419d7	true	access.token.claim
9d1eee94-9401-4df1-8c1b-0bf2c63419d7	preferred_username	claim.name
9d1eee94-9401-4df1-8c1b-0bf2c63419d7	String	jsonType.label
cb0cbe31-68bd-4770-9794-39af655cdc78	true	userinfo.token.claim
cb0cbe31-68bd-4770-9794-39af655cdc78	profile	user.attribute
cb0cbe31-68bd-4770-9794-39af655cdc78	true	id.token.claim
cb0cbe31-68bd-4770-9794-39af655cdc78	true	access.token.claim
cb0cbe31-68bd-4770-9794-39af655cdc78	profile	claim.name
cb0cbe31-68bd-4770-9794-39af655cdc78	String	jsonType.label
7b391e53-745d-4277-b628-d76720bb85ab	true	userinfo.token.claim
7b391e53-745d-4277-b628-d76720bb85ab	picture	user.attribute
7b391e53-745d-4277-b628-d76720bb85ab	true	id.token.claim
7b391e53-745d-4277-b628-d76720bb85ab	true	access.token.claim
7b391e53-745d-4277-b628-d76720bb85ab	picture	claim.name
7b391e53-745d-4277-b628-d76720bb85ab	String	jsonType.label
cb5ba5cf-b74e-4e0c-8476-82bfcc99de50	true	userinfo.token.claim
cb5ba5cf-b74e-4e0c-8476-82bfcc99de50	website	user.attribute
cb5ba5cf-b74e-4e0c-8476-82bfcc99de50	true	id.token.claim
cb5ba5cf-b74e-4e0c-8476-82bfcc99de50	true	access.token.claim
cb5ba5cf-b74e-4e0c-8476-82bfcc99de50	website	claim.name
cb5ba5cf-b74e-4e0c-8476-82bfcc99de50	String	jsonType.label
3212dfc2-af9b-488d-bd64-40a59da27a7c	true	userinfo.token.claim
3212dfc2-af9b-488d-bd64-40a59da27a7c	gender	user.attribute
3212dfc2-af9b-488d-bd64-40a59da27a7c	true	id.token.claim
3212dfc2-af9b-488d-bd64-40a59da27a7c	true	access.token.claim
3212dfc2-af9b-488d-bd64-40a59da27a7c	gender	claim.name
3212dfc2-af9b-488d-bd64-40a59da27a7c	String	jsonType.label
0ebbf248-8486-40ea-8b42-994552c90e52	true	userinfo.token.claim
0ebbf248-8486-40ea-8b42-994552c90e52	birthdate	user.attribute
0ebbf248-8486-40ea-8b42-994552c90e52	true	id.token.claim
0ebbf248-8486-40ea-8b42-994552c90e52	true	access.token.claim
0ebbf248-8486-40ea-8b42-994552c90e52	birthdate	claim.name
0ebbf248-8486-40ea-8b42-994552c90e52	String	jsonType.label
7bef449b-a8e1-4d18-b4f2-180745e4c59c	true	userinfo.token.claim
7bef449b-a8e1-4d18-b4f2-180745e4c59c	zoneinfo	user.attribute
7bef449b-a8e1-4d18-b4f2-180745e4c59c	true	id.token.claim
7bef449b-a8e1-4d18-b4f2-180745e4c59c	true	access.token.claim
7bef449b-a8e1-4d18-b4f2-180745e4c59c	zoneinfo	claim.name
7bef449b-a8e1-4d18-b4f2-180745e4c59c	String	jsonType.label
8864b1fd-216a-4a83-960d-74058491c3b4	true	userinfo.token.claim
8864b1fd-216a-4a83-960d-74058491c3b4	locale	user.attribute
8864b1fd-216a-4a83-960d-74058491c3b4	true	id.token.claim
8864b1fd-216a-4a83-960d-74058491c3b4	true	access.token.claim
8864b1fd-216a-4a83-960d-74058491c3b4	locale	claim.name
8864b1fd-216a-4a83-960d-74058491c3b4	String	jsonType.label
8d476529-3aea-4edf-93a8-4cd03a5b1f53	true	userinfo.token.claim
8d476529-3aea-4edf-93a8-4cd03a5b1f53	updatedAt	user.attribute
8d476529-3aea-4edf-93a8-4cd03a5b1f53	true	id.token.claim
8d476529-3aea-4edf-93a8-4cd03a5b1f53	true	access.token.claim
8d476529-3aea-4edf-93a8-4cd03a5b1f53	updated_at	claim.name
8d476529-3aea-4edf-93a8-4cd03a5b1f53	String	jsonType.label
811f407e-e702-4a14-92b6-04a20e1cf185	true	userinfo.token.claim
811f407e-e702-4a14-92b6-04a20e1cf185	email	user.attribute
811f407e-e702-4a14-92b6-04a20e1cf185	true	id.token.claim
811f407e-e702-4a14-92b6-04a20e1cf185	true	access.token.claim
811f407e-e702-4a14-92b6-04a20e1cf185	email	claim.name
811f407e-e702-4a14-92b6-04a20e1cf185	String	jsonType.label
929e6a5c-f854-4651-96e8-b6bdc9ab1db1	true	userinfo.token.claim
929e6a5c-f854-4651-96e8-b6bdc9ab1db1	emailVerified	user.attribute
929e6a5c-f854-4651-96e8-b6bdc9ab1db1	true	id.token.claim
929e6a5c-f854-4651-96e8-b6bdc9ab1db1	true	access.token.claim
929e6a5c-f854-4651-96e8-b6bdc9ab1db1	email_verified	claim.name
929e6a5c-f854-4651-96e8-b6bdc9ab1db1	boolean	jsonType.label
5f6bb45b-9b37-408c-968b-898409a03354	formatted	user.attribute.formatted
5f6bb45b-9b37-408c-968b-898409a03354	country	user.attribute.country
5f6bb45b-9b37-408c-968b-898409a03354	postal_code	user.attribute.postal_code
5f6bb45b-9b37-408c-968b-898409a03354	true	userinfo.token.claim
5f6bb45b-9b37-408c-968b-898409a03354	street	user.attribute.street
5f6bb45b-9b37-408c-968b-898409a03354	true	id.token.claim
5f6bb45b-9b37-408c-968b-898409a03354	region	user.attribute.region
5f6bb45b-9b37-408c-968b-898409a03354	true	access.token.claim
5f6bb45b-9b37-408c-968b-898409a03354	locality	user.attribute.locality
97d0f453-b6fa-48ae-9c2e-792d84ea3bba	true	userinfo.token.claim
97d0f453-b6fa-48ae-9c2e-792d84ea3bba	phoneNumber	user.attribute
97d0f453-b6fa-48ae-9c2e-792d84ea3bba	true	id.token.claim
97d0f453-b6fa-48ae-9c2e-792d84ea3bba	true	access.token.claim
97d0f453-b6fa-48ae-9c2e-792d84ea3bba	phone_number	claim.name
97d0f453-b6fa-48ae-9c2e-792d84ea3bba	String	jsonType.label
07937b20-f0a2-468b-839b-8254dfb9f411	true	userinfo.token.claim
07937b20-f0a2-468b-839b-8254dfb9f411	phoneNumberVerified	user.attribute
07937b20-f0a2-468b-839b-8254dfb9f411	true	id.token.claim
07937b20-f0a2-468b-839b-8254dfb9f411	true	access.token.claim
07937b20-f0a2-468b-839b-8254dfb9f411	phone_number_verified	claim.name
07937b20-f0a2-468b-839b-8254dfb9f411	boolean	jsonType.label
e2f2a886-4ec2-43fc-8d51-952e8b8a0814	true	multivalued
e2f2a886-4ec2-43fc-8d51-952e8b8a0814	foo	user.attribute
e2f2a886-4ec2-43fc-8d51-952e8b8a0814	true	access.token.claim
e2f2a886-4ec2-43fc-8d51-952e8b8a0814	realm_access.roles	claim.name
e2f2a886-4ec2-43fc-8d51-952e8b8a0814	String	jsonType.label
a926c3a0-1ed0-4edb-bf27-3946c2cf359c	true	multivalued
a926c3a0-1ed0-4edb-bf27-3946c2cf359c	foo	user.attribute
a926c3a0-1ed0-4edb-bf27-3946c2cf359c	true	access.token.claim
a926c3a0-1ed0-4edb-bf27-3946c2cf359c	resource_access.${client_id}.roles	claim.name
a926c3a0-1ed0-4edb-bf27-3946c2cf359c	String	jsonType.label
66db74df-60bd-4a63-bcfc-6155c7c6f12f	true	userinfo.token.claim
66db74df-60bd-4a63-bcfc-6155c7c6f12f	username	user.attribute
66db74df-60bd-4a63-bcfc-6155c7c6f12f	true	id.token.claim
66db74df-60bd-4a63-bcfc-6155c7c6f12f	true	access.token.claim
66db74df-60bd-4a63-bcfc-6155c7c6f12f	upn	claim.name
66db74df-60bd-4a63-bcfc-6155c7c6f12f	String	jsonType.label
87bbd790-0b76-4883-8e4d-135ba01dd4cb	true	multivalued
87bbd790-0b76-4883-8e4d-135ba01dd4cb	foo	user.attribute
87bbd790-0b76-4883-8e4d-135ba01dd4cb	true	id.token.claim
87bbd790-0b76-4883-8e4d-135ba01dd4cb	true	access.token.claim
87bbd790-0b76-4883-8e4d-135ba01dd4cb	groups	claim.name
87bbd790-0b76-4883-8e4d-135ba01dd4cb	String	jsonType.label
ba235078-2d51-4619-8da1-be4ec8f14102	false	single
ba235078-2d51-4619-8da1-be4ec8f14102	Basic	attribute.nameformat
ba235078-2d51-4619-8da1-be4ec8f14102	Role	attribute.name
dccfc900-05d1-4e81-8cb9-525918ce8b7a	true	userinfo.token.claim
dccfc900-05d1-4e81-8cb9-525918ce8b7a	true	id.token.claim
dccfc900-05d1-4e81-8cb9-525918ce8b7a	true	access.token.claim
e71c6515-5891-4da9-8364-394981b20890	true	userinfo.token.claim
e71c6515-5891-4da9-8364-394981b20890	lastName	user.attribute
e71c6515-5891-4da9-8364-394981b20890	true	id.token.claim
e71c6515-5891-4da9-8364-394981b20890	true	access.token.claim
e71c6515-5891-4da9-8364-394981b20890	family_name	claim.name
e71c6515-5891-4da9-8364-394981b20890	String	jsonType.label
1ecf8708-2b84-4fdb-9649-1174191ae079	true	userinfo.token.claim
1ecf8708-2b84-4fdb-9649-1174191ae079	firstName	user.attribute
1ecf8708-2b84-4fdb-9649-1174191ae079	true	id.token.claim
1ecf8708-2b84-4fdb-9649-1174191ae079	true	access.token.claim
1ecf8708-2b84-4fdb-9649-1174191ae079	given_name	claim.name
1ecf8708-2b84-4fdb-9649-1174191ae079	String	jsonType.label
bbb1da75-bd01-4098-9ff6-486c5f1b97cf	true	userinfo.token.claim
bbb1da75-bd01-4098-9ff6-486c5f1b97cf	middleName	user.attribute
bbb1da75-bd01-4098-9ff6-486c5f1b97cf	true	id.token.claim
bbb1da75-bd01-4098-9ff6-486c5f1b97cf	true	access.token.claim
bbb1da75-bd01-4098-9ff6-486c5f1b97cf	middle_name	claim.name
bbb1da75-bd01-4098-9ff6-486c5f1b97cf	String	jsonType.label
0b7b3d7b-4b88-4d87-99a3-d0cefee96711	true	userinfo.token.claim
0b7b3d7b-4b88-4d87-99a3-d0cefee96711	nickname	user.attribute
0b7b3d7b-4b88-4d87-99a3-d0cefee96711	true	id.token.claim
0b7b3d7b-4b88-4d87-99a3-d0cefee96711	true	access.token.claim
0b7b3d7b-4b88-4d87-99a3-d0cefee96711	nickname	claim.name
0b7b3d7b-4b88-4d87-99a3-d0cefee96711	String	jsonType.label
49bf4292-bbe2-4a3f-b414-6df1469a0b2f	true	userinfo.token.claim
49bf4292-bbe2-4a3f-b414-6df1469a0b2f	username	user.attribute
49bf4292-bbe2-4a3f-b414-6df1469a0b2f	true	id.token.claim
49bf4292-bbe2-4a3f-b414-6df1469a0b2f	true	access.token.claim
49bf4292-bbe2-4a3f-b414-6df1469a0b2f	preferred_username	claim.name
49bf4292-bbe2-4a3f-b414-6df1469a0b2f	String	jsonType.label
dbbe2af6-7293-407c-ae06-53c4ec13f945	true	userinfo.token.claim
dbbe2af6-7293-407c-ae06-53c4ec13f945	profile	user.attribute
dbbe2af6-7293-407c-ae06-53c4ec13f945	true	id.token.claim
dbbe2af6-7293-407c-ae06-53c4ec13f945	true	access.token.claim
dbbe2af6-7293-407c-ae06-53c4ec13f945	profile	claim.name
dbbe2af6-7293-407c-ae06-53c4ec13f945	String	jsonType.label
42b8e6fb-0479-4a02-8390-03e901b488fa	true	userinfo.token.claim
42b8e6fb-0479-4a02-8390-03e901b488fa	picture	user.attribute
42b8e6fb-0479-4a02-8390-03e901b488fa	true	id.token.claim
42b8e6fb-0479-4a02-8390-03e901b488fa	true	access.token.claim
42b8e6fb-0479-4a02-8390-03e901b488fa	picture	claim.name
42b8e6fb-0479-4a02-8390-03e901b488fa	String	jsonType.label
e42a0f35-4696-47c5-b99d-fa8f408e7c85	true	userinfo.token.claim
e42a0f35-4696-47c5-b99d-fa8f408e7c85	website	user.attribute
e42a0f35-4696-47c5-b99d-fa8f408e7c85	true	id.token.claim
e42a0f35-4696-47c5-b99d-fa8f408e7c85	true	access.token.claim
e42a0f35-4696-47c5-b99d-fa8f408e7c85	website	claim.name
e42a0f35-4696-47c5-b99d-fa8f408e7c85	String	jsonType.label
c55c6484-adf0-4b95-b675-a9e2f0d9de88	true	userinfo.token.claim
c55c6484-adf0-4b95-b675-a9e2f0d9de88	gender	user.attribute
c55c6484-adf0-4b95-b675-a9e2f0d9de88	true	id.token.claim
c55c6484-adf0-4b95-b675-a9e2f0d9de88	true	access.token.claim
c55c6484-adf0-4b95-b675-a9e2f0d9de88	gender	claim.name
c55c6484-adf0-4b95-b675-a9e2f0d9de88	String	jsonType.label
fff4ae0f-3e71-4aff-bd45-ed1278adeb97	true	userinfo.token.claim
fff4ae0f-3e71-4aff-bd45-ed1278adeb97	birthdate	user.attribute
fff4ae0f-3e71-4aff-bd45-ed1278adeb97	true	id.token.claim
fff4ae0f-3e71-4aff-bd45-ed1278adeb97	true	access.token.claim
fff4ae0f-3e71-4aff-bd45-ed1278adeb97	birthdate	claim.name
fff4ae0f-3e71-4aff-bd45-ed1278adeb97	String	jsonType.label
ed5227b6-13de-4d8a-9c7b-7273a83c8216	true	userinfo.token.claim
ed5227b6-13de-4d8a-9c7b-7273a83c8216	zoneinfo	user.attribute
ed5227b6-13de-4d8a-9c7b-7273a83c8216	true	id.token.claim
ed5227b6-13de-4d8a-9c7b-7273a83c8216	true	access.token.claim
ed5227b6-13de-4d8a-9c7b-7273a83c8216	zoneinfo	claim.name
ed5227b6-13de-4d8a-9c7b-7273a83c8216	String	jsonType.label
d78c8cb7-ae41-43dd-b02f-9cc3c2828feb	true	userinfo.token.claim
d78c8cb7-ae41-43dd-b02f-9cc3c2828feb	locale	user.attribute
d78c8cb7-ae41-43dd-b02f-9cc3c2828feb	true	id.token.claim
d78c8cb7-ae41-43dd-b02f-9cc3c2828feb	true	access.token.claim
d78c8cb7-ae41-43dd-b02f-9cc3c2828feb	locale	claim.name
d78c8cb7-ae41-43dd-b02f-9cc3c2828feb	String	jsonType.label
f6fd85e8-f0ca-4c59-8dd5-c0b7a650f9d4	true	userinfo.token.claim
f6fd85e8-f0ca-4c59-8dd5-c0b7a650f9d4	updatedAt	user.attribute
f6fd85e8-f0ca-4c59-8dd5-c0b7a650f9d4	true	id.token.claim
f6fd85e8-f0ca-4c59-8dd5-c0b7a650f9d4	true	access.token.claim
f6fd85e8-f0ca-4c59-8dd5-c0b7a650f9d4	updated_at	claim.name
f6fd85e8-f0ca-4c59-8dd5-c0b7a650f9d4	String	jsonType.label
3c3a4bcc-a3c3-4707-b941-99067f6275e4	true	userinfo.token.claim
3c3a4bcc-a3c3-4707-b941-99067f6275e4	email	user.attribute
3c3a4bcc-a3c3-4707-b941-99067f6275e4	true	id.token.claim
3c3a4bcc-a3c3-4707-b941-99067f6275e4	true	access.token.claim
3c3a4bcc-a3c3-4707-b941-99067f6275e4	email	claim.name
3c3a4bcc-a3c3-4707-b941-99067f6275e4	String	jsonType.label
b772774c-4a53-42c1-ba89-17c7b1ec5b6d	true	userinfo.token.claim
b772774c-4a53-42c1-ba89-17c7b1ec5b6d	emailVerified	user.attribute
b772774c-4a53-42c1-ba89-17c7b1ec5b6d	true	id.token.claim
b772774c-4a53-42c1-ba89-17c7b1ec5b6d	true	access.token.claim
b772774c-4a53-42c1-ba89-17c7b1ec5b6d	email_verified	claim.name
b772774c-4a53-42c1-ba89-17c7b1ec5b6d	boolean	jsonType.label
635ba1b3-3ab7-47c7-86cb-51dd1d9d31b6	formatted	user.attribute.formatted
635ba1b3-3ab7-47c7-86cb-51dd1d9d31b6	country	user.attribute.country
635ba1b3-3ab7-47c7-86cb-51dd1d9d31b6	postal_code	user.attribute.postal_code
635ba1b3-3ab7-47c7-86cb-51dd1d9d31b6	true	userinfo.token.claim
635ba1b3-3ab7-47c7-86cb-51dd1d9d31b6	street	user.attribute.street
635ba1b3-3ab7-47c7-86cb-51dd1d9d31b6	true	id.token.claim
635ba1b3-3ab7-47c7-86cb-51dd1d9d31b6	region	user.attribute.region
635ba1b3-3ab7-47c7-86cb-51dd1d9d31b6	true	access.token.claim
635ba1b3-3ab7-47c7-86cb-51dd1d9d31b6	locality	user.attribute.locality
0438fa97-1c7a-4c50-917e-5bfa608211b5	true	userinfo.token.claim
0438fa97-1c7a-4c50-917e-5bfa608211b5	phoneNumber	user.attribute
0438fa97-1c7a-4c50-917e-5bfa608211b5	true	id.token.claim
0438fa97-1c7a-4c50-917e-5bfa608211b5	true	access.token.claim
0438fa97-1c7a-4c50-917e-5bfa608211b5	phone_number	claim.name
0438fa97-1c7a-4c50-917e-5bfa608211b5	String	jsonType.label
b5f19975-9e19-4a56-a66b-5eaf7a28d4b2	true	userinfo.token.claim
b5f19975-9e19-4a56-a66b-5eaf7a28d4b2	phoneNumberVerified	user.attribute
b5f19975-9e19-4a56-a66b-5eaf7a28d4b2	true	id.token.claim
b5f19975-9e19-4a56-a66b-5eaf7a28d4b2	true	access.token.claim
b5f19975-9e19-4a56-a66b-5eaf7a28d4b2	phone_number_verified	claim.name
b5f19975-9e19-4a56-a66b-5eaf7a28d4b2	boolean	jsonType.label
25690c35-984b-4e59-88d1-05341aca11c9	true	multivalued
25690c35-984b-4e59-88d1-05341aca11c9	foo	user.attribute
25690c35-984b-4e59-88d1-05341aca11c9	true	access.token.claim
25690c35-984b-4e59-88d1-05341aca11c9	realm_access.roles	claim.name
25690c35-984b-4e59-88d1-05341aca11c9	String	jsonType.label
f0e88c46-d739-450b-bc63-3eb22869a817	true	multivalued
f0e88c46-d739-450b-bc63-3eb22869a817	foo	user.attribute
f0e88c46-d739-450b-bc63-3eb22869a817	true	access.token.claim
f0e88c46-d739-450b-bc63-3eb22869a817	resource_access.${client_id}.roles	claim.name
f0e88c46-d739-450b-bc63-3eb22869a817	String	jsonType.label
2028aa2a-d418-48e3-aef5-c3577f1fe2a8	true	userinfo.token.claim
2028aa2a-d418-48e3-aef5-c3577f1fe2a8	username	user.attribute
2028aa2a-d418-48e3-aef5-c3577f1fe2a8	true	id.token.claim
2028aa2a-d418-48e3-aef5-c3577f1fe2a8	true	access.token.claim
2028aa2a-d418-48e3-aef5-c3577f1fe2a8	upn	claim.name
2028aa2a-d418-48e3-aef5-c3577f1fe2a8	String	jsonType.label
3b9d2130-a824-42c9-97d0-b879218c752b	true	multivalued
3b9d2130-a824-42c9-97d0-b879218c752b	foo	user.attribute
3b9d2130-a824-42c9-97d0-b879218c752b	true	id.token.claim
3b9d2130-a824-42c9-97d0-b879218c752b	true	access.token.claim
3b9d2130-a824-42c9-97d0-b879218c752b	groups	claim.name
3b9d2130-a824-42c9-97d0-b879218c752b	String	jsonType.label
7be5590d-5871-4741-9e35-fd598a332371	true	userinfo.token.claim
7be5590d-5871-4741-9e35-fd598a332371	locale	user.attribute
7be5590d-5871-4741-9e35-fd598a332371	true	id.token.claim
7be5590d-5871-4741-9e35-fd598a332371	true	access.token.claim
7be5590d-5871-4741-9e35-fd598a332371	locale	claim.name
7be5590d-5871-4741-9e35-fd598a332371	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	096f72b6-3b44-41a3-8c2e-0d8c275da221	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	cf8d37d8-831d-410a-84b6-129edc896b82	7757aff1-143f-483b-a2fc-ae5bc992a58c	3d2452e1-8fad-4c2b-b723-366664edd859	198bc148-ff66-4d0a-9ac3-b8af1209b44e	45703785-4db8-4d88-9c36-8f882d25210c	2592000	f	900	t	f	469549d3-8036-4049-a59b-4ea91231b0c7	0	f	0	0	becb0a78-f494-41ac-af29-fd1e9e1846f2
App	60	300	300	\N	\N	\N	t	f	0	\N	App	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	399902fb-36bf-406f-b2f8-8c5184e7a293	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	8c063474-f70a-4bc1-82df-064d15376e8c	9cca84ba-be69-48ba-80c0-87353744f540	840c623a-b243-49e2-8068-e4147fc56a14	0bad4002-d028-442f-85ca-28a21521807d	80b98a00-d4f6-4465-91e0-c2cf2450f0ce	2592000	f	900	t	f	d0eb7ac1-0819-4ba9-acb0-6fcfb603ee83	0	f	0	0	64b440b8-75d2-4a27-9391-54f9d17581ea
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
_browser_header.contentSecurityPolicyReportOnly	App
_browser_header.xContentTypeOptions	App	nosniff
_browser_header.xRobotsTag	App	none
_browser_header.xFrameOptions	App	SAMEORIGIN
_browser_header.contentSecurityPolicy	App	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	App	1; mode=block
_browser_header.strictTransportSecurity	App	max-age=31536000; includeSubDomains
bruteForceProtected	App	false
permanentLockout	App	false
maxFailureWaitSeconds	App	900
minimumQuickLoginWaitSeconds	App	60
waitIncrementSeconds	App	60
quickLoginCheckMilliSeconds	App	1000
maxDeltaTimeSeconds	App	43200
failureFactor	App	30
defaultSignatureAlgorithm	App	RS256
offlineSessionMaxLifespanEnabled	App	false
offlineSessionMaxLifespan	App	5184000
actionTokenGeneratedByAdminLifespan	App	43200
actionTokenGeneratedByUserLifespan	App	300
oauth2DeviceCodeLifespan	App	600
oauth2DevicePollingInterval	App	5
webAuthnPolicyRpEntityName	App	keycloak
webAuthnPolicySignatureAlgorithms	App	ES256
webAuthnPolicyRpId	App
webAuthnPolicyAttestationConveyancePreference	App	not specified
webAuthnPolicyAuthenticatorAttachment	App	not specified
webAuthnPolicyRequireResidentKey	App	not specified
webAuthnPolicyUserVerificationRequirement	App	not specified
webAuthnPolicyCreateTimeout	App	0
webAuthnPolicyAvoidSameAuthenticatorRegister	App	false
webAuthnPolicyRpEntityNamePasswordless	App	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	App	ES256
webAuthnPolicyRpIdPasswordless	App
webAuthnPolicyAttestationConveyancePreferencePasswordless	App	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	App	not specified
webAuthnPolicyRequireResidentKeyPasswordless	App	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	App	not specified
webAuthnPolicyCreateTimeoutPasswordless	App	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	App	false
cibaBackchannelTokenDeliveryMode	App	poll
cibaExpiresIn	App	120
cibaInterval	App	5
cibaAuthRequestedUserHint	App	login_hint
parRequestUriLifespan	App	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
App	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	App
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.redirect_uris (client_id, value) FROM stdin;
8d28d30b-6f86-4660-bb86-5675f4d7c84b	/realms/master/account/*
b545aafd-591f-41e5-b26f-17435382e410	/realms/master/account/*
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	/admin/master/console/*
4f038b8e-0ad1-446b-9e90-ead3e85d653e	/realms/App/account/*
86153581-a8b1-479c-b29c-061271c84de5	/realms/App/account/*
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	/admin/App/console/*
beba6298-e40f-445e-ab0d-233b70a7d5cc	http://localhost/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
d3e6f8b5-530b-4625-8be3-573d5ef049a0	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
d8f12697-43a2-4f1d-809f-36706a33f27c	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
16e8d2e3-8bcf-4de4-bf2f-f916e6121a72	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
4a81a60c-0674-4ed8-ab43-beb8065bbb75	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
5c47719c-35dd-4ab0-8616-34a80ea03c2f	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
557ebfd5-c701-4107-a05f-39c342851646	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
17b8c38e-07ae-4d69-9e5d-b7db4107bed7	delete_account	Delete Account	master	f	f	delete_account	60
be56a3b0-8db6-457d-a701-20641a1cf9bb	VERIFY_EMAIL	Verify Email	App	t	f	VERIFY_EMAIL	50
1fd76fa3-3655-47ca-a976-8d45bb90535b	UPDATE_PROFILE	Update Profile	App	t	f	UPDATE_PROFILE	40
ef55a437-ceef-4328-b220-556cd979b228	CONFIGURE_TOTP	Configure OTP	App	t	f	CONFIGURE_TOTP	10
a92fc82d-d491-4446-8033-15e74aa6a780	UPDATE_PASSWORD	Update Password	App	t	f	UPDATE_PASSWORD	30
335a2d3e-1954-4d5d-9cc9-24d020a1f339	terms_and_conditions	Terms and Conditions	App	f	f	terms_and_conditions	20
28f7d6e1-51e8-4df8-860b-1e30b646f5dc	update_user_locale	Update User Locale	App	t	f	update_user_locale	1000
b7689e5e-9ba9-42a1-8771-285ee7fed1f7	delete_account	Delete Account	App	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
b545aafd-591f-41e5-b26f-17435382e410	3b3c65ef-cfa1-4157-af41-1dbbbf466987
86153581-a8b1-479c-b29c-061271c84de5	12d1e022-1102-4e05-aeb7-4826e0633c91
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
e395744f-9137-491c-a1b5-488804efc31f	\N	49327809-9b79-4f0c-a9ea-1878ddb8b268	f	t	\N	\N	\N	master	dev	1675355324226	\N	0
a52ce474-8225-4628-ba09-5a82e41a6c34	dev@dev.local	dev@dev.local	t	t	\N	\N	\N	App	dev	1675355695042	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
becb0a78-f494-41ac-af29-fd1e9e1846f2	e395744f-9137-491c-a1b5-488804efc31f
d2009dc4-0bac-4f76-93fd-acf6124ba5ef	e395744f-9137-491c-a1b5-488804efc31f
72a011e7-748a-4232-b1f0-ea6deaa99859	e395744f-9137-491c-a1b5-488804efc31f
cf801b92-11b2-43b9-8099-4d6d071f8025	e395744f-9137-491c-a1b5-488804efc31f
f1cdef04-edfb-4d82-ae21-2e1b6a7ad964	e395744f-9137-491c-a1b5-488804efc31f
f5506ff8-febd-4c1e-8cdb-d9711b371c25	e395744f-9137-491c-a1b5-488804efc31f
513370d2-7503-4456-93db-2bb4cdb611a9	e395744f-9137-491c-a1b5-488804efc31f
68d9f22f-8588-45f2-ac94-526e307b8791	e395744f-9137-491c-a1b5-488804efc31f
a3d5ebc3-e5bb-4e60-be23-938b13fd2d61	e395744f-9137-491c-a1b5-488804efc31f
1bfaa893-63d9-4a04-a75f-253f2c2acce6	e395744f-9137-491c-a1b5-488804efc31f
6dbad5c5-7f5f-4cbd-99cf-b71af22bf525	e395744f-9137-491c-a1b5-488804efc31f
9517d3d9-95df-41bd-9841-614e0d68eaf0	e395744f-9137-491c-a1b5-488804efc31f
4052ef5d-b7b7-461e-a4bd-d7f0cf9fe16e	e395744f-9137-491c-a1b5-488804efc31f
7976033b-597d-4aed-8b7b-af1efb17ea59	e395744f-9137-491c-a1b5-488804efc31f
e98c44c6-c19b-4446-8de5-046989b5250c	e395744f-9137-491c-a1b5-488804efc31f
8d090dc3-0552-4e3d-b30a-1725f699fce0	e395744f-9137-491c-a1b5-488804efc31f
56fa1ce8-812c-4508-90fb-3709ef05f380	e395744f-9137-491c-a1b5-488804efc31f
569d7bb1-7043-4fb2-8292-f19747b0f35b	e395744f-9137-491c-a1b5-488804efc31f
6b9a3ec7-7aca-422c-867c-2ac3fc1077b1	e395744f-9137-491c-a1b5-488804efc31f
64b440b8-75d2-4a27-9391-54f9d17581ea	a52ce474-8225-4628-ba09-5a82e41a6c34
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: dev
--

COPY public.web_origins (client_id, value) FROM stdin;
9c3014cb-0ec9-4a5a-a22d-2a67f80a6879	+
36ea3c86-7dc5-436b-8a11-fb9e9498c9c9	+
beba6298-e40f-445e-ab0d-233b70a7d5cc	http://localhost:3323
beba6298-e40f-445e-ab0d-233b70a7d5cc	http://localhost
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: dev
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

