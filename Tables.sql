CREATE TABLE 'django_migrations' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'app' varchar(255) NOT NULL,
    'name' varchar(255) NOT NULL,
    'applied' datetime NOT NULL
);


CREATE TABLE 'django_content_type' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'name' varchar(100) NOT NULL,
    'app_label' varchar(100) NOT NULL,
    'model' varchar(100) NOT NULL
);


CREATE UNIQUE INDEX 'django_content_type_app_label_model_76bd3d3b_uniq' ON 'django_content_type' ('app_label', 'model');

CREATE UNIQUE INDEX 'django_content_type_app_label_model_76bd3d3b_uniq' ON 'django_content_type' ('app_label', 'model');

COMMIT;


CREATE TABLE 'auth_permission' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'name' varchar(50) NOT NULL,
    'content_type_id' integer NOT NULL REFERENCES 'django_content_type' ('id') DEFERRABLE INITIALLY DEFERRED,
    'codename' varchar(100) NOT NULL
);


CREATE TABLE 'auth_group' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'name' varchar(80) NOT NULL UNIQUE
);


CREATE TABLE 'auth_group_permissions' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'group_id' integer NOT NULL REFERENCES 'auth_group' ('id') DEFERRABLE INITIALLY DEFERRED,
    'permission_id' integer NOT NULL REFERENCES 'auth_permission' ('id') DEFERRABLE INITIALLY DEFERRED
);


CREATE TABLE 'auth_user' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'password' varchar(128) NOT NULL,
    'last_login' datetime NOT NULL,
    'is_superuser' bool NOT NULL,
    'username' varchar(30) NOT NULL UNIQUE,
    'first_name' varchar(30) NOT NULL,
    'last_name' varchar(30) NOT NULL,
    'email' varchar(75) NOT NULL,
    'is_staff' bool NOT NULL,
    'is_active' bool NOT NULL,
    'date_joined' datetime NOT NULL
);



CREATE TABLE 'auth_user_groups' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'user_id' integer NOT NULL REFERENCES 'auth_user' ('id') DEFERRABLE INITIALLY DEFERRED,
    'group_id' integer NOT NULL REFERENCES 'auth_group' ('id') DEFERRABLE INITIALLY DEFERRED
);


CREATE TABLE 'auth_user_user_permissions' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'user_id' integer NOT NULL REFERENCES 'auth_user' ('id') DEFERRABLE INITIALLY DEFERRED,
    'permission_id' integer NOT NULL REFERENCES 'auth_permission' ('id') DEFERRABLE INITIALLY DEFERRED
);


CREATE UNIQUE INDEX 'auth_permission_content_type_id_codename_01ab375a_uniq' ON 'auth_permission' ('content_type_id', 'codename');

CREATE INDEX 'auth_permission_content_type_id_2f476e4b' ON 'auth_permission' ('content_type_id');

CREATE UNIQUE INDEX 'auth_group_permissions_group_id_permission_id_0cd325b0_uniq' ON 'auth_group_permissions' ('group_id', 'permission_id');

CREATE INDEX 'auth_group_permissions_group_id_b120cbf9' ON 'auth_group_permissions' ('group_id');

CREATE INDEX 'auth_group_permissions_permission_id_84c5c92e' ON 'auth_group_permissions' ('permission_id');

CREATE UNIQUE INDEX 'auth_user_groups_user_id_group_id_94350c0c_uniq' ON 'auth_user_groups' ('user_id', 'group_id');


CREATE INDEX 'auth_user_groups_user_id_6a12ed8b' ON 'auth_user_groups' ('user_id');

CREATE INDEX 'auth_user_groups_group_id_97559544' ON 'auth_user_groups' ('group_id');

CREATE UNIQUE INDEX 'auth_user_user_permissions_user_id_permission_id_14a6b632_uniq' ON 'auth_user_user_permissions' ('user_id', 'permission_id');

CREATE INDEX 'auth_user_user_permissions_user_id_a95ead1b' ON 'auth_user_user_permissions' ('user_id');

CREATE INDEX 'auth_user_user_permissions_permission_id_1fbb5f2c' ON 'auth_user_user_permissions' ('permission_id');

CREATE TABLE 'django_admin_log' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'action_time' datetime NOT NULL,
    'object_id' text NULL,
    'object_repr' varchar(200) NOT NULL,
    'action_flag' smallint unsigned NOT NULL CHECK ('action_flag' >= 0),
    'change_message' text NOT NULL,
    'content_type_id' integer NULL REFERENCES 'django_content_type' ('id') DEFERRABLE INITIALLY DEFERRED,
    'user_id' integer NOT NULL REFERENCES 'auth_user' ('id') DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX 'django_admin_log_content_type_id_c4bce8eb' ON 'django_admin_log' ('content_type_id');

CREATE INDEX 'django_admin_log_user_id_c564eba6' ON 'django_admin_log' ('user_id');



CREATE TABLE 'new__django_admin_log' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'object_id' text NULL,
    'object_repr' varchar(200) NOT NULL,
    'action_flag' smallint unsigned NOT NULL CHECK ('action_flag' >= 0),
    'change_message' text NOT NULL,
    'content_type_id' integer NULL REFERENCES 'django_content_type' ('id') DEFERRABLE INITIALLY DEFERRED,
    'user_id' integer NOT NULL REFERENCES 'auth_user' ('id') DEFERRABLE INITIALLY DEFERRED,
    'action_time' datetime NOT NULL
);


DROP TABLE 'django_admin_log';


ALTER TABLE
    'new__django_admin_log' RENAME TO 'django_admin_log';


CREATE INDEX 'django_admin_log_content_type_id_c4bce8eb' ON 'django_admin_log' ('content_type_id');

CREATE INDEX 'django_admin_log_user_id_c564eba6' ON 'django_admin_log' ('user_id');

CREATE TABLE 'new__django_content_type' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'app_label' varchar(100) NOT NULL,
    'model' varchar(100) NOT NULL,
    'name' varchar(100) NULL
);

CREATE UNIQUE INDEX 'django_content_type_app_label_model_76bd3d3b_uniq' ON 'django_content_type' ('app_label', 'model');

CREATE TABLE 'new__auth_permission' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'content_type_id' integer NOT NULL REFERENCES 'django_content_type' ('id') DEFERRABLE INITIALLY DEFERRED,
    'codename' varchar(100) NOT NULL,
    'name' varchar(255) NOT NULL
);

CREATE TABLE 'new__auth_user' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'password' varchar(128) NOT NULL,
    'last_login' datetime NOT NULL,
    'is_superuser' bool NOT NULL,
    'username' varchar(30) NOT NULL UNIQUE,
    'first_name' varchar(30) NOT NULL,
    'last_name' varchar(30) NOT NULL,
    'is_staff' bool NOT NULL,
    'is_active' bool NOT NULL,
    'date_joined' datetime NOT NULL,
    'email' varchar(254) NOT NULL
);


CREATE TABLE 'new__auth_group' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'name' varchar(150) NOT NULL UNIQUE
);


CREATE TABLE 'menu_menuitem' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'name' varchar(100) NOT NULL,
    'price' decimal NOT NULL
);

CREATE TABLE 'order_order' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'created_at' datetime NOT NULL
);

CREATE TABLE 'order_orderitem' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'quantity' integer unsigned NOT NULL CHECK ('quantity' >= 0),
    'created' datetime NOT NULL,
    'item_id' bigint NOT NULL REFERENCES 'menu_menuitem' ('id') DEFERRABLE INITIALLY DEFERRED,
    'order_id' bigint NOT NULL REFERENCES 'order_order' ('id') DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE 'order_orderitem' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'quantity' integer unsigned NOT NULL CHECK ('quantity' >= 0),
    'created' datetime NOT NULL,
    'item_id' bigint NOT NULL REFERENCES 'menu_menuitem' ('id') DEFERRABLE INITIALLY DEFERRED,
    'order_id' bigint NOT NULL REFERENCES 'order_order' ('id') DEFERRABLE INITIALLY DEFERRED
);


CREATE TABLE 'new__order_order' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'created_at' datetime NOT NULL
);

CREATE INDEX 'order_orderitem_item_id_ade63ba0' ON 'order_orderitem' ('item_id');

CREATE INDEX 'order_orderitem_order_id_aba34f44' ON 'order_orderitem' ('order_id');


CREATE TABLE 'new__order_order' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'created_at' datetime NOT NULL,
    'user_id' integer NOT NULL REFERENCES 'auth_user' ('id') DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE 'delivery_delivery' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'address' varchar(255) NOT NULL,
    'delivered' bool NOT NULL,
    'delivery_date' date NOT NULL,
    'delivery_time' time NOT NULL,
    'order_id' bigint NOT NULL REFERENCES 'order_order' ('id') DEFERRABLE INITIALLY DEFERRED,
    'user_id' integer NOT NULL REFERENCES 'auth_user' ('id') DEFERRABLE INITIALLY DEFERRED
);


CREATE INDEX 'delivery_delivery_order_id_8307ff51' ON 'delivery_delivery' ('order_id');

CREATE INDEX 'delivery_delivery_user_id_569d0e2f' ON 'delivery_delivery' ('user_id');


CREATE TABLE 'reservation_reservation' (
    'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    'date' date NOT NULL,
    'time' time NOT NULL,
    'guest_name' varchar(225) NOT NULL,
    'created' datetime NOT NULL,
    'user_id' integer NOT NULL REFERENCES 'auth_user' ('id') DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX 'reservation_reservation_user_id_261c5876' ON 'reservation_reservation' ('user_id');

CREATE TABLE 'django_session' (
    'session_key' varchar(40) NOT NULL PRIMARY KEY,
    'session_data' text NOT NULL,
    'expire_date' datetime NOT NULL
);


CREATE INDEX 'django_session_expire_date_a5c62663' ON 'django_session' ('expire_date');
