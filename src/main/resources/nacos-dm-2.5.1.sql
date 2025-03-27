

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS config_info;

CREATE TABLE config_info (
    id BIGINT IDENTITY(1,1) NOT NULL,
    data_id VARCHAR2(255) NOT NULL,
    group_id VARCHAR2(128),
    content CLOB NOT NULL,
    md5 VARCHAR2(32),
    gmt_create TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    src_user CLOB,
    src_ip VARCHAR2(50),
    app_name VARCHAR2(128),
    tenant_id VARCHAR2(128) DEFAULT '',
    c_desc VARCHAR2(256),
    c_use VARCHAR2(64),
    effect VARCHAR2(64),
    type VARCHAR2(64),
    c_schema CLOB,
    encrypted_data_key VARCHAR2(1024) NOT NULL DEFAULT '',
    PRIMARY KEY (id)
);
COMMENT ON TABLE config_info IS 'config_info';
COMMENT ON COLUMN config_info.id IS 'id';
COMMENT ON COLUMN config_info.data_id IS 'data_id';
COMMENT ON COLUMN config_info.group_id IS 'group_id';
COMMENT ON COLUMN config_info.content IS 'content';
COMMENT ON COLUMN config_info.md5 IS 'md5';
COMMENT ON COLUMN config_info.gmt_create IS '创建时间';
COMMENT ON COLUMN config_info.gmt_modified IS '修改时间';
COMMENT ON COLUMN config_info.src_user IS 'source user';
COMMENT ON COLUMN config_info.src_ip IS 'source ip';
COMMENT ON COLUMN config_info.app_name IS 'app_name';
COMMENT ON COLUMN config_info.c_desc IS 'configuration description';
COMMENT ON COLUMN config_info.c_use IS 'configuration usage';
COMMENT ON COLUMN config_info.effect IS '配置生效的描述';
COMMENT ON COLUMN config_info.type IS '配置的类型';
COMMENT ON COLUMN config_info.c_schema IS '配置的模式';
CREATE UNIQUE INDEX uk_configinfo_datagrouptenant ON config_info (data_id, group_id, tenant_id);



-- ----------------------------
-- Table structure for config_info_gray
-- ----------------------------
DROP TABLE IF EXISTS config_info_gray;

CREATE TABLE config_info_gray (
    id BIGINT IDENTITY(1,1) NOT NULL,
    data_id VARCHAR2(255) NOT NULL,
    group_id VARCHAR2(128) NOT NULL,
    content CLOB NOT NULL,
    md5 VARCHAR2(32),
    src_user CLOB,
    src_ip VARCHAR2(100),
    gmt_create TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    gmt_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    app_name VARCHAR2(128),
    tenant_id VARCHAR2(128) DEFAULT '',
    gray_name VARCHAR2(128) NOT NULL,
    gray_rule CLOB NOT NULL,
    encrypted_data_key VARCHAR2(256) NOT NULL DEFAULT '',
    PRIMARY KEY (id)
);
COMMENT ON TABLE config_info_gray IS 'config_info_gray';
COMMENT ON COLUMN config_info_gray.id IS 'id';
COMMENT ON COLUMN config_info_gray.data_id IS 'data_id';
COMMENT ON COLUMN config_info_gray.group_id IS 'group_id';
COMMENT ON COLUMN config_info_gray.content IS 'content';
COMMENT ON COLUMN config_info_gray.md5 IS 'md5';
COMMENT ON COLUMN config_info_gray.src_user IS 'src_user';
COMMENT ON COLUMN config_info_gray.src_ip IS 'src_ip';
COMMENT ON COLUMN config_info_gray.gmt_create IS 'gmt_create';
COMMENT ON COLUMN config_info_gray.gmt_modified IS 'gmt_modified';
COMMENT ON COLUMN config_info_gray.app_name IS 'app_name';
COMMENT ON COLUMN config_info_gray.gray_name IS 'gray_name';
COMMENT ON COLUMN config_info_gray.gray_rule IS 'gray_rule';
CREATE UNIQUE INDEX uk_configinfogray_datagrouptenantgray ON config_info_gray (data_id, group_id, tenant_id, gray_name);
CREATE  INDEX idx_dataid_gmt_modified ON config_info_gray (data_id, gmt_modified);
CREATE  INDEX idx_gmt_modified ON config_info_gray (gmt_modified);



-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS config_tags_relation;

CREATE TABLE config_tags_relation (
    id BIGINT NOT NULL,
    tag_name VARCHAR2(128) NOT NULL,
    tag_type VARCHAR2(64),
    data_id VARCHAR2(255) NOT NULL,
    group_id VARCHAR2(128) NOT NULL,
    tenant_id VARCHAR2(128) DEFAULT '',
    nid BIGINT IDENTITY(1,1) NOT NULL,
    PRIMARY KEY (nid)
);
COMMENT ON TABLE config_tags_relation IS 'config_tag_relation';
COMMENT ON COLUMN config_tags_relation.id IS 'id';
COMMENT ON COLUMN config_tags_relation.tag_name IS 'tag_name';
COMMENT ON COLUMN config_tags_relation.tag_type IS 'tag_type';
COMMENT ON COLUMN config_tags_relation.data_id IS 'data_id';
COMMENT ON COLUMN config_tags_relation.group_id IS 'group_id';
CREATE UNIQUE INDEX uk_configtagrelation_configidtag ON config_tags_relation (id, tag_name, tag_type);
CREATE  INDEX idx_tenant_id ON config_tags_relation (tenant_id);



-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS group_capacity;

CREATE TABLE group_capacity (
    id BIGINT IDENTITY(1,1) NOT NULL,
    group_id VARCHAR2(128) NOT NULL DEFAULT '',
    quota INTEGER NOT NULL DEFAULT '0',
    usage INTEGER NOT NULL DEFAULT '0',
    max_size INTEGER NOT NULL DEFAULT '0',
    max_aggr_count INTEGER NOT NULL DEFAULT '0',
    max_aggr_size INTEGER NOT NULL DEFAULT '0',
    max_history_count INTEGER NOT NULL DEFAULT '0',
    gmt_create TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE group_capacity IS '集群、各Group容量信息表';
COMMENT ON COLUMN group_capacity.id IS '主键ID';
COMMENT ON COLUMN group_capacity.quota IS '0';
COMMENT ON COLUMN group_capacity.usage IS '0';
COMMENT ON COLUMN group_capacity.max_size IS '0';
COMMENT ON COLUMN group_capacity.max_aggr_count IS '0';
COMMENT ON COLUMN group_capacity.max_aggr_size IS '0';
COMMENT ON COLUMN group_capacity.max_history_count IS '0';
COMMENT ON COLUMN group_capacity.gmt_create IS '创建时间';
COMMENT ON COLUMN group_capacity.gmt_modified IS '修改时间';
CREATE UNIQUE INDEX uk_group_id ON group_capacity (group_id);



-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS his_config_info;

CREATE TABLE his_config_info (
    id BIGINT NOT NULL,
    nid BIGINT IDENTITY(1,1) NOT NULL,
    data_id VARCHAR2(255) NOT NULL,
    group_id VARCHAR2(128) NOT NULL,
    app_name VARCHAR2(128),
    content CLOB NOT NULL,
    md5 VARCHAR2(32),
    gmt_create TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    src_user CLOB,
    src_ip VARCHAR2(50),
    op_type CHAR,
    tenant_id VARCHAR2(128) DEFAULT '',
    encrypted_data_key VARCHAR2(1024) NOT NULL DEFAULT '',
    publish_type VARCHAR2(50) DEFAULT 'FORMAL',
    gray_name VARCHAR2(50),
    ext_info CLOB,
    PRIMARY KEY (nid)
);
COMMENT ON TABLE his_config_info IS '多租户改造';
COMMENT ON COLUMN his_config_info.id IS 'id';
COMMENT ON COLUMN his_config_info.data_id IS 'data_id';
COMMENT ON COLUMN his_config_info.group_id IS 'group_id';
COMMENT ON COLUMN his_config_info.app_name IS 'app_name';
COMMENT ON COLUMN his_config_info.content IS 'content';
COMMENT ON COLUMN his_config_info.md5 IS 'md5';
COMMENT ON COLUMN his_config_info.gmt_create IS '创建时间';
COMMENT ON COLUMN his_config_info.gmt_modified IS '修改时间';
COMMENT ON COLUMN his_config_info.src_user IS 'source user';
COMMENT ON COLUMN his_config_info.src_ip IS 'source ip';
COMMENT ON COLUMN his_config_info.op_type IS 'operation type';
COMMENT ON COLUMN his_config_info.publish_type IS 'formal';
COMMENT ON COLUMN his_config_info.gray_name IS 'gray name';
COMMENT ON COLUMN his_config_info.ext_info IS 'ext info';
CREATE  INDEX idx_gmt_create ON his_config_info (gmt_create);
CREATE  INDEX idx_gmt_modified_his_config_info ON his_config_info (gmt_modified);
CREATE  INDEX idx_did ON his_config_info (data_id);



-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS permissions;

CREATE TABLE permissions (
    role VARCHAR2(50) NOT NULL,
    resource VARCHAR2(128) NOT NULL,
    action VARCHAR2(8) NOT NULL
);
COMMENT ON COLUMN permissions.role IS 'role';
COMMENT ON COLUMN permissions.resource IS 'resource';
COMMENT ON COLUMN permissions.action IS 'action';
CREATE UNIQUE INDEX uk_role_permission ON permissions (role, resource, action);



-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS roles;

CREATE TABLE roles (
    username VARCHAR2(50) NOT NULL,
    role VARCHAR2(50) NOT NULL
);
COMMENT ON COLUMN roles.username IS 'username';
COMMENT ON COLUMN roles.role IS 'role';
CREATE UNIQUE INDEX idx_user_role ON roles (username, role);



-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS tenant_capacity;

CREATE TABLE tenant_capacity (
    id BIGINT IDENTITY(1,1) NOT NULL,
    tenant_id VARCHAR2(128) NOT NULL DEFAULT '',
    quota INTEGER NOT NULL DEFAULT '0',
    usage INTEGER NOT NULL DEFAULT '0',
    max_size INTEGER NOT NULL DEFAULT '0',
    max_aggr_count INTEGER NOT NULL DEFAULT '0',
    max_aggr_size INTEGER NOT NULL DEFAULT '0',
    max_history_count INTEGER NOT NULL DEFAULT '0',
    gmt_create TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
COMMENT ON TABLE tenant_capacity IS '租户容量信息表';
COMMENT ON COLUMN tenant_capacity.id IS '主键ID';
COMMENT ON COLUMN tenant_capacity.quota IS '0';
COMMENT ON COLUMN tenant_capacity.usage IS '0';
COMMENT ON COLUMN tenant_capacity.max_size IS '0';
COMMENT ON COLUMN tenant_capacity.max_aggr_count IS '0';
COMMENT ON COLUMN tenant_capacity.max_aggr_size IS '0';
COMMENT ON COLUMN tenant_capacity.max_history_count IS '0';
COMMENT ON COLUMN tenant_capacity.gmt_create IS '创建时间';
COMMENT ON COLUMN tenant_capacity.gmt_modified IS '修改时间';
CREATE UNIQUE INDEX uk_tenant_id ON tenant_capacity (tenant_id);



-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS tenant_info;

CREATE TABLE tenant_info (
    id BIGINT IDENTITY(1,1) NOT NULL,
    kp VARCHAR2(128) NOT NULL,
    tenant_id VARCHAR2(128) DEFAULT '',
    tenant_name VARCHAR2(128) DEFAULT '',
    tenant_desc VARCHAR2(256),
    create_source VARCHAR2(32),
    gmt_create BIGINT NOT NULL,
    gmt_modified BIGINT NOT NULL,
    PRIMARY KEY (id)
);
COMMENT ON TABLE tenant_info IS 'tenant_info';
COMMENT ON COLUMN tenant_info.id IS 'id';
COMMENT ON COLUMN tenant_info.kp IS 'kp';
COMMENT ON COLUMN tenant_info.tenant_desc IS 'tenant_desc';
COMMENT ON COLUMN tenant_info.create_source IS 'create_source';
COMMENT ON COLUMN tenant_info.gmt_create IS '创建时间';
COMMENT ON COLUMN tenant_info.gmt_modified IS '修改时间';
CREATE UNIQUE INDEX uk_tenant_info_kptenantid ON tenant_info (kp, tenant_id);
CREATE  INDEX idx_tenant_id_tenant_info ON tenant_info (tenant_id);



-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    username VARCHAR2(50) NOT NULL,
    password VARCHAR2(500) NOT NULL,
    enabled SMALLINT NOT NULL,
    PRIMARY KEY (username)
);
COMMENT ON COLUMN users.username IS 'username';
COMMENT ON COLUMN users.password IS 'password';
COMMENT ON COLUMN users.enabled IS 'enabled';
